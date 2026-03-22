import 'package:flutter/material.dart';
import 'package:planbee/routes.dart';

import '../../blocks/task/model.dart';
import '../../blocks/task/provider.dart';
import '../../blocks/task/repository.dart';
import '../../blocks/timer/provider.dart';

class HomeController {
  final TaskProvider taskProvider;
  final TaskRepository _repository = TaskRepository();
  final TimerProvider timerProvider;

  HomeController(this.taskProvider, this.timerProvider);

  Future<void> fetchAllTasks() async {
    taskProvider.isLoading = true;
    try {
      final allTasks = await _repository.fetchTasks();

      for (var t in allTasks) {
        if (t.status != TaskStatus.completed &&
            t.status != TaskStatus.missed &&
            t.deadline.isBefore(DateTime.now())) {
          await _repository.updateTaskStatus(t.id, TaskStatus.missed);
        }
      }

      taskProvider.tasks = allTasks;
    } catch (e) {
    } finally {
      taskProvider.isLoading = false;
    }
  }

  void toggleTaskStatus(TaskModel task, bool? isCompleted) async {
    final newStatus = isCompleted == true ? TaskStatus.completed : TaskStatus.planned;

    if (newStatus == TaskStatus.completed && timerProvider.activeTaskId == task.id) {
      timerProvider.stopTimer();
    }

    await _repository.updateTaskStatus(task.id, newStatus);
    taskProvider.updateTaskStatusLocally(task.id, newStatus);
  }

  void navigateToCreateTask(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  void navigateToTaskDetails(BuildContext context, TaskModel task) {
    Navigator.pushNamed(
      context,
      AppRoutes.taskDetails,
      arguments: task,
    );
  }
}