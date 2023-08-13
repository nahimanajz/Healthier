import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthier2/models/patient.model.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:healthier2/services/country.service.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/widgets/styles/gradient.decoration.dart';

import '../utils/data/data.dart';
import '../widgets/custom_textFormField.dart';
import '../widgets/styles/KTextStyle.dart';

class PatientInfoScreen extends StatefulWidget {
  const PatientInfoScreen({super.key});

  @override
  State<PatientInfoScreen> createState() => _PrescribeInfoScreenState();
}

class _PrescribeInfoScreenState extends State<PatientInfoScreen> {
  final _formKeyOne = GlobalKey<FormState>();

  final _fullNamesController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _residencyCityController = TextEditingController();
  final _residenceTempController = TextEditingController();

  String prescriptionTitle = "Patient Address";
  String districtQuery = "";

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
                buildPatientAddressForm(),
                buildStepperButton(() async {
                  /**
                    *  TODO: 1. get temperature
                    *  2. save this record in database
                      3. navigate to prescription form
                    *
                    */
                  var patient = PatientModel(
                    addressCity: _residencyCityController.text,
                    name: _fullNamesController.text,
                    phone: _phoneNumberController.text,
                    temp: int.tryParse(
                      _residenceTempController.text,
                    ),
                  );

                  PatientRepository.create(patient);

                  // await Navigator.pushNamed(context, "/dosage");
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Flexible buildPatientAddressForm() {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKeyOne,
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
              buildSelectFormField(_residencyCityController, districtsData,
                  labelText: 'Districts',
                  searchHint: 'Search District',
                  dialogTitle: 'Residence City', onChanged: (value) async {
                double temp = await CountryService.getTemperature(city: value);
                //TODO:
                // if (temp) {
                //   temp = await CountryService.getTemperature();
                // }
              })
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
