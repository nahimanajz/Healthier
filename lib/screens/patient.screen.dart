import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthier2/models/patient.model.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:healthier2/services/country.service.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/widgets/styles/gradient.decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_textFormField.dart';
import '../widgets/styles/KTextStyle.dart';

class PatientInfoScreen extends StatefulWidget {
  const PatientInfoScreen({super.key});

  @override
  State<PatientInfoScreen> createState() => _PrescribeInfoScreenState();
}

class _PrescribeInfoScreenState extends State<PatientInfoScreen> {
  final _fullNamesController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _residencyCityController = TextEditingController();

  String prescriptionTitle = "Patient Address";
  String districtQuery = "";
  int residenceTemp = 0;

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //TODO: this back works after implementing navigations
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: lightColorScheme.primary),
        ),
        backgroundColor: lightColorScheme.secondary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              buildPatientAddressForm(),
              buildStepperButton(() async {
                final pref = await SharedPreferences.getInstance();
                String? patientEmail = pref.getString("signedInUserName");

                var patient = PatientModel(
                    addressCity: _residencyCityController.text,
                    name: _fullNamesController.text,
                    phone: _phoneNumberController.text,
                    temp: residenceTemp.toInt(),
                    email: patientEmail as String);

                await PatientRepository.create(patient);

                await Navigator.pushNamed(context, "/patient/dashboard",
                    arguments: {"patientId": patient.phone});
              })
            ],
          ),
        ),
      ),
    );
  }

  Flexible buildPatientAddressForm() {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            KTextStyle(
              text: prescriptionTitle,
              color: lightColorScheme.onSurface,
              size: 16.0,
              fontWeight: FontWeight.w500,
            ),
            buildTextFormField("Full Names", _fullNamesController),
            buildTextFormField("Phone Number", _phoneNumberController,
                keyboardType: TextInputType.phone),
            buildTextFormField("Residence District", _residencyCityController,
                onChanged: (value) async {
              int temp = await CountryService.getTemperature(city: value);
              if (temp == 0) {
                temp = await CountryService.getTemperature();
              }
              setState(() {
                residenceTemp = temp;
              });
            }),
          ],
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
