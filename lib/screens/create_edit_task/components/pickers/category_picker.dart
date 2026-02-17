import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/blocks/category/model.dart';

import '../../../../widgets/app_confirm_button.dart';
import '../../../../widgets/detail_name.dart';
import 'base_picker_layout.dart';

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({super.key});

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  String selectedId = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final categories = CategoryModel.mockCategories;

    return BasePickerLayout(
      title: 'Choose Category',
      children: [
        SizedBox(height: 24.h,),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categories.length + 1,
            separatorBuilder: (context, index) => SizedBox(height: 4.h,),
            itemBuilder: (context, index) {
              if(index < categories.length) {
                final item = categories[index];
                final isSelected = selectedId == item.id;

                return OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedId = item.id;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isSelected ? colorScheme.primary : Colors.transparent,
                    ),
                    child: DetailName(
                      icon: item.icon,
                      text: item.name,
                      alignment: MainAxisAlignment.start,
                      forceWhite: isSelected,
                    )
                );
              }
              return OutlinedButton(
                onPressed: () {  },
                  child: DetailName(
                    icon: Icons.add,
                    text: 'Create Category',
                    alignment: MainAxisAlignment.start,
                  )

              );
            },
        ),
        SizedBox(height: 24.h,),
        AppConfirmButton(
          onTap: selectedId.isEmpty
          ? null
          : () => Navigator.pop(context, selectedId),
        )
      ],
    );
  }
}
