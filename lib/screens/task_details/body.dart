import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/screens/task_details/controller.dart';
import 'package:planbee/widgets/picked_chip.dart';
import 'package:planbee/widgets/priority_badge.dart';

import '../../blocks/task/model.dart';
import '../../core/utils/app_padding.dart';
import '../../core/utils/formatted_date.dart';
import '../../widgets/status_badge.dart';
import 'components/property_name.dart';
import 'components/timer.dart';

class TaskDetailsBody extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsBody({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final controller = TaskDetailsController(context, task);

    final currentTask = controller.currentTask;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final widthSpacer = SizedBox(width: 12.r,);
    final heightSpacer = SizedBox(height: 8.r,);

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                            currentTask.category?.icon,
                            size: 30.r,
                            color: colorScheme.primary
                        ),
                        widthSpacer,
                        Expanded(
                          child: Text(
                            currentTask.title,
                            style: textTheme.headlineLarge,
                            softWrap: true,
                          ),
                        ),
                        widthSpacer,
                        if(currentTask.isHighPriority == true) const PriorityBadge(),
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
                        if(currentTask.description != null)
                          Text(
                            currentTask.description!,
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
                                  label: currentTask.category!.name,
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
                                DateHelper.formatDeadlineDate(currentTask.deadline),
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
                          status: currentTask.status,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            TimerCard(controller: controller,),
            // SizedBox(height: 70.h,),
            // AppConfirmButton(
            //   onTap: controller.toggleTaskStatus,
            //   text: isCompleted ? 'Task Completed' : 'Mark as completed',
            //   icon: Icon(Icons.done),
            //   color: isCompleted ? customColors?.success : colorScheme.primary,
            // )
          ],
        ),
      ),
    );
  }
}
