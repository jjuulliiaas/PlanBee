import 'package:flutter/material.dart';
import 'package:planbee/blocks/task/provider.dart';
import 'package:planbee/screens/create_edit_task/controller.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_padding.dart';
import 'body.dart';

class CreateEditScreen extends StatelessWidget {
  const CreateEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TaskProvider>();
    final controller = CreateEditController(provider: provider);

    final theme = Theme.of(context);
    final textScheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        titleTextStyle: textScheme.headlineSmall,
        leading: TextButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            child: Text('Cancel')
        ),
        actions: [
          TextButton(
              onPressed: () => controller.onSaveTask(context),
              child: provider.isLoading
                ? CircularProgressIndicator(strokeWidth: 1,)
                : Text('Save')
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
