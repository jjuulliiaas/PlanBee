import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/colors_extension.dart';

class LanguageSwitcher extends StatelessWidget {
  final String currentLang;
  final Function(String) onChanged;
  final AppColorsExtension customColors;

  const LanguageSwitcher({
    super.key,
    required this.currentLang,
    required this.onChanged,
    required this.customColors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 100.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Row(
        children: [
          _buildTab('UA', theme),
          _buildTab('EN', theme),
        ],
      ),
    );
  }

  Widget _buildTab(String label, ThemeData theme) {
    final isSelected = currentLang == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? customColors.yellow : theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          ),
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isSelected ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.outline,
            ),
          ),
        ),
      ),
    );
  }
}