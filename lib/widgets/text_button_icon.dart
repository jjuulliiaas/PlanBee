import 'package:flutter/material.dart';

class TextButtonIcon extends StatelessWidget {
  const TextButtonIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed
  });

  final String text;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return TextButton.icon(
      onPressed: onPressed,
      label: Row(
        children: [
          Text(
            text,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
          ),
          Icon(
            icon,
            color: colorScheme.primary,
          )
        ],
      ),
    );
  }
}
