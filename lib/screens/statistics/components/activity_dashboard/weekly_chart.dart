import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../../blocks/statistics/provider.dart';
import '../../../../generated/l10n.dart';
import 'hint.dart';

class WeeklyActivityCard extends StatelessWidget {
  const WeeklyActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsProvider>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final weeklyData = stats.weeklyData;
    final $ = S.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 20.h),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOutBack,
        builder: (context, animValue, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatsHint(text: $.dailyRate),
              SizedBox(height: 12.h),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 100,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => colorScheme.primaryContainer,
                        tooltipBorderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final dayName = _getDayName(context, groupIndex);
                          return BarTooltipItem(
                            '$dayName\n',
                            theme.textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                            children: [
                              TextSpan(
                                text: '${rod.toY.round()}%',
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) => _bottomTitles(context, value, weeklyData, theme),
                          reservedSize: 30,
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: _generateAnimatedBarGroups(
                      weeklyData.map((e) => e.value).toList(),
                      colorScheme,
                      animValue,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<BarChartGroupData> _generateAnimatedBarGroups(
      List<double> values, ColorScheme colorScheme, double animValue) {
    return List.generate(values.length, (index) {
      final finalValue = values[index] == 0 ? 4.0 : values[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: finalValue * animValue,
            gradient: LinearGradient(
              colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.6)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            width: 14.w,
            borderRadius: BorderRadius.circular(8.r),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: colorScheme.primary.withOpacity(0.05),
            ),
          ),
        ],
      );
    });
  }

  Widget _bottomTitles(BuildContext context, double value, List<MapEntry<String, double>> data, ThemeData theme) {
    final index = value.toInt();
    if (index < 0 || index >= data.length) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        _getDayName(context, index),
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.grey.shade500,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getDayName(BuildContext context, int index) {
    final $ = S.of(context);
    final days = [
      $.dayMon,
      $.dayTue,
      $.dayWed,
      $.dayThu,
      $.dayFri,
      $.daySat,
      $.daySun,
    ];
    return days[index];
  }
}


