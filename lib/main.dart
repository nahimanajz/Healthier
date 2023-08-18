import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:healthier2/screens/clinician/comment.table.dart';
import 'package:healthier2/screens/clinician/dashboard.dart';
import 'package:healthier2/screens/clinician/obedience.table.dart';
import 'package:healthier2/screens/clinician/report.screen.dart';
import 'package:healthier2/screens/dosage.screen.dart';
import 'package:healthier2/screens/home.dart';
import 'package:healthier2/screens/pharmacy.detail.screen.dart';
import 'package:healthier2/screens/patient.screen.dart';
import 'package:healthier2/screens/prescribe.screen.dart';
import 'package:healthier2/screens/prescriptions.list.screen.dart';
import 'package:healthier2/screens/rate.medicine.screen.dart';
import 'package:healthier2/screens/verify.patient.records.dart';
import 'package:healthier2/screens/view.prescription.dart';
import 'package:healthier2/utils/background_service.dart';

import 'utils/color_schemes.g.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //PatientRepository.getAllPatients();

  // // initialize notifications
  // LocalNotification.initialize(flutterLocalNotificationsPlugin);
  // HOW CAN I hot reload?

  runApp(
    MaterialApp(
      routes: {
        '/': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/patientInfo': (context) => const PatientInfoScreen(),
        '/prescribe': (context) => const PrescribeScreen(),
        '/dosage': (context) => const DosageScreen(),
        '/prescriptionsList': (context) => const PrescriptionsListScreen(),
        '/verifyPatient': (context) => const VerifyPatientRecordsScreen(),
        '/prescription/detail': (context) => const ViewPrescriptionScreen(),
        '/rate-medicine': (context) => const RateMedicineScreen(),
        '/pharmacy/detail': (context) => const PharmacyDetailScreen(),
        '/clinician/report': (context) => const ReportScreen(),
        '/comments/table': (context) => CommentsTable(),
        '/obedience/table': (context) => ObedienceTable()
      },
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    ),
  );
}
