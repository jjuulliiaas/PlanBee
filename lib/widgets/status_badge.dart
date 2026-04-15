import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/blocks/task/model.dart';
import 'package:planbee/core/theme/app_theme.dart';
import 'package:planbee/core/theme/colors_extension.dart';

import '../generated/l10n.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final TaskStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final customColors = theme.extension<AppColorsExtension>();
    final textTheme = theme.textTheme;
    final $ = S.of(context);

    final (color, label) = switch(status) {
      TaskStatus.planned => (colorScheme.primary, $.statusPlanned),
      TaskStatus.inProgress => (customColors?.yellow, $.statusInProgress),
      TaskStatus.completed => (customColors?.success, $.completed),
      TaskStatus.missed => (colorScheme.error, $.statusMissed)
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
