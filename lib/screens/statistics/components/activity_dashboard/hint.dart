import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_padding.dart';

class StatsHint extends StatelessWidget {
  const StatsHint({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: AppPadding.screen(context),
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline
            ),
          ),
        )
    );
  }
}
