import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocks/task/model.dart';
import '../../core/theme/colors_extension.dart';
import '../../generated/l10n.dart';
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

    final $ = S.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text($.taskDetails),
          titleTextStyle: textScheme.headlineSmall,
          leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text($.cancel)
          ),
          actions: [
            TextButton(
              onPressed: () => controller.navigateToEditTask(context, task),
              child: Text(
                $.edit,
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
            text: isCompleted ? $.taskCompleted : $.markAsCompleted,
            icon: Icon(Icons.done),
            color: isCompleted ? customColors?.success : colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
