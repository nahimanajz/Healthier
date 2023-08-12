import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthier2/models/patient.model.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:healthier2/screens/clinician/dashboard.dart';
import 'package:healthier2/screens/dosage.screen.dart';
import 'package:healthier2/screens/home.dart';
import 'package:healthier2/screens/pharmacy.detail.screen.dart';
import 'package:healthier2/screens/prescribe.screen.dart';
import 'package:healthier2/screens/prescriptions.list.screen.dart';
import 'package:healthier2/screens/rate.medicine.screen.dart';
import 'package:healthier2/screens/verify.patient.records.dart';
import 'package:healthier2/screens/view.prescription.dart';
import 'package:healthier2/utils/local.notification.dart';

import 'utils/color_schemes.g.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var patient = PatientModel();
  patient.name = "Janvier";
  patient.addressCity = "Kigali";
  patient.phone = "0785343588";
  patient.prescriptions = null;
  patient.temp = 23;

  
  PatientRepository.getAllPatients();

  // // initialize notifications
  // LocalNotification.initialize(flutterLocalNotificationsPlugin);
  // HOW CAN I hot reload?

  runApp(
    MaterialApp(
      routes: {
        '/': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/prescribe': (context) => const PrescribeScreen(),
        '/dosage': (context) => const DosageScreen(),
        '/prescriptionsList': (context) => const PrescriptionsListScreen(),
        '/verifyPatient': (context) => const VerifyPatientRecordsScreen(),
        '/prescription/detail': (context) => const ViewPrescriptionScreen(),
        '/rate-medicine': (context) => const RateMedicineScreen(),
        '/pharmacy/detail': (context) => const PharmacyDetailScreen(),
      },
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    ),
  );
}
