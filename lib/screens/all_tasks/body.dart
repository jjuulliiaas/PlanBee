import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../blocks/all_tasks/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../generated/l10n.dart';
import 'components/browser_tab_indicator.dart';
import 'components/filters.dart';
import 'components/pages/calendar_page.dart';
import 'components/pages/list_page.dart';
import 'controller.dart';

class AllTasksBody extends StatelessWidget {
  const AllTasksBody({super.key});

  @override
  Widget build(BuildContext context) {
    final allTasksProvider = context.watch<AllTasksProvider>();
    final controller = AllTasksController(context);
    final theme = Theme.of(context);
    final $ = S.of(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          $.allTasks,
                        style: theme.textTheme.headlineSmall
                      ),

                      IconButton(
                        onPressed: () => controller.onShowSortMenu(),
                        icon: Icon(Icons.tune_rounded, size: 20.r),
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  Container(
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
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
                        color: theme.colorScheme.secondaryContainer,
                        borderColor: theme.colorScheme.primary.withOpacity(0.1),
                        radius: AppTheme.radiusLarge,
                        horizontalPadding: 12.w,
                      ),

                      labelColor: theme.colorScheme.onSecondaryContainer,
                      unselectedLabelColor: theme.colorScheme.secondary,
                      labelStyle: theme.textTheme.bodyMedium,

                      tabs: [
                        _buildTab(context, $.list),
                        _buildTab(context, $.calendar),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          FilterBar(controller: controller),

          Expanded(
            child: TabBarView(
              children: [
                AllTasksListPage(tasks: allTasksProvider.filteredTasks, controller: controller),
                AllTasksCalendarPage(
                  controller: controller,
                  selectedDay: allTasksProvider.selectedDay,
                  tasksForDay: allTasksProvider.tasksForSelectedDay,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String title) {
    return Tab(
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              title,
          ),
        ],
      ),
    );
  }
}