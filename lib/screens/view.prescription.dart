import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthier2/main.dart';
import 'package:healthier2/models/medicine.model.dart';
import 'package:healthier2/models/obedience.model.dart';
import 'package:healthier2/repositories/medicine.repository.dart';
import 'package:healthier2/repositories/obedience.repository.dart';
import 'package:healthier2/repositories/prescription.repository.dart';
import 'package:healthier2/utils/data/medicines.dart';
import 'package:healthier2/utils/local.notification.dart';
import 'package:healthier2/utils/main.util.dart';
import 'package:healthier2/utils/toast.dart';
import 'package:healthier2/widgets/alert.dart';
import 'package:healthier2/widgets/empty.list.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/color_schemes.g.dart';
import '../widgets/styles/KTextStyle.dart';

enum UserType { patient, clinician, pharmacist }

class ViewPrescriptionScreen extends StatefulWidget {
  const ViewPrescriptionScreen({super.key});

  @override
  State<ViewPrescriptionScreen> createState() => _ViewPrescriptionState();
}

class _ViewPrescriptionState extends State<ViewPrescriptionScreen> {
  @override
  void initState() {
    super.initState();

    // ---->
    //TODO: check this precription for delayed and call method to set it to delayed missed
    //doInvestigateDelays();
    // and show notification about "we have update this medicine to be delayed to be taken"
  }

  // this method is for investing delays that a patient might have donw
  doInvestigateDelays() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prescriptionId = prefs.getString("NofitiablePrescriptionId");
    String? patientId = prefs.getString("NofitiablePatientId");

    //
    Stream<List<MedicineModel>> medStream = MedicineRepository.getAll(
        phone: patientId as String, prescriptionId: prescriptionId as String);
    List<MedicineModel> medicinesList = await medStream
        .asyncExpand((list) => Stream.fromIterable(list))
        .toList();
    DateTime startDate;
    DateTime endDate;
    DateTime currentTime = DateTime.now();

    for (MedicineModel element in medicinesList) {
      startDate = DateTime.parse(element.date as String);
      endDate = DateTime.parse(element.endDate as String);

      if (currentTime.isAfter(startDate) && currentTime.isBefore(endDate)) {
        String status = checkStatus(element.timeOfTheDay);
        String period = checkPeriod(element.timeOfTheDay);
        if (period.isNotEmpty && period != "on time") {
          ObedienceModel obedience = ObedienceModel(
              period: period,
              status: status,
              date: currentTime.toIso8601String(),
              medicineName: element.name);

          ObedienceRepository.createMissedDoses(
              obedience, patientId, prescriptionId);
          prefs.setBool("hasToNotify", true);

          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: KTextStyle(
          text: " ${args?['illness']}",
          color: lightColorScheme.background,
          size: 16,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: lightColorScheme.primary,
      ),
      body: StreamBuilder(
        stream: MedicineRepository.getAll(
            phone: args?["patientId"], prescriptionId: args?["prescriptionId"]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final medicines = snapshot.data!;
            if (medicines.isEmpty) {
              return buildEmptyList();
            }
            return ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                return buildPresciptionItem(
                    medicine: medicines[index],
                    medicineId: medicines[index].documentId as String,
                    isAvailable: medicines[index].isAvailable as bool,
                    patientId: args?["patientId"],
                    prescriptionId: args?["prescriptionId"],
                    illness: args?["illness"],
                    description: formatDescription(medicines[index]),
                    title: "${medicines[index].name as String ?? " "}",
                    isPharmacist: args?["isPharmacist"]);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Flexible buildPresciptionItem({
    required MedicineModel medicine,
    required bool isAvailable,
    required String patientId,
    required String title,
    required String illness,
    required String description,
    required String prescriptionId,
    required bool isPharmacist,
    required String medicineId,
  }) {
    return Flexible(
      child: Card(
        color: lightColorScheme.onPrimary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: FaIcon(FontAwesomeIcons.pills),
              title: KTextStyle(
                text: title,
                color: lightColorScheme.scrim,
                fontWeight: FontWeight.bold,
                size: 20.0,
              ),
              subtitle: KTextStyle(
                text: description,
                color: lightColorScheme.scrim,
                size: 14.0,
              ),
              iconColor: lightColorScheme.primary,
            ),
            buildUserActionButton(
                medicine: medicine,
                isAvailable: isAvailable,
                medicineId: medicineId,
                patientId: patientId,
                prescriptionId: prescriptionId,
                illness: illness,
                title: title,
                isPharmacist: isPharmacist),
          ],
        ),
      ),
    );
  }

  Widget buildUserActionButton(
      {MedicineModel? medicine,
      bool? isAvailable,
      String? patientId,
      String? prescriptionId,
      String? illness,
      String? title,
      required bool isPharmacist,
      required String medicineId}) {
    if (isPharmacist && isAvailable == false) {
      return OutlinedButton(
        onPressed: () {
          try {
            PrescriptionRepository.approveMedicine(
                patientId: patientId,
                prescriptionId: prescriptionId,
                medicineId: medicineId);
            showMedicineApprovedToast(context);
          } catch ($e) {
            showAlert(context, title: "Failed", desc: " Something went wrong");
          }
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: lightColorScheme.onPrimary,
        ),
        child: KTextStyle(
          text: 'Approve availability',
          color: lightColorScheme.primary,
          size: 14.0,
        ),
      );
    } else if (isPharmacist && isAvailable == true) {
      return Icon(
        Icons.check,
        color: lightColorScheme.primary,
        size: 24,
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/rate-medicine", arguments: {
              "prescriptionId": prescriptionId,
              "patientId": patientId,
              "illness": illness,
              "medicineName": title
            });
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: lightColorScheme.onPrimary,
          ),
          child: KTextStyle(
            text: 'Provide Feedback',
            color: lightColorScheme.primary,
            size: 14.0,
          ),
        ),
        OutlinedButton(
          onPressed: () {
            String period = checkPeriod(medicine?.timeOfTheDay);
            ObedienceModel obedience = ObedienceModel(
                period: period,
                date: DateTime.now().toIso8601String(),
                status: "Taken",
                medicineName: medicine?.name);
            ObedienceRepository.create(
                obedience, patientId as String, prescriptionId as String);
            showMedicineTakenToast(context);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: lightColorScheme.onPrimary,
          ),
          child: KTextStyle(
            text: 'Take',
            color: lightColorScheme.primary,
            size: 14.0,
          ),
        ),
      ],
    );
  }
}
