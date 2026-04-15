import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/blocks/task/provider.dart';
import 'package:planbee/core/utils/app_padding.dart';
import 'package:provider/provider.dart';

import '../../blocks/statistics/provider.dart';
import '../../blocks/task/model.dart';
import '../../blocks/timer/provider.dart';
import '../../generated/l10n.dart';
import '../../routes.dart';
import 'components/task_card/task_card.dart';
import 'components/yesterday_motivation.dart';
import 'controller.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final $ = S.of(context);

    final taskProvider = context.watch<TaskProvider>();
    final timerProvider = context.read<TimerProvider>();
    final statsProvider = context.watch<StatsProvider>();
    final controller = HomeController(taskProvider, timerProvider, statsProvider);

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

    return SafeArea(
      child: taskProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        physics: const BouncingScrollPhysics(),
        padding: AppPadding.screen(context).copyWith(bottom: 100.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                $.todaysPlan,
                style: textTheme.headlineSmall,
              ),
              ElevatedButton.icon(
                onPressed: () => controller.navigateToCreateTask(context, AppRoutes.create),
                icon: Icon(Icons.add, size: 20.r),
                label: Text(
                  $.addTask,
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
                ),
              )
            ],
          ),
          SizedBox(height: 16.h),

          if (!statsProvider.isMotivationHidden)
            YesterdayMotivationWidget(
              onClose: () => controller.hideYesterdayMotivation(),
            ),

          SizedBox(height: 8.h),

          if (todayTasks.isEmpty)
            _buildEmptyState(context, textTheme)
          else
            ...todayTasks.map((task) {
              return Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Opacity(
                  opacity: task.status == TaskStatus.completed ? 0.5 : 1.0,
                  child: TaskCard(
                    task: task,
                    onStatusChanged: (val) => controller.toggleTaskStatus(task, val),
                    onTap: () => controller.navigateToTaskDetails(context, task),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, TextTheme textTheme) {
    final $ = S.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 100.h),
      child: Column(
        children: [
          Icon(Icons.wb_sunny_outlined, size: 50.r, color: Colors.grey),
          SizedBox(height: 10.h),
          Text(
            $.noTasksFound,
            style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}