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
    dayText = '${date.day}.${date.month}';
  }

  return '$dayText, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
}