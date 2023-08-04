import 'package:flutter/material.dart';

import '../utils/color_schemes.g.dart';
import '../widgets/prescription.item.dart';
import '../widgets/styles/KTextStyle.dart';

class PrescriptionsListScreen extends StatefulWidget {
  const PrescriptionsListScreen({super.key});

  @override
  State<PrescriptionsListScreen> createState() =>
      _PrescriptionsListScreenState();
}

class _PrescriptionsListScreenState extends State<PrescriptionsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorScheme.primary,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  //height: ,
                  child: Wrap(
                    runSpacing: 0,
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      KTextStyle(
                          text: "Hello, Patient Name",
                          color: lightColorScheme.surface,
                          fontWeight: FontWeight.w700,
                          size: 20),
                      KTextStyle(
                          text: "These are your prescriptions",
                          color: lightColorScheme.surface,
                          size: 20),
                      //TODO: add prescription then navigate to prescriptiondetail when user taps i
                    ],
                  ),
                ),
                PrescriptionItem(),
                PrescriptionItem(),
                PrescriptionItem(),
                PrescriptionItem(),
                PrescriptionItem(),
                PrescriptionItem(),
                PrescriptionItem(),
                PrescriptionItem(),
                PrescriptionItem(),
                PrescriptionItem(),
                PrescriptionItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
