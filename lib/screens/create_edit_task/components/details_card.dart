import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/blocks/task/provider.dart';
import 'package:planbee/widgets/base_picker_layout.dart';
import 'package:planbee/screens/create_edit_task/components/pickers/category_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_padding.dart';
import '../../../widgets/app_switcher.dart';
import '../../../widgets/detail_name.dart';
import '../controller.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TaskProvider>();
    final controller = CreateEditController(provider: context.watch<TaskProvider>());

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
                    OutlinedButton(
                        onPressed: () => controller.onSelectDate(context),
                        child: const Text('Set Date')
                    ),
                    SizedBox(width: 8.w),
                    OutlinedButton(
                        onPressed: () => controller.onSelectTime(context),
                        child: const Text('Set Time')
                    )
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
                TextButton.icon(
                    onPressed: () {
                      BasePickerLayout.show(
                          context: context,
                          child: const CategoryPicker()
                      );
                    },
                    label: Row(
                      children: [
                        Text(
                            'Choose category',
                          style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary),
                        ),
                        Icon(
                            Icons.keyboard_arrow_down_outlined,
                          color: colorScheme.primary,
                        )
                      ],
                    ),
                )
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
