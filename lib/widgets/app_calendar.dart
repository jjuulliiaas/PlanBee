import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalendar extends StatelessWidget {
  const AppCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final firstDate = DateTime.now().subtract(const Duration(days: 365));
    final lastDate = DateTime.now().add(const Duration(days: 3650));

    return TableCalendar(
      firstDay: firstDate,
      lastDay: lastDate,
      focusedDay: selectedDate,
      currentDay: DateTime.now(),
      selectedDayPredicate: (day) => isSameDay(selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        onDateChanged(selectedDay);
      },

      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: textTheme.bodyLarge!.copyWith(
          color: colorScheme.primary,
        ),
        leftChevronIcon: Icon(Icons.chevron_left, color: colorScheme.primary),
        rightChevronIcon: Icon(Icons.chevron_right, color: colorScheme.primary),
      ),

      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: textTheme.bodyMedium!,
        weekendStyle: textTheme.bodyMedium!
      ),

      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: colorScheme.primary, width: 1.w),
        ),
        todayTextStyle: TextStyle(color: colorScheme.primary),

        selectedDecoration: BoxDecoration(
          color: colorScheme.primary,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(color: colorScheme.surface),

        defaultTextStyle: textTheme.bodyMedium!.copyWith(color: colorScheme.secondary),
        outsideTextStyle: textTheme.bodySmall!.copyWith(color: colorScheme.outline),
      ),

      rowHeight: 45.h,
      startingDayOfWeek: StartingDayOfWeek.monday,
    );
  }
}
