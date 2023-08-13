import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthier2/models/medicine.model.dart';

final List<Map<String, dynamic>> medicines = [
  {
    'value': 'Tablet',
    'label': 'Tablet',
    'icon': const FaIcon(FontAwesomeIcons.pills)
  },
  {
    'value': 'Liquid',
    'label': 'Liquid',
    'icon': Icon(Icons.medication_liquid_outlined),
  },
  {
    'value': 'Drops',
    'label': 'Drops',
    'icon': const FaIcon(FontAwesomeIcons.droplet)
  }
];

String formatTimeOfDay(bool morning, bool noon, bool evening, bool night) {
  var result;
  if (morning) {
    result = "Morning";
  }
  if (noon) {
    result = result + ", Noon";
  }
  if (evening) {
    result = result + ", Evening";
  }
  if (night) {
    result = result + ", Night";
  }
  return result;
}

String formatTobeTaken(int number) {
  if (number == 1) {
    return "Before food";
  } else if (number == 2) {
    return "After Food";
  }
  return "Anytime";
}

String formatDuration(int repeat) {
  if (repeat == 1) {
    return "days";
  } else if (repeat == 2) {
    return "weeks";
  }
  return "months";
}

String formatDescription(MedicineModel medicine) {
  return "${medicine.dosage} ${medicine.medicineType} for ${medicine.duration} ${medicine.repeat} in ${medicine.timeOfTheDay}  ${medicine.tobeTakenAt}";
}
