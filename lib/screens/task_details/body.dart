import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/widgets/picked_chip.dart';
import 'package:planbee/widgets/priority_badge.dart';

import '../../blocks/task/model.dart';
import '../../core/utils/app_padding.dart';
import '../../core/utils/formatted_date.dart';
import '../../widgets/status_badge.dart';
import 'components/property_name.dart';

class TaskDetailsBody extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsBody({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final widthSpacer = SizedBox(width: 12.r,);
    final heightSpacer = SizedBox(height: 8.r,);

    return Padding(
      padding: AppPadding.screen(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.only(bottom: 16.h),
            child: Container(
              padding: AppPadding.screen(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                              task.category?.icon,
                              size: 30.r,
                              color: colorScheme.primary
                          ),
                          widthSpacer,
                          Text(
                            task.title,
                            style: textTheme.headlineLarge,
                          ),
                        ],
                      ),
                      widthSpacer,
                      if(task.isHighPriority == true) const PriorityBadge(),
                    ],
                  ),

                  const Divider(),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PropertyName(
                        title: 'Description',
                      ),
                      heightSpacer,
                      if(task.description != null)
                        Text(
                          task.description!,
                          textAlign: TextAlign.left,
                        )
                    ],
                  ),

                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PropertyName(
                            title: 'Category',
                          ),
                          heightSpacer,
                          PickedChip(
                              label: task.category!.name,
                              onTap: () {}
                          )
                        ]
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PropertyName(
                              title: 'Deadline',
                            ),
                            heightSpacer,
                            Text(
                              DateHelper.formatDeadlineDate(task.deadline),
                              style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
                            ),
                          ]
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PropertyName(
                          title: 'Status'
                      ),
                      StatusBadge(
                        status: task.status,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
