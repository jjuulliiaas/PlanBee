import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailName extends StatelessWidget {
  const DetailName({
    super.key,
    required this.icon,
    required this.text,
    this.alignment = MainAxisAlignment.center,
    this.color,
    this.forceWhite = false
  });

  final IconData icon;
  final String text;
  final MainAxisAlignment alignment;
  final Color? color;
  final bool forceWhite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final iconColor = forceWhite ? colorScheme.surface : colorScheme.primary;
    final textColor = forceWhite ? colorScheme.surface : colorScheme.onSecondaryContainer;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: alignment,
      children: [
        Icon(
          icon,
          size: 20.r,
          color: iconColor,
        ),
        SizedBox(width: 8.w,),
        Text(
          text,
          style: textTheme.bodyLarge?.copyWith(
            color: textColor
          ),
        ),
      ],
    );
  }
}
