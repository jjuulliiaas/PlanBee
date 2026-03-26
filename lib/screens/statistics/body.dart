import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/utils/app_padding.dart';
import 'package:planbee/screens/statistics/components/activity_dashboard/activity_dashboard.dart';
import 'components/golden_hour.dart';
import 'components/overview.dart';
import 'components/progress_by_category.dart';

class StatisticsBody extends StatelessWidget {
  const StatisticsBody({super.key});

  @override
  Widget build(BuildContext context) {

    final heightSpacer = SizedBox(height: 16.h);

    return SingleChildScrollView(
        padding: AppPadding.horizontalOnly(context),
        child: Column(
          children: [
            // Overview Card
            const OverviewCard(),
            heightSpacer,

            // Weekly Chart
            const ActivityDashboard(),
            heightSpacer,

            // Golden Bee Hour
            const GoldenBeeCard(),
            heightSpacer,

            // Heatmap
            // const ActivityHeatmap(),
            // heightSpacer,

            const CategoryProgressSection(),

            SizedBox(height: 100.h),
          ],
        ),
    );
  }
}

