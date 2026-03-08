import 'package:flutter/material.dart';
import 'package:planbee/routes.dart';
import 'package:provider/provider.dart';

import '../../blocks/task/model.dart';
import '../../blocks/task/provider.dart';
import '../../blocks/task/repository.dart';

class HomeController {
  final BuildContext context;
  final TaskRepository _repository = TaskRepository();

  HomeController(this.context);

  TaskProvider get _provider => context.read<TaskProvider>();

  Future<void> fetchAllTasks() async {
    _provider.isLoading = true;
    try {
      final allTasks = await _repository.fetchTasks();
      _provider.tasks = allTasks;
    } catch (e) {
      // print('Error fetching tasks: $e');
    } finally {
      _provider.isLoading = false;
    }
  }

  void toggleTaskStatus(TaskModel task, bool? isCompleted) async {
    final newStatus = isCompleted == true ? TaskStatus.completed : TaskStatus.planned;
    await _repository.updateTaskStatus(task.id, newStatus);
    _provider.updateTaskStatusLocally(task.id, newStatus);
  }

  void navigateToCreateTask(String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  void navigateToTaskDetails(TaskModel task) {
    Navigator.pushNamed(
      context,
      AppRoutes.taskDetails,
      arguments: task,
    );
  }
}