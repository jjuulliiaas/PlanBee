import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoColumn extends StatelessWidget {
  const InfoColumn({
    super.key,
    required this.label,
    required this.value,
    required this.colorValue
  });

  final String label;
  final String value;
  final Color colorValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelLarge?.copyWith(color: colorScheme.secondary),
        ),
        SizedBox(height: 4.h,),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(color: colorValue),
        ),
      ],
    );
  }
}
