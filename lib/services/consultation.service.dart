import 'package:healthier2/models/consultation.model.dart';
import 'package:healthier2/repositories/consultation.repository.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultationService {
  static Future<void> create(ConsultationModel consultation) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? patietnEmail =
          await prefs.getString("signedInUserName"); // patient email

      final patient =
          await PatientRepository.getPatientByEmail(email: patietnEmail);
      await ConsultationRepository.create(consultation,
          patientId: patient.phone);
    } catch (e) {
      throw Exception("something went wrong");
    }
  }
}
