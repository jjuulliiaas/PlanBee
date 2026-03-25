import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../blocks/task/model.dart';
import '../../blocks/task/provider.dart';
import '../../core/theme/colors_extension.dart';
import '../../core/utils/app_padding.dart';
import '../../core/utils/formatted_date.dart';
import '../../widgets/status_badge.dart';
import '../../widgets/picked_chip.dart';
import '../../widgets/priority_badge.dart';
import '../task_details/controller.dart';
import 'components/property_name.dart';
import 'components/timer.dart';

class TaskDetailsBody extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsBody({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    final currentTask = taskProvider.tasks.firstWhere(
          (t) => t.id == task.id,
      orElse: () => task,
    );

    final controller = TaskDetailsController(context, currentTask);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final displayStatus = currentTask.effectiveStatus;

    final widthSpacer = SizedBox(width: 12.w);
    final heightSpacer = SizedBox(height: 8.h);

    return SingleChildScrollView(
      child: Padding(
        padding: AppPadding.screen(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.only(bottom: 16.h),
              child: Container(
                padding: AppPadding.screen(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          currentTask.category?.icon ?? Icons.category_outlined,
                          size: 30.r,
                          color: colorScheme.primary,
                        ),
                        widthSpacer,
                        Expanded(
                          child: Text(
                            currentTask.title,
                            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                            softWrap: true,
                          ),
                        ),
                        widthSpacer,
                        if (currentTask.isHighPriority) const PriorityBadge(),
                      ],
                    ),

                    const Divider(height: 32),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PropertyName(title: 'Description'),
                        heightSpacer,
                        Text(
                          currentTask.description?.isNotEmpty == true
                              ? currentTask.description!
                              : "No description provided",
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    const Divider(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const PropertyName(title: 'Category'),
                              heightSpacer,
                              PickedChip(
                                label: currentTask.category?.name ?? 'General',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        widthSpacer,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const PropertyName(title: 'Deadline'),
                            heightSpacer,
                            Text(
                              getFormattedDate(currentTask.deadline),
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _getDeadlineColor(
                                  displayStatus,
                                  colorScheme,
                                  theme.extension<AppColorsExtension>(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Divider(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const PropertyName(title: 'Status'),
                        StatusBadge(status: displayStatus),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            TimerCard(controller: controller),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Color _getDeadlineColor(
      TaskStatus status,
      ColorScheme colorScheme,
      AppColorsExtension? customColors,
      ) {
    switch (status) {
      case TaskStatus.missed:
        return colorScheme.error;
      case TaskStatus.completed:
        return customColors?.success ?? Colors.green;
      case TaskStatus.inProgress:
        return Colors.orange;
      case TaskStatus.planned:
        return colorScheme.primary;
    }
  }
}