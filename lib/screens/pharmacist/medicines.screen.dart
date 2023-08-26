import 'package:flutter/material.dart';
import 'package:healthier2/models/drugstore.model.dart';
import 'package:healthier2/models/patient.model.dart';
import 'package:healthier2/models/user.model.dart';
import 'package:healthier2/repositories/consultation.repository.dart';
import 'package:healthier2/repositories/drugstore.repository.dart';
import 'package:healthier2/repositories/medicine.repository.dart';
import 'package:healthier2/services/drugstore.service.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/widgets/empty.list.dart';
import 'package:healthier2/widgets/styles/KTextStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicinesScreen extends StatelessWidget {
  const MedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, UserModel>? userArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, UserModel>?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColorScheme.primary,
        title: KTextStyle(
            text: "Medicines",
            color: lightColorScheme.surface,
            fontWeight: FontWeight.w700,
            size: 20),
      ),
      body: StreamBuilder(
        stream: DrugStoreRepository.getByPharmacyId(
            pharmacyId: userArgs?["user"]?.documentId as String),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final drugs = snapshot.data!;
            if (drugs.isEmpty) {
              return buildEmptyList();
            }

            return ListView.builder(
              itemCount: drugs.length,
              itemBuilder: (context, index) {
                return Card(
                  color: lightColorScheme.onPrimary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        horizontalTitleGap: 20,
                        minVerticalPadding: 30,
                        selectedColor: lightColorScheme.secondary,
                        onTap: () => Navigator.pushNamed(
                            context, "/pharmacist/drugStore", arguments: {
                          "drugstore": drugs[index],
                          "isEditing": true
                        }),
                        dense: true,
                        leading: drugs[index].quantity as int < 1
                            ? Text("out of stock")
                            : Text("available"),
                        title: KTextStyle(
                          text: drugs[index].medicineName as String,
                          color: lightColorScheme.scrim,
                          fontWeight: FontWeight.bold,
                          size: 20.0,
                        ),
                        subtitle: KTextStyle(
                          text: drugs[index].quantity.toString(),
                          color: lightColorScheme.scrim,
                          size: 14.0,
                        ),
                        iconColor: lightColorScheme.primary,
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
