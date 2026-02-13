import 'package:flutter/material.dart';

import '../../core/utils/app_padding.dart';
import 'body.dart';

class CreateEditScreen extends StatelessWidget {
  const CreateEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              child: Text('Save')
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
