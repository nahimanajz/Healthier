import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthier2/models/medicine.model.dart';
import 'package:healthier2/models/obedience.model.dart';
import 'package:healthier2/models/prescription.model.dart';
import 'package:healthier2/repositories/medicine.repository.dart';
import 'package:healthier2/repositories/obedience.repository.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:healthier2/repositories/prescription.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  /// Loop all prescriptions
  ///  choose on-going prescription
  ///  then check morning, noon, after noon, and evening hours
  ///  if time to take medicine arrived send notification to user
  ///  it is delayed then mark update medicine as taken, delayed or missed
  ///

  static Future<List<PrescriptionModel>> getNotifiablePrescriptions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String usertype = await prefs.getString("signedInUsertype") as String;
    String patientEmail = await prefs.getString("signedInUserId") as String;

    var patient = await PatientRepository.getByEmail(patientEmail);

    // if (usertype != null && usertype.toLowerCase() == "patient") {
    return await PrescriptionRepository.getAllForNotification(
        patientId: patient?.phone);
    //}
    //return null;
  }

  static Future<List<MedicineModel>> getNotifiableMedicines(
      String prescriptionId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String patientEmail = await prefs.getString("signedInUserId") as String;
    var patient = await PatientRepository.getByEmail(patientEmail);

    return await MedicineRepository.getAllForNotification(
        phone: patient?.phone as String, prescriptionId: prescriptionId);
  }

  static Future<void> createMissedDoses(
      {required ObedienceModel obedience,
      required String patientEmail,
      required String prescriptionId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var patient = await PatientRepository.getByEmail(patientEmail);

    await ObedienceRepository.createMissedDoses(
        obedience, patient?.phone as String, prescriptionId);
  }
}
