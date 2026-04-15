import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/utils/app_padding.dart';
import 'package:planbee/screens/statistics/components/activity_dashboard/weekly_chart.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../generated/l10n.dart';
import '../../../all_tasks/components/browser_tab_indicator.dart';
import 'activity_heat_map.dart';

class ActivityDashboard extends StatelessWidget {
  const ActivityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final $ = S.of(context);

    return DefaultTabController(
      length: 2,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppPadding.screen(context),
              child: Text(
                $.activity,
                style: textTheme.bodyLarge,
              ),
            ),
            
            Padding(
              padding: AppPadding.horizontalOnly(context),
              child: Container(
                height: 35.h, 
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppTheme.radiusLarge),
                    topRight: Radius.circular(AppTheme.radiusLarge),
                  ),
                ),
                child: TabBar(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.only(top: 4.h),

                  indicator: BrowserTabIndicator(
                    color: colorScheme.surface,
                    borderColor: colorScheme.primary.withOpacity(0.1),
                    radius: AppTheme.radiusLarge,
                    horizontalPadding: 12.w,
                  ),

                  labelColor: colorScheme.onSecondaryContainer,
                  unselectedLabelColor: colorScheme.secondary,
                  labelStyle: theme.textTheme.bodyMedium,

                  tabs: [
                    Tab(text: $.weekly),
                    Tab(text: $.yearly),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 320.h,
              child: const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  WeeklyActivityCard(),
                  YearActivityHeatmap(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
