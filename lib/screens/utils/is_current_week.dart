class IsCurrentWeek {
  static bool isCurrentWeek(DateTime date) {
    final now = DateTime.now();
    // Get the first day of the current week (Monday by ISO 8601 standard)
    final firstDayOfWeek = now.subtract(
      Duration(days: now.weekday - DateTime.monday + 1),
    );
    // Get the last day of the current week (Sunday)
    final lastDayOfWeek = firstDayOfWeek.add(
      const Duration(days: DateTime.sunday - DateTime.monday + 1),
    );

    return date.isAfter(firstDayOfWeek) && date.isBefore(lastDayOfWeek);
  }
}
