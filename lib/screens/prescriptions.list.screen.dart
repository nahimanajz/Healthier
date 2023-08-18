import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:healthier2/repositories/prescription.repository.dart';
import 'package:healthier2/widgets/empty.list.dart';

import '../main.dart';
import '../utils/color_schemes.g.dart';
import '../utils/local.notification.dart';
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
  void initState() {
    // TODO: implement local notification
    super.initState();
    /*
    LocalNotification.showNotification(
        title: "Pill reminder",
        body: "Please remember to take your medicine",
        fln: flutterLocalNotificationsPlugin);
        */
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    bool isPharmacist = args?["pharmacyName"] != null ? true : false;
    bool isAccessingReport = args?["isAccessingReport"] != null ? true : false;

    //TODO: add condition to check whether it is pharmacist or individual patient
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColorScheme.primary,
        title: KTextStyle(
            text: "My prescriptions",
            color: lightColorScheme.surface,
            fontWeight: FontWeight.w700,
            size: 20),
      ),
      body: StreamBuilder(
        stream: PrescriptionRepository.getAll(patientId: args?["patientId"]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final prescriptions = snapshot.data!;
            if (prescriptions.isEmpty) {
              return buildEmptyList();
            }

            return ListView.builder(
              itemCount: prescriptions.length,
              itemBuilder: (context, index) {
                return buildPrescriptionItem(context, prescriptions[index],
                    patientId: args?["patientId"],
                    isPharmacist: isPharmacist,
                    isAccessingReport: isAccessingReport);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
