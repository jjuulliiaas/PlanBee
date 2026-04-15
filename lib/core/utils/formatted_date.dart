import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';

class DateHelper {
  static String formatShortMonthDay(DateTime date, String locale) {
    return DateFormat('MMM, d', locale).format(date);
  }

  static String formatFullDate(DateTime date, String locale) {
    return DateFormat('dd.MM.yyyy', locale).format(date);
  }
}

String getFormattedDate(BuildContext context, DateTime date) {
  final $ = S.of(context);
  final locale = Localizations.localeOf(context).languageCode;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));
  final yesterday = today.subtract(const Duration(days: 1));
  final dateToCheck = DateTime(date.year, date.month, date.day);

  String dayText;

  if (dateToCheck == today) {
    dayText = $.today;
  } else if (dateToCheck == tomorrow) {
    dayText = $.tomorrow;
  } else if (dateToCheck == yesterday) {
    dayText = $.yesterday;
  } else {
    dayText = DateHelper.formatShortMonthDay(date, locale);
  }

  final timeText = DateFormat.Hm(locale).format(date);

  return '$dayText, $timeText';
}