import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> savePrescriptionPrefs(
    String pharmacyName, String patientId) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString("pharmacyName", pharmacyName);
  await _prefs.setString("patientId", patientId);
  return _prefs;
}
