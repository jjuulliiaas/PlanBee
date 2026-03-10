import 'package:flutter/cupertino.dart';
import 'package:planbee/blocks/task/model.dart';
import 'package:provider/provider.dart';

import '../../blocks/task/provider.dart';
import '../../blocks/task/repository.dart';
import '../../blocks/tiimer/provider.dart';

class TaskDetailsController {
  final BuildContext context;
  final TaskModel task;

  const TaskDetailsController(this.context, this.task);

  Future<void> markAsCompleted() async {
    final timerProvider = context.read<TimerProvider>();
    final taskProvider = context.read<TaskProvider>();

    // int elapsed = timerProvider.getAndResetElapsed();

    await TaskRepository().updateTaskStatus(task.id, TaskStatus.completed);

    taskProvider.updateTaskStatusLocally(task.id, TaskStatus.completed);
    timerProvider.stopTimer();

    Navigator.pop(context);
  }
}