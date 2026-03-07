import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/blocks/category/provider.dart';
import 'package:planbee/blocks/task/provider.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_padding.dart';
import '../../../core/utils/formatted_date.dart';
import '../../../widgets/app_switcher.dart';
import '../../../widgets/detail_name.dart';
import '../controller.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final controller = CreateEditController(
        taskProvider: context.read<TaskProvider>(),
        categoryProvider:  context.read<CategoryProvider>(),
    );

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 10,
      child: Container(
        padding: AppPadding.screen(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailName(
                  icon: Icons.calendar_month,
                  text: 'Deadline',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(provider.selectedDate == null)
                      OutlinedButton(
                          onPressed: () => controller.onSelectDate(context),
                          child: const Text('Set Date')
                      )
                    else
                      _PickedChip(
                        label: DateHelper.formatDeadlineDate(provider.selectedDate!),
                        onTap: () => controller.onSelectDate(context),
                      ),

                    SizedBox(width: 8.w),

                    if(provider.selectedTime == null)
                      OutlinedButton(
                          onPressed: () => controller.onSelectTime(context),
                          child: const Text('Set Time')
                      )
                    else
                      _PickedChip(
                        label: provider.selectedTime!.format(context),
                        onTap: () => controller.onSelectDate(context),
                      ),

                    if (provider.selectedDate != null || provider.selectedTime != null)
                      _ResetIcon(
                        onTap: () {
                          provider.selectedDate = null;
                          provider.selectedTime = null;
                        },
                      ),
                  ],
                )
              ],
            ),

            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailName(
                  icon: Icons.category_rounded,
                  text: 'Category',
                ),
                if(provider.selectedCategory == null)
                TextButton.icon(
                    onPressed: () => controller.onSelectCategory(context),
                    label: Row(
                      children: [
                        Text(
                          provider.selectedCategory?.name ?? 'Choose category',
                          style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
                        ),
                        Icon(
                            Icons.keyboard_arrow_down_outlined,
                          color: colorScheme.primary,
                        )
                      ],
                    ),
                )
                else
                  Row(
                    children: [
                      _PickedChip(
                        icon: provider.selectedCategory!.icon,
                        label: provider.selectedCategory!.name,
                        onTap: () => controller.onSelectCategory(context),
                      ),
                      _ResetIcon(
                        onTap: () => provider.selectedCategory = null,
                      ),
                    ],
                  ),
              ],
            ),
            const Divider(),
            AppSwitcher(
              value: provider.isHighPriority,
              onChanged: controller.onTogglePriority,
            )
          ],
        ),
      ),
    );
  }
}


class _PickedChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  const _PickedChip({required this.label, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: theme.colorScheme.primary),
        ),
        child: Row(
          children: [
            if (icon != null) Icon(icon, size: 15.sp, color: theme.colorScheme.primary),
            if (icon != null) SizedBox(width: 4.w),
            Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary)),
          ],
        ),
      ),
    );
  }
}

class _ResetIcon extends StatelessWidget {
  const _ResetIcon({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Icon(
            Icons.cancel,
            size: 20.sp,
            color: colorScheme.outline
        ),
      ),
    );
  }
}
