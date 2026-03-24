import 'package:intl/intl.dart';

class DateHelper {
  static String formatShortMonthDay(DateTime date) {
    return DateFormat('MMM, d').format(date);
  }

  static String formatFullDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }
}

String getFormattedDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));
  final yesterday = today.subtract(const Duration(days: 1));
  final dateToCheck = DateTime(date.year, date.month, date.day);

  String dayText;

  if (dateToCheck == today) {
    dayText = 'Today';
  } else if (dateToCheck == tomorrow) {
    dayText = 'Tomorrow';
  } else if (dateToCheck == yesterday) {
    dayText = 'Yesterday';
  } else {
    dayText = DateHelper.formatShortMonthDay(date);
  }

  final timeText = '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

  return '$dayText, $timeText';
}