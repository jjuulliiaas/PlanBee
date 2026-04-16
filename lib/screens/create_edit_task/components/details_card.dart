import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/blocks/category/provider.dart';
import 'package:planbee/blocks/task/provider.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_padding.dart';
import '../../../core/utils/formatted_date.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/app_switcher.dart';
import '../../../widgets/detail_name.dart';
import '../../../widgets/picked_chip.dart';
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

    final $ = S.of(context);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final widthSpacer = SizedBox(width: 12.w,);

    final locale = Localizations.localeOf(context).languageCode;

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
                  text: $.deadline,
                ),
                widthSpacer,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (provider.selectedDate == null)
                        OutlinedButton(
                            onPressed: () => controller.onSelectDate(context),
                            child: Text($.setDate))
                      else
                        Flexible(
                          child: PickedChip(
                            label: DateHelper.formatShortMonthDay(provider.selectedDate!, locale),
                            onTap: () => controller.onSelectDate(context),
                          ),
                        ),

                      SizedBox(width: 4.w),

                      if (provider.selectedTime == null)
                        OutlinedButton(
                            onPressed: () => controller.onSelectTime(context),
                            child: Text($.setTime))
                      else
                        Flexible(
                          child: PickedChip(
                            label: provider.selectedTime!.format(context),
                            onTap: () => controller.onSelectDate(context),
                          ),
                        ),

                      if (provider.selectedDate != null || provider.selectedTime != null)
                        _ResetIcon(onTap: () {
                          provider.selectedDate = null;
                          provider.selectedTime = null;
                        }),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailName(
                  icon: Icons.category_rounded,
                  text: $.category,
                ),
                widthSpacer,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (provider.selectedCategory == null)
                        TextButton.icon(
                          onPressed: () => controller.onSelectCategory(context),
                          label: Row(
                            children: [
                              Text(
                                $.chooseCategory,
                                style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
                              ),
                              Icon(Icons.keyboard_arrow_down_outlined, color: colorScheme.primary)
                            ],
                          ),
                        )
                      else
                        Flexible(
                          child: PickedChip(
                            icon: provider.selectedCategory!.icon,
                            label: provider.selectedCategory!.id.toCategoryName(context),
                            onTap: () => controller.onSelectCategory(context),
                          ),
                        ),
                      if (provider.selectedCategory != null)
                        _ResetIcon(onTap: () => provider.selectedCategory = null),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            AppSwitcher(
              value: provider.isHighPriority,
              onChanged: (val) {
                controller.onTogglePriority(val);
              },
            )
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
