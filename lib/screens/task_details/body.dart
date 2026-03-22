import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/screens/task_details/controller.dart';
import 'package:planbee/widgets/picked_chip.dart';
import 'package:planbee/widgets/priority_badge.dart';

import '../../blocks/task/model.dart';
import '../../core/theme/colors_extension.dart';
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
    final autoCheckStream = Stream.periodic(const Duration(seconds: 5));

    return StreamBuilder(
        stream: autoCheckStream,
        builder: (context, snapshot) {
          Future.microtask(() => controller.checkIfMissed());

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
                                      getFormattedDate(currentTask.deadline),
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: _getDeadlineColor(
                                            currentTask.status,
                                            colorScheme,
                                            theme.extension<AppColorsExtension>()
                                        ),
                                      ),
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
                ],
              ),
            ),
          );

        }
    );


  }
}

Color _getDeadlineColor(TaskStatus status, ColorScheme colorScheme, AppColorsExtension? customColors) {
  switch (status) {
    case TaskStatus.missed:
      return colorScheme.error; 
    case TaskStatus.completed:
      return customColors?.success ?? Colors.green;
    case TaskStatus.inProgress:
      return customColors?.yellow ?? Colors.orange; 
    case TaskStatus.planned:
    return colorScheme.primary;
  }
}
