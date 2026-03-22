import 'package:flutter/material.dart';
import 'package:planbee/widgets/base_picker_layout.dart';
import 'package:provider/provider.dart';

import '../../blocks/task/model.dart';
import '../../blocks/task/provider.dart';
import '../../blocks/task/repository.dart';
import '../../blocks/timer/provider.dart';
import '../../routes.dart';
import 'components/focus_duration_picker.dart';

class TaskDetailsController {
  final BuildContext context;
  final TaskModel task;

  TaskDetailsController(this.context, this.task);

  TaskModel get currentTask {
    final taskProvider = context.watch<TaskProvider>();
    return taskProvider.tasks.firstWhere(
          (t) => t.id == task.id,
      orElse: () => task,
    );
  }

  bool get isTaskCompleted {
    final taskProvider = context.watch<TaskProvider>();
    final currentTask = taskProvider.tasks.firstWhere(
            (t) => t.id == task.id,
        orElse: () => task
    );
    return currentTask.status == TaskStatus.completed;
  }

  bool getIsTaskCompletedRead() {
    final taskProvider = context.read<TaskProvider>();
    final currentTask = taskProvider.tasks.firstWhere(
            (t) => t.id == task.id,
        orElse: () => task
    );
    return currentTask.status == TaskStatus.completed;
  }

  bool get isTimerRunningForThisTask {
    final timer = context.watch<TimerProvider>();
    return timer.isRunning && timer.activeTaskId == task.id;
  }

  String get displayTime {
    final timer = context.watch<TimerProvider>();
    return timer.activeTaskId == task.id ? timer.formattedTime : "00:00";
  }

  double get displayProgress {
    final timer = context.watch<TimerProvider>();
    return timer.activeTaskId == task.id ? timer.progress : 0.0;
  }

  /// Start/Pause
  void onTimerButtonPressed() {
    final timerProvider = context.read<TimerProvider>();

    if (timerProvider.activeTaskId == null || timerProvider.activeTaskId != task.id) {
      timerProvider.stopTimer();
      timerProvider.startTimer(25, task.id);
      _updateStatus(TaskStatus.inProgress);
      return;
    }

    if (timerProvider.secondsRemaining <= 0) {
      timerProvider.startTimer(25, task.id);
      _updateStatus(TaskStatus.inProgress);
    } else {
      timerProvider.togglePause();
    }
  }

  /// Presets (15/30/45 min)
  void startPresetTimer(int minutes) {
    final timerProvider = context.read<TimerProvider>();
    timerProvider.startTimer(minutes, task.id);
    _updateStatus(TaskStatus.inProgress);
  }

  Future<void> markAsCompleted() async {
    final timerProvider = context.read<TimerProvider>();
    final taskProvider = context.read<TaskProvider>();

    if (timerProvider.activeTaskId == task.id) {
      timerProvider.stopTimer();
    }

    await TaskRepository().updateTaskStatus(task.id, TaskStatus.completed);
    taskProvider.updateTaskStatusLocally(task.id, TaskStatus.completed);
  }

  Future<void> showCustomTimerPicker() async {
    final Duration? pickedDuration = await BasePickerLayout.show<Duration>(
        context: context,
        child: FocusDurationPicker()
    );

    if (pickedDuration != null && pickedDuration.inMinutes > 0) {
      startPresetTimer(pickedDuration.inMinutes);
    }
  }

  void resetTimer() {
    final timerProvider = context.read<TimerProvider>();
    if (timerProvider.activeTaskId == task.id) {
      timerProvider.stopTimer();
      if (!getIsTaskCompletedRead()) {
        _updateStatus(TaskStatus.planned);
      }
    }
  }

  Future<void> toggleTaskStatus() async {
    final taskProvider = context.read<TaskProvider>();
    final timerProvider = context.read<TimerProvider>();

    final bool currentlyCompleted = getIsTaskCompletedRead();
    final newStatus = currentlyCompleted ? TaskStatus.planned : TaskStatus.completed;

    if (newStatus == TaskStatus.completed && timerProvider.activeTaskId == task.id) {
      timerProvider.stopTimer();
    }

    await TaskRepository().updateTaskStatus(task.id, newStatus);
    taskProvider.updateTaskStatusLocally(task.id, newStatus);
  }

  void navigateToEditTask(BuildContext context, TaskModel task) {
    Navigator.pushNamed(
      context,
      AppRoutes.create,
      arguments: task,
    );
  }

  Future<void> checkIfMissed() async {
    final taskProv = context.read<TaskProvider>();

    final freshTask = taskProv.tasks.firstWhere(
          (t) => t.id == task.id,
      orElse: () => task,
    );

    if (freshTask.status == TaskStatus.completed) return;

    final now = DateTime.now();
    final isExpired = freshTask.deadline.isBefore(now);

    if (isExpired && freshTask.status != TaskStatus.missed) {
      await _updateStatus(TaskStatus.missed);
    }

    else if (!isExpired && freshTask.status == TaskStatus.missed) {
      await _updateStatus(TaskStatus.planned);
    }
  }

  Future<void> _updateStatus(TaskStatus newStatus) async {
    final taskProvider = context.read<TaskProvider>();

    await TaskRepository().updateTaskStatus(task.id, newStatus);
    taskProvider.updateTaskStatusLocally(task.id, newStatus);
  }
}