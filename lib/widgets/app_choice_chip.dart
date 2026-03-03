import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/theme/app_theme.dart';

/// Use this tip for pickers

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.icon,
    this.leading,
    this.iconColor
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;
  final IconData? icon;
  final Widget? leading;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      backgroundColor: colorScheme.surface,
      selectedColor: colorScheme.primary,
      showCheckmark: false,
      labelStyle: textTheme.bodySmall?.copyWith(
        color: isSelected
            ? colorScheme.surface
            : colorScheme.primary
      ),
      avatar: leading ?? (icon != null
          ? Icon(
            icon,
            size: 15.sp,
            color: iconColor,
          )
          : null
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall)
      ),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return BorderSide.none;
        return BorderSide(
          color: colorScheme.primary,
          width: 1.w
        );
      }),
    );
  }
}
