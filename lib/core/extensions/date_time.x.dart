extension DateTimeX on DateTime {
  DateTime startOfDay() {
    return DateTime(year, month, day);
  }

  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999, 999);
  }

  // Adds days while keeping the same time, even if daylight saving time
  // is crossed
  DateTime addDaysSameTime(int days) {
    return DateTime(
      year,
      month,
      day + days,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  Iterable<DateTime> getDaysUntil(DateTime other,
      {bool inclusive = false}) sync* {
    var date = startOfDay();
    final endDate = other.startOfDay();
    while (date.isBefore(endDate) || (inclusive && date.isSameDayAs(endDate))) {
      yield date;
      date = date.addDaysSameTime(1);
    }
  }

  DateTime withTimeFrom(DateTime time) {
    return DateTime(year, month, day, time.hour, time.minute, time.second,
        time.millisecond, time.microsecond);
  }

  /// Returns [this] if's on the same day or on a later day than [other],
  /// otherwise [other] is returned.
  DateTime earlierDay(DateTime other) {
    if (other.startOfDay().isBefore(startOfDay())) return other;
    return this;
  }

  /// Returns [this] if's on the same day or on an earlier day than [other],
  /// otherwise [other] is returned.
  DateTime laterDay(DateTime other) {
    if (other.startOfDay().isAfter(startOfDay())) return other;
    return this;
  }

  int daysUntil(DateTime other, {bool inclusive = false}) {
    final diff = other.startOfDay().difference(startOfDay()).inDays;
    return (inclusive ? 1 : 0) * diff.sign + diff;
  }

  bool isSameDayAs(DateTime other) {
    return other.day == day && other.month == month && other.year == year;
  }

  bool get isToday {
    final now = DateTime.now();
    return isSameDayAs(now);
  }

  bool isBetween({
    required DateTime start,
    required DateTime end,
    bool inclusive = false,
  }) {
    return isBefore(end) && isAfter(start) ||
        (inclusive && (isAtSameMomentAs(start) || isAtSameMomentAs(end)));
  }

  DateTime min(DateTime other) {
    if (other.isBefore(this)) return other;
    return this;
  }

  DateTime max(DateTime other) {
    if (other.isAfter(this)) return other;
    return this;
  }
}
