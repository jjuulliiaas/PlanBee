import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../blocks/category/provider.dart';
import '../../../../blocks/task/provider.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/app_confirm_button.dart';
import '../../../../widgets/base_picker_layout.dart';
import '../../../../widgets/detail_name.dart';
import '../../controller.dart';

class CategoryPicker extends StatelessWidget {
  const CategoryPicker({super.key, required this.controller});

  final CreateEditController controller;

  @override
  Widget build(BuildContext context) {
    final $ = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final taskProvider = context.watch<TaskProvider>();
    final categoryProvider = context.watch<CategoryProvider>();

    final controller = CreateEditController(
      taskProvider: taskProvider,
      categoryProvider: categoryProvider,
    );

    final categories = categoryProvider.categories;

    return BasePickerLayout(
      title: $.chooseCategory,
      children: [
        SizedBox(
          height: 350.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemCount: categories.length + 1,
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              if (index < categories.length) {
                final item = categories[index];

                final isSelected = taskProvider.tempSelectedCategory?.id == item.id;

                return OutlinedButton(
                  onPressed: () => controller.onTempSelectCategory(item),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isSelected ? colorScheme.primary : Colors.transparent,
                  ),
                  child: DetailName(
                    icon: item.icon,
                    text: item.id.toCategoryName(context),
                    alignment: MainAxisAlignment.start,
                    forceWhite: isSelected,
                  ),
                );
              }

              return OutlinedButton(
                onPressed: () => controller.onCreateNewCategory(context),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
                child: DetailName(
                  icon: Icons.add,
                  text: $.createNewCategory,
                  alignment: MainAxisAlignment.start,
                ),
              );
            },
          ),
        ),

        const Divider(),
        SizedBox(height: 16.h),

        AppConfirmButton(
          onTap: taskProvider.tempSelectedCategory == null
              ? null
              : () => controller.onConfirmCategory(context),
        ),
      ],
    );
  }
}