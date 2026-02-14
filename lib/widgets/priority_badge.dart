import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriorityBadge extends StatelessWidget {
  const PriorityBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department_rounded,
            size: 10.r,
            color: colorScheme.error,
          ),
          Text(
            'High priority',
          ),
        ],
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.zero,
    );
  }
}
