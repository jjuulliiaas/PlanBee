import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/utils/app_padding.dart';
import 'package:planbee/widgets/priority_badge.dart';
import 'package:planbee/widgets/status_badge.dart';
import 'package:provider/provider.dart';
import '../../../../blocks/task/model.dart';
import '../../../../blocks/timer/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatted_date.dart';
import 'check_box.dart';
import 'info_column.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final ValueChanged<bool> onStatusChanged;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onStatusChanged,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<TimerProvider>();

    final displayStatus = task.effectiveStatus;

    final bool isThisTaskActive = timerProvider.isRunning &&
        timerProvider.activeTaskId == task.id;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: onTap,
        splashColor: colorScheme.primaryContainer,
        highlightColor: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        child: Container(
          padding: AppPadding.screen(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                      task.category?.icon ?? Icons.task_alt,
                      size: 20.r,
                      color: colorScheme.primary
                  ),
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8.w,
                      runSpacing: 4.h,
                      children: [
                        Text(
                          task.title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.2,
                          ),
                        ),
                        if (task.isHighPriority) const PriorityBadge(),
                      ],
                    ),
                  ),

                  SizedBox(width: 12.w),

                  CustomCheckbox(
                    isChecked: task.status == TaskStatus.completed,
                    onChanged: (val) => onStatusChanged(val),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InfoColumn(
                    label: 'Category',
                    value: task.category?.name ?? 'General',
                    colorValue: colorScheme.primary,
                  ),
                  InfoColumn(
                    label: 'Deadline',
                    value: getFormattedDate(task.deadline),
                    colorValue: task.effectiveStatus == TaskStatus.missed
                        ? colorScheme.error
                        : colorScheme.primary,
                  ),
                  StatusBadge(status: displayStatus),
                ],
              ),

              if (isThisTaskActive) ...[
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.timer_fill,
                      color: colorScheme.outline,
                      size: 15.r,
                    ),
                    Text(
                      'Timer is running... ${timerProvider.formattedTime}',
                      style: textTheme.labelLarge?.copyWith(color: colorScheme.outline),
                    ),
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );


  }
}