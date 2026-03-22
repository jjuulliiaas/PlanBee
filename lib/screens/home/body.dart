import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/blocks/task/provider.dart';
import 'package:planbee/core/utils/app_padding.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import 'components/task_card/task_card.dart';
import 'controller.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final taskProvider = context.watch<TaskProvider>();
    final controller = HomeController(taskProvider);

    Future.microtask(() {
      if (taskProvider.tasks.isEmpty && !taskProvider.isLoading) {
        controller.fetchAllTasks();
      }
    });

    final todayTasks = taskProvider.tasks.where((task) {
      final now = DateTime.now();
      return task.deadline.year == now.year &&
          task.deadline.month == now.month &&
          task.deadline.day == now.day;
    }).toList();

    return Padding(
      padding: AppPadding.horizontalOnly(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s plan',
                style: textTheme.headlineMedium,
              ),
              ElevatedButton.icon(
                onPressed: () => controller.navigateToCreateTask(context, AppRoutes.create),
                icon: Icon(Icons.add, size: 20.r),
                label: Text(
                  'Add',
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
                ),
              )
            ],
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: taskProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : todayTasks.isEmpty
                ? _buildEmptyState(textTheme)
                : ListView.builder(
              padding: EdgeInsets.only(bottom: 100.h),
              itemCount: todayTasks.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final task = todayTasks[index];
                return TaskCard(
                  task: task,
                  onStatusChanged: (val) => controller.toggleTaskStatus(task, val),
                  onTap: () => controller.navigateToTaskDetails(context, task),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wb_sunny_outlined, size: 50.r, color: Colors.grey),
          SizedBox(height: 10.h),
          Text(
            'No tasks for today! 🐝',
            style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}