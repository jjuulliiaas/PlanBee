import 'package:flutter/material.dart';
import 'package:planbee/blocks/category/provider.dart';
import 'package:planbee/blocks/task/provider.dart';
import 'package:planbee/screens/create_edit_task/controller.dart';
import 'package:provider/provider.dart';

import '../../blocks/task/model.dart';
import '../../core/utils/app_padding.dart';
import '../../generated/l10n.dart';
import 'body.dart';

class CreateEditScreen extends StatelessWidget {
  final TaskModel? taskToEdit;

  const CreateEditScreen({super.key, this.taskToEdit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScheme = theme.textTheme;

    final $ = S.of(context);

    final provider = context.watch<TaskProvider>();
    final categoryProvider = context.watch<CategoryProvider>();
    final controller = CreateEditController(
        taskProvider: provider,
        categoryProvider: categoryProvider
    );

    final isEditing = taskToEdit != null;

    return Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? $.editTask : $.newTask),
          titleTextStyle: textScheme.headlineSmall,
          leading: TextButton(
              onPressed: () {
                controller.onCancel(context);
                },
              child: Text($.cancel)
              ),
          actions: [
            TextButton(
              onPressed: provider.canSave && !provider.isLoading
                  ? () => controller.onSaveTask(
                      context,
                      editTaskId: taskToEdit?.id,
                    )
                  : null,
              child: Text(
                isEditing ? $.update : $.save,
                style: TextStyle(
                  color: provider.canSave ? theme.colorScheme.primary : theme.colorScheme.secondary,
                ),
              ),
                ),
              ],
            ),
            body: Stack(
                children: [
                  Padding(
                    padding: AppPadding.screen(context),
                    child: CreateEditBody(taskToEdit: taskToEdit,),
                  ),
                ]
            )
    );
  }
}
