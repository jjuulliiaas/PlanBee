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
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: theme.colorScheme.primary.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16.sp, color: theme.colorScheme.primary),
              SizedBox(width: 6.w),
            ],
            Flexible(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}