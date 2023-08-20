import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> onSaveUser({String? phone, String usertype = "clinician"}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  if (usertype == "patient") {
    preferences.setString("patientId", phone as String);
  }
  preferences.setString("userType", usertype);
}

Future<dynamic> getSignedUser(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userType = preferences.getString("userType");

  switch (userType) {
    case "clinician":
      return Navigator.pushNamed(context, "/dashbord");
    case "pharmacy":
      return Navigator.pushNamed(context, "/pharmacy/detail");
    case "patient":
      return Navigator.pushNamed(context, "/verifyPatient");
    default:
      return null;
  }
}

Future<String> getPatientIdnPreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userType = preferences.getString("patientId");
  return userType as String;
}
