import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/utils/app_padding.dart';
import 'package:planbee/core/utils/icons_list.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/text_button_icon.dart';

class IconPicker extends StatefulWidget {
  const IconPicker({super.key, required this.onIconSelected});

  final ValueChanged<IconData> onIconSelected;

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  late IconData selectedIcon;

  @override
  void initState() {
    super.initState();
    selectedIcon = availableIcons.first;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onIconSelected(selectedIcon);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final $ = S.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButtonIcon(
            onPressed: () {},
            text: $.selectIcon,
            icon: Icons.keyboard_arrow_down_outlined,
          ),
          SizedBox(height: 8.h,),
          Card(
            child: Column(
              children: [
                GridView.builder(
                  padding: AppPadding.screen(context),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                    ),
                    itemCount: availableIcons.length,
                    itemBuilder: (context, index) {
                      final icon = availableIcons[index];
                      final isSelected = selectedIcon == icon;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIcon = icon;
                          });
                          widget.onIconSelected(icon);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? colorScheme.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          ),
                          child: Icon(
                            icon,
                            color: isSelected ? Colors.white : colorScheme.primary,
                            size: 24.r,
                          ),
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h,),
        ],
      );
  }
}
