import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthier/repositories/patient.repository.dart';
import 'package:healthier/screens/clinician/dashboard.dart';
import 'package:healthier/screens/dosage.screen.dart';
import 'package:healthier/screens/home.dart';
import 'package:healthier/screens/pharmacy.detail.screen.dart';
import 'package:healthier/screens/prescribe.screen.dart';
import 'package:healthier/screens/prescriptions.list.screen.dart';
import 'package:healthier/screens/rate.medicine.screen.dart';
import 'package:healthier/screens/verify.patient.records.dart';
import 'package:healthier/screens/view.prescription.dart';
import 'package:healthier/utils/local.notification.dart';

import 'utils/color_schemes.g.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PatientRepository.getAllPatients();
  // initialize notifications
  LocalNotification.initialize(flutterLocalNotificationsPlugin);

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
