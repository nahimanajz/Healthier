// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthier2/models/prescription.model.dart';

import 'package:healthier2/widgets/styles/KTextStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/color_schemes.g.dart';

Widget buildPrescriptionItem(
    BuildContext context, PrescriptionModel prescription,
    {required String patientId,
    bool isPharmacist = false,
    bool isAccessingReport = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      color: lightColorScheme.surface,
      border: const Border(
        bottom: BorderSide(width: 1.0),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KTextStyle(
            text: "Prescription for ${prescription.illness}",
            color: lightColorScheme.scrim,
            size: 14),
        IconButton(
            onPressed: () async {
              if (!isAccessingReport && !isPharmacist) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("NofitiablePrescriptionId",
                    prescription.documentId as String);
                prefs.setString("NofitiablePatientId", patientId);
              }

              if (isAccessingReport == true) {
                Navigator.pushNamed(context, "/clinician/report",
                    arguments: {"prescriptionId": prescription.documentId});
              } else {
                Navigator.pushNamed(context, "/prescription/detail",
                    arguments: {
                      "prescriptionId": prescription.documentId,
                      "illness": prescription.illness,
                      "patientId": patientId,
                      "isPharmacist": isPharmacist
                    });
              }
            },
            icon: Icon(Icons.info, color: lightColorScheme.surfaceTint))
      ],
    ),
  );
}
