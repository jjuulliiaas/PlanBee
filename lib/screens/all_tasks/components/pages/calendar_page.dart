import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../blocks/all_tasks/provider.dart';
import '../../../../blocks/task/model.dart';
import '../../../../blocks/task/provider.dart';
import '../../../../core/utils/app_padding.dart';
import '../../../home/components/task_card/task_card.dart';
import '../../controller.dart';

class AllTasksCalendarPage extends StatelessWidget {
  final AllTasksController controller;
  final DateTime selectedDay;
  final List<TaskModel> tasksForDay;

  const AllTasksCalendarPage({
    super.key,
    required this.controller,
    required this.selectedDay,
    required this.tasksForDay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: selectedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (selected, focused) => controller.onDaySelected(selected),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                leftChevronIcon: Icon(Icons.chevron_left, color: theme.colorScheme.primary, size: 20),
                rightChevronIcon: Icon(Icons.chevron_right, color: theme.colorScheme.primary, size: 20),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: theme.textTheme.labelLarge!.copyWith(
                  color: theme.colorScheme.outline,
                ),
                weekendStyle: theme.textTheme.labelLarge!.copyWith(
                  color: Colors.redAccent.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                todayDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                todayTextStyle: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.underline,
                  decorationColor: theme.colorScheme.primary,
                ),
                markersMaxCount: 1,
                markerSize: 5.r,
                markerDecoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                markerMargin: EdgeInsets.only(top: 6.h),
                outsideDaysVisible: false,
                defaultTextStyle: theme.textTheme.bodyMedium!,
                weekendTextStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.redAccent.withOpacity(0.8)),
              ),
              eventLoader: (day) {
                final tasksOnDay = context.read<TaskProvider>().getTasksByDay(day);
                final filter = context.read<AllTasksProvider>().filterStatus;

                if (filter == null) return tasksOnDay;

                return tasksOnDay.where((t) => t.effectiveStatus == filter).toList();
              },
            ),
          ),
        ),

        tasksForDay.isEmpty
            ? SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Free day! 🐝",
                    style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.outline)
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        )
            : SliverPadding(
          padding: AppPadding.screen(context),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final taskId = tasksForDay[index].id;

                return Selector<TaskProvider, TaskModel>(
                  selector: (_, prov) => prov.tasks.firstWhere((t) => t.id == taskId),
                  builder: (context, updatedTask, _) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: TaskCard(
                        key: ValueKey('cal_${updatedTask.id}_${updatedTask.status.name}'),
                        task: updatedTask,
                        onStatusChanged: (val) => controller.onToggleTaskStatus(updatedTask, val),
                        onTap: () => controller.navigateToTaskDetails(updatedTask),
                      ),
                    );
                  },
                );
              },
              childCount: tasksForDay.length,
            ),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 100.h)),
      ],
    );
  }
}