import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthier2/models/patient.model.dart';
import 'package:healthier2/repositories/consultation.repository.dart';
import 'package:healthier2/repositories/prescription.repository.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/widgets/empty.list.dart';
import 'package:healthier2/widgets/prescription.item.dart';
import 'package:healthier2/widgets/styles/KTextStyle.dart';

class ConsultationListScreen extends StatefulWidget {
  const ConsultationListScreen({super.key});

  @override
  State<ConsultationListScreen> createState() => _ConsultationsState();
}

class _ConsultationsState extends State<ConsultationListScreen> {
  @override
  void initState() {
    // TODO: implement local notification
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, PatientModel>? args = ModalRoute.of(context)
        ?.settings
        .arguments as Map<String, PatientModel>?;

    //TODO: add condition to check whether it is pharmacist or individual patient
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColorScheme.primary,
        title: KTextStyle(
            text: "Consultations",
            color: lightColorScheme.surface,
            fontWeight: FontWeight.w700,
            size: 20),
      ),
      body: StreamBuilder(
        stream: ConsultationRepository.getAll(
            patientId: args?["patient"]?.phone as String),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final clinicians = snapshot.data!;
            if (clinicians.isEmpty) {
              return buildEmptyList();
            }

            return ListView.builder(
              itemCount: clinicians.length,
              itemBuilder: (context, index) {
                return Card(
                  color: lightColorScheme.onPrimary,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: clinicians[index].isPrescribed == true
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        title: KTextStyle(
                          text: '${index}',
                          color: lightColorScheme.scrim,
                          fontWeight: FontWeight.bold,
                          size: 20.0,
                        ),
                        subtitle: KTextStyle(
                          text: clinicians[index].feelings as String,
                          color: lightColorScheme.scrim,
                          size: 14.0,
                        ),
                        iconColor: lightColorScheme.primary,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //TODO: -
                          Navigator.pushNamed(context, "/prescribe",
                              arguments: {
                                "consultation": clinicians[index],
                                "patient": args?["patient"]
                              });
                        },
                        child: Text("Prescribe"),
                      )
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
