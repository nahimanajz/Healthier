import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthier2/repositories/medicine.repository.dart';
import 'package:healthier2/utils/data/medicines.dart';

import '../utils/color_schemes.g.dart';
import '../widgets/styles/KTextStyle.dart';

enum UserType { patient, clinician, pharmacist }

class ViewPrescriptionScreen extends StatefulWidget {
  // TODO: Loop List of prescription medicines
  const ViewPrescriptionScreen({super.key});

  @override
  State<ViewPrescriptionScreen> createState() => _ViewPrescriptionState();
}

class _ViewPrescriptionState extends State<ViewPrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //TODO: this back works after implementing navigations
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: lightColorScheme.primary,
      ),
      body: StreamBuilder(
        stream: MedicineRepository.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final medicines = snapshot.data!;

            return ListView.builder(
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                return buildPresciptionItem(
                    prescriptionId: args?["prescriptionId"],
                    illness: args?["illness"],
                    description: formatDescription(medicines[index]),
                    title: "${medicines[index].name as String}");
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Flexible buildPresciptionItem(
      {required String title,
      required String illness,
      required String description,
      required String prescriptionId}) {
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
            //TODO: if is patient show provide feedback button,elseif user== pharmacist show approve availability
            1 == 0
                ? OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: lightColorScheme.onPrimary,
                    ),
                    child: KTextStyle(
                      text: 'Approve availability',
                      color: lightColorScheme.primary,
                      size: 14.0,
                    ),
                  )
                : OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/rate-medicine",
                          arguments: {
                            "prescriptionId": prescriptionId,
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
          ],
        ),
      ),
    );
  }
}
