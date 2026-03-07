import 'package:flutter/material.dart';
import 'package:planbee/blocks/category/provider.dart';
import 'package:planbee/blocks/task/provider.dart';
import 'package:planbee/screens/create_edit_task/controller.dart';
import 'package:provider/provider.dart';

import '../../blocks/task/model.dart';
import '../../core/utils/app_padding.dart';
import 'body.dart';

class CreateEditScreen extends StatelessWidget {
  final TaskModel? taskToEdit;

  const CreateEditScreen({super.key, this.taskToEdit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScheme = theme.textTheme;

    final provider = context.watch<TaskProvider>();
    final categoryProvider = context.watch<CategoryProvider>();
    final controller = CreateEditController(
        taskProvider: provider,
        categoryProvider: categoryProvider
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('New Task'),
          titleTextStyle: textScheme.headlineSmall,
          leading: TextButton(
              onPressed: () {
                controller.onCancel(context);
                },
              child: Text('Cancel')
              ),
          actions: [
            TextButton(
              onPressed: provider.canSave && !provider.isLoading
                  ? () => controller.onSaveTask(context)
                  : null,
              child: Text(
                'Save',
                style: TextStyle(
                  color: provider.canSave
                      ? theme.colorScheme.primary
                      : theme.colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
                children: [
                  Padding(
                    padding: AppPadding.screen(context),
                    child: CreateEditBody(),
                  ),
                ]
            )
    );
  }
}
