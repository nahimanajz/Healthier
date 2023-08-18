import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:healthier2/utils/firebase.instance.dart';

class ObedienceService {
  static Future<String?> scheduleDoseReminder(
      List<Map<String, dynamic>> medicines) async {
    // Get the current time
    DateTime currentTime = DateTime.now();

    for (var medicine in medicines) {
      if (medicine is Map<String, dynamic> &&
          medicine.containsKey('date') &&
          medicine.containsKey('endDate') &&
          medicine.containsKey('timeOfTheDay')) {
        DateTime startDate = DateTime.parse(medicine['date']);
        DateTime endDate = DateTime.parse(medicine['endDate']);
        String timeOfTheDay = medicine['timeOfTheDay'].toString().toLowerCase();

        // Check if the current time is within the start and end dates of the medicine
        if (currentTime.isAfter(startDate) && currentTime.isBefore(endDate)) {
          // Check if the current time is in the morning and the medicine's periods include 'morning'
          _doCheckPendingMedicine(timeOfTheDay, currentTime);
        }
      }
    }
  }

  static Future<List<Map<String, dynamic>>> getPatientMedicines(
      String patientId) async {
    List<Map<String, dynamic>> allMedicines = [];
    var prescriptionsSnapshot =
        await PatientRepository.getPatientPrescriptions();

    if (prescriptionsSnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot prescriptionDoc
          in prescriptionsSnapshot.docs) {
        Map<String, dynamic> prescriptionData =
            prescriptionDoc.data() as Map<String, dynamic>;

        if (prescriptionData.containsKey('medicines') &&
            prescriptionData['medicines'] is List) {
          List<dynamic> medicines = prescriptionData['medicines'];

          for (var medicine in medicines) {
            if (medicine is Map<String, dynamic>) {
              allMedicines.add(medicine);
            }
          }
        }
      }
    }
    return allMedicines;
  }
}

String _doCheckPendingMedicine(String timeOfTheDay, DateTime currentTime) {
  String message = "";
  if (timeOfTheDay.contains('morning') && currentTime.hour < 12) {
    message = "Kindly take morning dose(s)";
  } else if (timeOfTheDay.contains('noon') &&
      currentTime.hour > 12 &&
      currentTime.hour < 17) {
    message = "Kindly take Noon dose(s)";
  } else if (timeOfTheDay.contains('noon') &&
      currentTime.hour > 17 &&
      currentTime.hour < 21) {
    message = "Kindly take evening dose(s)";
  } else if (timeOfTheDay.contains('noon') &&
      currentTime.hour > 21 &&
      currentTime.hour < 23) {
    message = "Kindly take Night dose(s)";
  }
  return message;
}


// TODO: Update obedience as notified, sent notification to a mobile form
// check notified prescription and notify to 