import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../blocks/category/provider.dart';
import '../../../blocks/statistics/provider.dart';
import '../../../generated/l10n.dart';

class CategoryProgressSection extends StatelessWidget {
  const CategoryProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsProvider>();
    final theme = Theme.of(context);
    final progressList = stats.categoryProgress;
    final $ = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Text($.progressByCategory, style: theme.textTheme.titleMedium),
        ),
        ...progressList.map((data) => _CategoryProgressCard(
          categoryId: data['id'],
          icon: data['icon'],
          progress: data['progress'],
        )),
      ],
    );
  }
}

class _CategoryProgressCard extends StatelessWidget {
  final String categoryId;
  final IconData icon;
  final double progress;

  const _CategoryProgressCard({
    required this.categoryId,
    required this.icon,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final localizedName = categoryId.toCategoryName(context);

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: 20.r,
                        color: theme.colorScheme.primary,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          localizedName,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8.h,
                backgroundColor: colorScheme.primary.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}