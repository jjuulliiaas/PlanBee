import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/utils/app_padding.dart';
import 'package:provider/provider.dart';

import '../../../blocks/all_tasks/provider.dart';
import '../../../blocks/task/model.dart';
import '../controller.dart';

class FilterBar extends StatelessWidget {
  final AllTasksController controller;
  const FilterBar({super.key, required this.controller});

  Color _getStatusColor(TaskStatus? status, ThemeData theme) {
    switch (status) {
      case TaskStatus.planned: return Colors.blue;
      case TaskStatus.inProgress: return Colors.orange;
      case TaskStatus.completed: return Colors.green;
      case TaskStatus.missed: return Colors.red;
      default: return theme.colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentStatus = context.select<AllTasksProvider, TaskStatus?>(
            (p) => p.filterStatus
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: AppPadding.screen(context),
      child: Row(
        children: [
          ...TaskStatus.values.map((status) => Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: _buildFilterChip(
                _formatStatusName(status.name),
                status,
                currentStatus,
                theme
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, TaskStatus? status, TaskStatus? currentSelected, ThemeData theme) {
    final isSelected = currentSelected == status;
    final color = _getStatusColor(status, theme);

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        controller.onStatusFilterChanged(isSelected ? null : status);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? color : theme.colorScheme.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6.r,
              height: 6.r,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? theme.colorScheme.onSurface : theme.colorScheme.outline,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatStatusName(String name) {
    return name.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}').trim().capitalize();
  }
}

extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
}