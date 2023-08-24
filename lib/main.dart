import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthier2/screens/clinician/comment.table.dart';
import 'package:healthier2/screens/clinician/dashboard.dart';
import 'package:healthier2/screens/clinician/obedience.table.dart';
import 'package:healthier2/screens/clinician/report.screen.dart';
import 'package:healthier2/screens/dosage.screen.dart';
import 'package:healthier2/screens/edit.patient.screen.dart';
import 'package:healthier2/screens/home.dart';
import 'package:healthier2/screens/patient/consulation.screen.dart';
import 'package:healthier2/screens/patient/patient.dashbord.Screen.dart';
import 'package:healthier2/screens/pharmacist/dashboard.dart';
import 'package:healthier2/screens/pharmacy.detail.screen.dart';
import 'package:healthier2/screens/patient.screen.dart';
import 'package:healthier2/screens/prescribe.screen.dart';
import 'package:healthier2/screens/prescriptions.list.screen.dart';
import 'package:healthier2/screens/rate.medicine.screen.dart';
import 'package:healthier2/screens/signin.screen.dart';
import 'package:healthier2/screens/signup.screen.dart';
import 'package:healthier2/screens/verify.patient.records.dart';
import 'package:healthier2/screens/view.prescription.dart';
import 'package:healthier2/utils/local.notification.dart';

import 'utils/color_schemes.g.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotification.initialize(flutterLocalNotificationsPlugin);
  LocalNotification.showNotification(
      body: "Reminder",
      title: "Expect reminder notification",
      fln: flutterLocalNotificationsPlugin);
  runApp(
    MaterialApp(
      routes: {
        //'/': (context) => const HomeScreen(),
        '/': (context) => const SignupScreen(),
        '/signin': (context) => const SignInScreen(),
        '/pharmacist/dashboard': (context) => const PharmacistDashboardScreen(),
        //'/pharmacist/addMedicine': (context) => const AddMedicineScreen(),
        '/patient/dashboard': (context) => const PatientDashboardScreen(),
        '/patient/consultation': (context) => const ConsultationScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/patientInfo': (context) => const PatientInfoScreen(),
        '/edit/patientInfo': (context) => const EditPatientScreen(),
        '/prescribe': (context) => const PrescribeScreen(),
        '/dosage': (context) => const DosageScreen(),
        '/prescriptionsList': (context) => const PrescriptionsListScreen(),
        '/verifyPatient': (context) => const VerifyPatientRecordsScreen(),
        '/prescription/detail': (context) => const ViewPrescriptionScreen(),
        '/rate-medicine': (context) => const RateMedicineScreen(),
        '/pharmacy/detail': (context) => const PharmacyDetailScreen(),
        '/clinician/report': (context) => const ReportScreen(),
        '/comments/table': (context) => const CommentsTable(),
        '/obedience/table': (context) => const ObedienceTable()
      },
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    ),
  );
}
