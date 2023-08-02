import 'package:flutter/material.dart';
import 'package:healthier/screens/view.prescription.dart';

import 'utils/color_schemes.g.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      //home: const HomeScreen(),
      // home: const PrescribeScreen(),
      // home: const DosageScreen(),
      home: const ViewPrescriptionScreen(),
    ),
  );
}
