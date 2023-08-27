DateTime calculateEndDate(DateTime startDate, int duration, String unit) {
  switch (unit) {
    case 'days':
      return startDate.add(Duration(days: duration));
    case 'weeks':
      return startDate.add(const Duration(days: 7));
    case 'months':
      return DateTime(
          startDate.year, startDate.month + duration, startDate.day);
    default:
      throw ArgumentError("Invalid unit. Use 'days', 'weeks', or 'months'.");
  }
}

String checkPeriod(timeOfTheDay) {
  timeOfTheDay.toString().toLowerCase();
  DateTime currentTime = DateTime.now();
  String period = "morning";
  if (timeOfTheDay.contains('morning') && currentTime.hour < 12) {
    return period;
  } else if (timeOfTheDay.contains('noon') &&
      currentTime.hour > 12 &&
      currentTime.hour < 17) {
    return "noon";
  } else if (timeOfTheDay.contains('evening') &&
      currentTime.hour > 17 &&
      currentTime.hour < 21) {
    return "evening";
  } else if (timeOfTheDay.contains('night') &&
      currentTime.hour > 21 &&
      currentTime.hour < 23) {
    return "night";
  }
  return period;
}

String checkStatus(timeOfTheDay) {
  timeOfTheDay.toString().toLowerCase();
  DateTime currentTime = DateTime.now();
  String status = "";

  if (timeOfTheDay.contains('morning') && currentTime.hour < 13) {
    status = "delayed in morning";
  } else if (timeOfTheDay.contains('noon') &&
      currentTime.hour > 13 &&
      currentTime.hour < 18) {
    status = "delayed at noon ";
  } else if (timeOfTheDay.contains('evening') &&
      currentTime.hour > 18 &&
      currentTime.hour < 21) {
    status = "delayed during evening";
  } else if (timeOfTheDay.contains('night') &&
      currentTime.hour > 21 &&
      currentTime.hour < 23) {
    status = "delayed night";
  }
  return status;
}
