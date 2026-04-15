import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/theme/colors_extension.dart';
import 'package:provider/provider.dart';
import '../../../../blocks/statistics/provider.dart';
import '../../../../generated/l10n.dart';
import 'hint.dart';

class YearActivityHeatmap extends StatelessWidget {
  const YearActivityHeatmap({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StatsProvider>();
    final monthlyData = provider.monthlyActivity;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final customColors = theme.extension<AppColorsExtension>();

    final $ = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatsHint(text: $.monthlyConsistency),
              _buildLegend(context, theme, colorScheme, customColors!),
            ],
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.r,
                crossAxisSpacing: 10.r,
                childAspectRatio: 1.1,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final activity = monthlyData[index];
                final monthName = _getMonthName(context, index);
                final percentage = (activity * 100).round();

                return GestureDetector(
                  onTap: () => _showMonthDetails(
                    context,
                    monthName,
                    percentage,
                    activity,
                    theme,
                    customColors,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 400 + (index * 50)),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, animValue, child) {
                            return Transform.scale(
                              scale: animValue,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.lerp(
                                    colorScheme.secondaryContainer,
                                    customColors.yellow,
                                    activity,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: activity > 0.7 ? [
                                    BoxShadow(
                                      color: customColors.yellow.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    )
                                  ] : null,
                                ),
                                child: Center(
                                  child: activity > 0.9
                                      ? Text('🐝', style: TextStyle(fontSize: 10.sp))
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        monthName,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: activity > 0 ? colorScheme.onSecondaryContainer : colorScheme.outline,
                          fontSize: 10.sp,
                          fontWeight: activity > 0.5 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Show push hint
  void _showMonthDetails(
      BuildContext context,
      String month,
      int percent,
      double activity,
      ThemeData theme,
      AppColorsExtension colors,
      ) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Text(activity > 0.8 ? '🐝 ' : '🍯 '),
            Text(
              '$month: $percent% tasks completed',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: activity > 0.5 ? Colors.black87 : Colors.white,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        width: 260.w,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        backgroundColor: activity > 0.5 ? colors.yellow : theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildLegend(BuildContext context, ThemeData theme, ColorScheme colorScheme, AppColorsExtension customColors) {
    final $ = S.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text($.low, style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.outline, fontSize: 10.sp)),
        _buildLevelBox(colorScheme.secondaryContainer),
        _buildLevelBox(customColors.yellow.withOpacity(0.5)),
        _buildLevelBox(customColors.yellow),
        Text($.high, style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.outline, fontSize: 10.sp)),
      ],
    );
  }

  Widget _buildLevelBox(Color color) {
    return Container(
      width: 8.r,
      height: 8.r,
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  String _getMonthName(BuildContext context, int index) {
    final $ = S.of(context);
    final months = [
      $.monthJan,
      $.monthFeb,
      $.monthMar,
      $.monthApr,
      $.monthMay,
      $.monthJun,
      $.monthJul,
      $.monthAug,
      $.monthSep,
      $.monthOct,
      $.monthNov,
      $.monthDec,
    ];
    return months[index];
  }
}