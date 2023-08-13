import 'package:intl/intl.dart';

DateTime calculateEndDate(DateTime startDate, int duration, String unit) {
  switch (unit) {
    case 'days':
      return startDate.add(Duration(days: duration));
    case 'weeks':
      return startDate.add(Duration(days: 7));
    case 'months':
      return DateTime(
          startDate.year, startDate.month + duration, startDate.day);
    default:
      throw ArgumentError("Invalid unit. Use 'days', 'weeks', or 'months'.");
  }
}
