import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/theme/colors_extension.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool>? onChanged;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<AppColorsExtension>();

    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!isChecked);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 20.r,
        height: 20.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isChecked
              ? customColors?.success
              : theme.colorScheme.outline,
        ),
        child: Icon(
          Icons.check,
          size: 15.r,
          color: Colors.white,
        ),
      ),
    );
  }
}