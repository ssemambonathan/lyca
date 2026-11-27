const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

bool _isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// "Today", "Yesterday", or "16 Nov"
String formatDayLabel(DateTime date, {DateTime? now}) {
  final today = now ?? DateTime.now();
  if (_isSameDay(date, today)) return 'Today';
  if (_isSameDay(date, today.subtract(const Duration(days: 1)))) {
    return 'Yesterday';
  }
  return '${date.day} ${_months[date.month - 1]}';
}

/// "3:45 PM"
String formatTime(DateTime date) {
  final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
  final minute = date.minute.toString().padLeft(2, '0');
  final suffix = date.hour >= 12 ? 'PM' : 'AM';
  return '$hour12:$minute $suffix';
}