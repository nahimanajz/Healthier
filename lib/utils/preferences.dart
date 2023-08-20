import 'dart:ffi';

import 'package:healthier2/models/patient.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> savePrescriptionPrefs(
    String pharmacyName, String patientId) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString("pharmacyName", pharmacyName);
  await _prefs.setString("patientId", patientId);
  return _prefs;
}

void savePatientPrefs(PatientModel patient) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();

  String info =
      "${patient.name as String} from ${patient.addressCity as String}   ${patient.temp as int} °C";

  await _prefs.setString("patientInfo", info);
}
