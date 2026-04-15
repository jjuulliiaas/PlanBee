import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:planbee/core/utils/app_padding.dart';
import 'package:provider/provider.dart';
import '../../../blocks/statistics/provider.dart';
import '../../../core/theme/colors_extension.dart';
import '../../../generated/l10n.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StatsProvider>();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final $ = S.of(context);
    final heightSpacer = SizedBox(height: 16.h);

    return Card(
      child: Padding(
        padding: AppPadding.screen(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text($.overview, style: textTheme.bodyLarge),
            heightSpacer,
            Row(
              children: [
                _PremiumCircleProgress(
                  progress: provider.completionRate,
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                ),

                const Spacer(),

                _buildStatItem(context, provider.totalCount.toString(), $.tasksCreated),
                SizedBox(width: 24.w),
                _buildStatItem(context, provider.activeCount.toString(), $.toDo),
              ],
            ),
            heightSpacer,
            const Divider(),
            const _ChartLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium
        ),
        Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: colorScheme.outline)),
      ],
    );
  }
}

class _PremiumCircleProgress extends StatelessWidget {
  final double progress;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _PremiumCircleProgress({
    required this.progress,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final double initialValue = (progress * 100).clamp(0, 100);
    final customColors = Theme.of(context).extension<AppColorsExtension>();

    return SleekCircularSlider(
      initialValue: initialValue,
      appearance: CircularSliderAppearance(
        size: 70.r,
        startAngle: 270,
        angleRange: 360,
        customWidths: CustomSliderWidths(
          progressBarWidth: 15.r,
          trackWidth: 15.r,
          shadowWidth: 1,
        ),
        customColors: CustomSliderColors(
          progressBarColor: customColors?.success,
          trackColor: customColors?.successSoft,
          hideShadow: true,
        ),
        infoProperties: InfoProperties(
          mainLabelStyle: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          modifier: (double value) {
            return '${value.toInt()}%';
          },
        ),
      ),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  const _ChartLegend();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(color: colorScheme.outline);
    final customColors = Theme.of(context).extension<AppColorsExtension>();
    final $ = S.of(context);

    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _legendItem(customColors!.success, $.completed, labelStyle),
          SizedBox(width: 24.w),
          _legendItem(customColors.successSoft, $.remaining, labelStyle),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label, TextStyle? style) {
    return Row(
      children: [
        Container(
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Text(label, style: style),
      ],
    );
  }
}