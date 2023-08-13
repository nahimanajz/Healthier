// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:healthier2/models/prescription.model.dart';

import 'package:healthier2/widgets/styles/KTextStyle.dart';

import '../utils/color_schemes.g.dart';

Widget buildPrescriptionItem(PrescriptionModel prescription) {
  BuildContext context;
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
            onPressed: () {
              //Navigator.pushNamed(context,
              //   "/prescription/detail"); //better to pass prescription Id
            },
            icon: Icon(Icons.info, color: lightColorScheme.surfaceTint))
      ],
    ),
  );
}
