import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickedChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  const PickedChip({super.key, required this.label, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
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