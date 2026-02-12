import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/screens/home/components/task_card/priority_badge.dart';
import 'package:planbee/widgets/status_badge.dart';
import '../../../../blocks/task/model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatted_date.dart';
import 'check_box.dart';
import 'info_column.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      elevation: 5,
      // shadowColor: Color.lerp(colorScheme.surface, colorScheme.primary, 0.1)!,
      child: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                    Icons.boy,  // replace with dynamic icons
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
                  onChanged: (value) {
                    print('Task Completed!!!');
                  },
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
                  value: task.categoryId ?? 'General',
                  colorValue: colorScheme.primary,
                ),
                InfoColumn(
                  label: 'Deadline',
                  value: getFormattedDate(task.deadline),
                  colorValue: colorScheme.primary,
                ),
                StatusBadge(status: task.status),
              ],
            ),

            if (task.status == TaskStatus.inProgress) ...[
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: colorScheme.outline,
                    size: 15.r,
                  ),
                  Text(
                    'Timer is running...',
                    style: textTheme.labelLarge?.copyWith(color: colorScheme.outline),
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}