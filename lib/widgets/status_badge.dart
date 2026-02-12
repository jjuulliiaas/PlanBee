import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/blocks/task/model.dart';
import 'package:planbee/core/theme/app_theme.dart';
import 'package:planbee/core/theme/colors_extension.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final TaskStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final customColors = theme.extension<AppColorsExtension>();
    final textTheme = theme.textTheme;

    final (color, label) = switch(status) {
      TaskStatus.planned => (colorScheme.primary, 'Planned'),
      TaskStatus.inProgress => (customColors?.yellow, 'In progress'),
      TaskStatus.completed => (customColors?.success, 'Completed'),
      TaskStatus.missed => (colorScheme.error, 'Missed')
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Text(
        label,
        style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
      ),
    );
  }
}
