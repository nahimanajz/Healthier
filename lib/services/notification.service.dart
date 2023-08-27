import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthier2/models/prescription.model.dart';
import 'package:healthier2/repositories/prescription.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  /// Loop all prescriptions
  ///  choose on-going prescription
  ///  then check morning, noon, after noon, and evening hours
  ///  if time to take medicine arrived send notification to user
  ///  it is delayed then mark update medicine as taken, delayed or missed
  ///
  static Future<List<PrescriptionModel>> getNotifiableMedicines() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String usertype = await prefs.getString("signedInUsertype") as String;
    String petientId = await prefs.getString("signedInUserId") as String;

    // if (usertype != null && usertype.toLowerCase() == "patient") {
    return await PrescriptionRepository.getAllForNotification(
        patientId: petientId);
    //}
    //return null;
  }
}
