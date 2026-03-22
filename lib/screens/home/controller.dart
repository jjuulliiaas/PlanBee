import 'package:flutter/material.dart';
import 'package:planbee/routes.dart';

import '../../blocks/task/model.dart';
import '../../blocks/task/provider.dart';
import '../../blocks/task/repository.dart';

class HomeController {
  final TaskProvider taskProvider;
  final TaskRepository _repository = TaskRepository();

  HomeController(this.taskProvider);

  Future<void> fetchAllTasks() async {
    taskProvider.isLoading = true;
    try {
      final allTasks = await _repository.fetchTasks();
      taskProvider.tasks = allTasks;
    } catch (e) {
    } finally {
      taskProvider.isLoading = false;
    }
  }

  void toggleTaskStatus(TaskModel task, bool? isCompleted) async {
    final newStatus = isCompleted == true ? TaskStatus.completed : TaskStatus.planned;
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