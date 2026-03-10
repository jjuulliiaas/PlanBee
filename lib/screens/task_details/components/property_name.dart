import 'package:flutter/material.dart';

class PropertyName extends StatelessWidget {
  const PropertyName({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      title,
      style: textTheme.bodySmall?.copyWith(
        color: colorScheme.outline
      ),
    );
  }
}
