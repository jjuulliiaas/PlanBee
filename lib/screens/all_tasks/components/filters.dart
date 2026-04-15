import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/theme/colors_extension.dart';
import 'package:planbee/core/utils/app_padding.dart';
import 'package:provider/provider.dart';

import '../../../blocks/all_tasks/provider.dart';
import '../../../blocks/task/model.dart';
import '../../../generated/l10n.dart'; // Імпортуємо локалізацію
import '../controller.dart';

class FilterBar extends StatelessWidget {
  final AllTasksController controller;
  const FilterBar({super.key, required this.controller});

  (Color, String) _getStatusData(TaskStatus status, BuildContext context, ThemeData theme) {
    final s = S.of(context);
    final customColors = theme.extension<AppColorsExtension>();

    return switch (status) {
      TaskStatus.planned => (theme.colorScheme.primary, s.statusPlanned),
      TaskStatus.inProgress => (customColors?.yellow ?? Colors.orange, s.statusInProgress),
      TaskStatus.completed => (customColors?.success ?? Colors.green, s.statusCompleted),
      TaskStatus.missed => (theme.colorScheme.error, s.statusMissed),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentStatus = context.select<AllTasksProvider, TaskStatus?>(
          (p) => p.filterStatus,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: AppPadding.screen(context).copyWith(top: 8.h, bottom: 8.h),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: TaskStatus.values.map((status) {
          final (color, label) = _getStatusData(status, context, theme);

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: _buildFilterChip(
              label,
              status,
              currentStatus,
              color,
              theme,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFilterChip(
      String label,
      TaskStatus status,
      TaskStatus? currentSelected,
      Color color,
      ThemeData theme,
      ) {
    final isSelected = currentSelected == status;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        controller.onStatusFilterChanged(isSelected ? null : status);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.01) : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? color : theme.colorScheme.primaryContainer,
            width: 1.0,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: color.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7.r,
              height: 7.r,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.4), blurRadius: 2, spreadRadius: 1)
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? theme.colorScheme.onSurface : theme.colorScheme.outline,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}