import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocks/task/model.dart';
import '../../core/theme/colors_extension.dart';
import '../../widgets/app_confirm_button.dart';
import 'body.dart';
import 'controller.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final controller = TaskDetailsController(context, task);

    // final currentTask = controller.currentTask;
    final bool isCompleted = controller.isTaskCompleted;

    final theme = Theme.of(context);
    final textScheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final customColors = theme.extension<AppColorsExtension>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Task Details'),
          titleTextStyle: textScheme.headlineSmall,
          leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel')
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      body: TaskDetailsBody(task: task,),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: AppConfirmButton(
            onTap: controller.toggleTaskStatus,
            text: isCompleted ? 'Task Completed' : 'Mark as completed',
            icon: Icon(Icons.done),
            color: isCompleted ? customColors?.success : colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
