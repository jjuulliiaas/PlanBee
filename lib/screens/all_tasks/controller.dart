import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../blocks/all_tasks/provider.dart';
import '../../blocks/task/model.dart';
import '../../blocks/task/provider.dart';
import '../../blocks/task/repository.dart';
import '../../blocks/timer/provider.dart';
import '../../routes.dart';
import '../../widgets/base_picker_layout.dart';
import 'components/sort_picker.dart';

class AllTasksController {
  final BuildContext context;
  AllTasksController(this.context);

  AllTasksProvider get _provider => context.read<AllTasksProvider>();
  TaskProvider get _taskProv => context.read<TaskProvider>();

  void onStatusFilterChanged(TaskStatus? status) => _provider.filterStatus = status;
  void onDaySelected(DateTime day) => _provider.selectedDay = day;

  void navigateToTaskDetails(TaskModel task) {
    Navigator.pushNamed(context, AppRoutes.taskDetails, arguments: task);
  }

  Future<void> onToggleTaskStatus(TaskModel task, bool isCompleted) async {
    final newStatus = isCompleted ? TaskStatus.completed : TaskStatus.planned;

    final timer = context.read<TimerProvider>();
    if (newStatus == TaskStatus.completed && timer.activeTaskId == task.id) {
      timer.stopTimer();
    }

    _taskProv.updateTaskStatusLocally(task.id, newStatus);

    try {
      await TaskRepository().updateTaskStatus(task.id, newStatus);
    } catch (e) {
      _taskProv.updateTaskStatusLocally(task.id, task.status);
    }
  }

  Future<void> onShowSortMenu() async {
    await BasePickerLayout.show(
      context: context,
      child: const SortPicker(),
    );
  }
}