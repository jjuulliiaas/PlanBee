import 'package:flutter/material.dart';
import 'package:planbee/core/utils/app_padding.dart';

class InputCard extends StatelessWidget {
  const InputCard({
    super.key,
    required this.titleController,
    required this.descriptionController
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      elevation: 10,
      child: Container(
        padding: AppPadding.screen(context),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: textTheme.headlineLarge,
              maxLines: null,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Task title...'
              ),
            ),
            const Divider(),
            TextFormField(
              controller: descriptionController,
              style: textTheme.bodyLarge,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  hintText: 'Add description (optional)'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
