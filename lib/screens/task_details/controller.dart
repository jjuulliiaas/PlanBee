import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocks/task/model.dart';
import '../../blocks/task/provider.dart';
import '../../blocks/task/repository.dart';
import '../../blocks/timer/provider.dart';

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
      _updateStatus(TaskStatus.inProgress); // Встановлюємо "In Progress"
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

    int elapsed = 0;
    if (timerProvider.activeTaskId == task.id) {
      elapsed = timerProvider.getAndResetElapsed();
    }

    await TaskRepository().updateTaskStatus(task.id, TaskStatus.completed);

    taskProvider.updateTaskStatusLocally(task.id, TaskStatus.completed);

    if (timerProvider.activeTaskId == task.id) {
      timerProvider.stopTimer();
    }

    // Navigator.pop(context);
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

    await TaskRepository().updateTaskStatus(task.id, newStatus);
    taskProvider.updateTaskStatusLocally(task.id, newStatus);

    if (newStatus == TaskStatus.completed && timerProvider.activeTaskId == task.id) {
      timerProvider.stopTimer();
    }
  }

  Future<void> _updateStatus(TaskStatus newStatus) async {
    final taskProvider = context.read<TaskProvider>();

    await TaskRepository().updateTaskStatus(task.id, newStatus);
    taskProvider.updateTaskStatusLocally(task.id, newStatus);
  }
}