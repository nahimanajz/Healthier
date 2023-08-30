import 'package:healthier2/models/patient.model.dart';
import 'package:healthier2/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> savePrescriptionPrefs(
    String pharmacyName, String patientId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("pharmacyName", pharmacyName);
  await prefs.setString("patientId", patientId);
  return prefs;
}

void savePatientPrefs(PatientModel patient) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("reportedPhoneNumber", patient.phone as String);
  String info =
      "${patient.name as String} from ${patient.addressCity as String}   ${patient.temp as int} °C";
  await prefs.setString("patientInfo", info);
}

Future<void> saveSignedInUser(UserModel user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("signedInUserName", user.email as String);
  await prefs.setString("signedInUserId", user.documentId as String);

  await prefs.setString("signedInUsertype", user.userType as String);
}
