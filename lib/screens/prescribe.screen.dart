import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthier2/models/consultation.model.dart';
import 'package:healthier2/models/patient.model.dart';
import 'package:healthier2/models/prescription.model.dart';
import 'package:healthier2/repositories/consultation.repository.dart';
import 'package:healthier2/repositories/prescription.repository.dart';

import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/widgets/styles/gradient.decoration.dart';
import '../utils/data/medicines.dart';
import '../widgets/custom_textFormField.dart';
import '../widgets/styles/KTextStyle.dart';

class PrescribeScreen extends StatefulWidget {
  const PrescribeScreen({super.key});

  @override
  State<PrescribeScreen> createState() => _PrescribeScreenState();
}

class _PrescribeScreenState extends State<PrescribeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _medicineNameController = TextEditingController();
  final _illnessText = TextEditingController();
  final _medicineTypeController = TextEditingController();

  String prescriptionTitle = "Prescribe";
  String districtQuery = "kigali";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final patientArgs = args?["patient"] as PatientModel?;
    final consultationArgs = args?["consultation"] as ConsultationModel?;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: lightColorScheme.primary),
        ),
        backgroundColor: lightColorScheme.secondary,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: gradientDecoration,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 1,
                  child: Center(
                    child: SvgPicture.asset('assets/images/clinic.svg'),
                  ),
                ),
                buildMedicineInfoForm(),
                buildStepperButton(() async {
                  var presciption =
                      PrescriptionModel(illness: _illnessText.text);
                  var createdPres = await PrescriptionRepository.create(
                      phone: patientArgs?.phone as String,
                      prescriptionData: presciption);
                  ConsultationRepository.markAsPrescribed(
                      consultationId: consultationArgs?.documentId as String,
                      patientId: patientArgs?.phone as String);

                  await Navigator.pushNamed(context, "/dosage", arguments: {
                    "prescriptionId": createdPres?.id,
                    "medicineName": _medicineNameController.text,
                    "medicineType": _medicineTypeController.text,
                    "illness": _illnessText.text,
                    "phone": patientArgs?.phone as String
                  });
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Flexible buildMedicineInfoForm() {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              KTextStyle(
                text: prescriptionTitle,
                color: lightColorScheme.onSurface,
                size: 16.0,
                fontWeight: FontWeight.w500,
              ),
              buildTextFormField("Illness", _illnessText),
              buildTextFormField("Medicine Name", _medicineNameController),
              buildSelectFormField(
                _medicineTypeController,
                medicines,
                labelText: 'Medicine Type',
                dialogTitle: ' Medicine type',
                searchHint: 'Search medicine',
              )
            ],
          ),
        ),
      ),
    );
  }

  Flexible buildStepperButton(Function() onPressed,
      {String title = 'Continue'}) {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: lightColorScheme.primary),
          child: Text(
            title,
            style: TextStyle(color: lightColorScheme.surface),
          ),
        ),
      ),
    );
  }
}
