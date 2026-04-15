import 'package:flutter/material.dart';
import 'package:planbee/blocks/task/model.dart';
import 'package:provider/provider.dart';

import '../../../../blocks/all_tasks/provider.dart';
import '../../../../blocks/task/provider.dart';
import '../../../../core/utils/app_padding.dart';
import '../../../../generated/l10n.dart';
import '../../../home/components/task_card/task_card.dart';
import '../../controller.dart';

class AllTasksListPage extends StatelessWidget {
  final AllTasksController controller;

  const AllTasksListPage({
    super.key,
    required this.controller, required List<TaskModel> tasks,
  });

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<AllTasksProvider>().filteredTasks;
    final $ = S.of(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: tasks.isEmpty
          ? Center(child: Text($.noTasksFound))
          : ListView.builder(
        padding: AppPadding.screen(context),
        itemCount: tasks.length,
          itemBuilder: (context, index) {
            final taskId = tasks[index].id;

            return Selector<TaskProvider, TaskModel>(
              selector: (_, prov) => prov.tasks.firstWhere((t) => t.id == taskId),
              builder: (context, updatedTask, _) {
                return TaskCard(
                  key: ValueKey('${updatedTask.id}_${updatedTask.status.name}'),
                  task: updatedTask,
                  onStatusChanged: (val) => controller.onToggleTaskStatus(updatedTask, val),
                  onTap: () => controller.navigateToTaskDetails(updatedTask),
                );
              },
            );
          }
      ),
    );
  }
}