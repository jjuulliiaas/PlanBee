import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../blocks/all_tasks/provider.dart';
import '../../../../widgets/base_picker_layout.dart';

class SortPicker extends StatelessWidget {
  const SortPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final provider = context.watch<AllTasksProvider>();
    final currentOption = provider.sortOption;

    final List<Map<String, dynamic>> options = [
      {'option': TaskSortOption.newest, 'title': 'Newest First', 'icon': CupertinoIcons.arrow_down},
      {'option': TaskSortOption.oldest, 'title': 'Oldest First', 'icon': CupertinoIcons.arrow_up},
      {'option': TaskSortOption.priority, 'title': 'High Priority', 'icon': CupertinoIcons.star_circle},
      {'option': TaskSortOption.alphabet, 'title': 'Alphabet (A-Z)', 'icon': Icons.sort_by_alpha_rounded},
    ];

    return BasePickerLayout(
      title: 'Sort Tasks',
      children: options.map((item) {
        final option = item['option'] as TaskSortOption;
        final isSelected = currentOption == option;

        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: OutlinedButton(
            onPressed: () {
              provider.sortOption = option;
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: isSelected ? colorScheme.primary : Colors.transparent,
              side: BorderSide(
                color: isSelected ? colorScheme.primary : colorScheme.outline.withOpacity(0.2),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              alignment: Alignment.centerLeft,
            ),
            child: Row(
              children: [
                Icon(
                  item['icon'],
                  size: 20.r,
                  color: isSelected ? Colors.white : colorScheme.primary,
                ),
                SizedBox(width: 12.w),
                Text(
                  item['title'],
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isSelected ? Colors.white : theme.textTheme.bodyLarge?.color,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  const Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: Colors.white,
                      size: 20
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}