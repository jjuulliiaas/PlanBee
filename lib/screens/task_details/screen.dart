import 'package:flutter/material.dart';

import '../../blocks/task/model.dart';
import 'body.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScheme = theme.textTheme;

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
        body: TaskDetailsBody(task: task,)
    );
  }
}
