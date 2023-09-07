import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthier2/models/patient.model.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:healthier2/services/country.service.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/utils/toast.dart';
import 'package:healthier2/widgets/styles/gradient.decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_textFormField.dart';
import '../widgets/styles/KTextStyle.dart';

class EditPatientScreen extends StatefulWidget {
  const EditPatientScreen({super.key});

  @override
  State<EditPatientScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditPatientScreen> {
  final _fullNamesController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _residencyCityController = TextEditingController();

  String prescriptionTitle = "Patient Address";
  String districtQuery = "";
  int residenceTemp = 0;
  final _formKeyTwo = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onDelete(BuildContext context, phone) async {
    try {
      await PatientRepository.delete(phone);
      Navigator.pushNamed(context, "/dashboard");
    } catch (e) {
      showErrorToast(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, PatientModel>? args = ModalRoute.of(context)
        ?.settings
        .arguments as Map<String, PatientModel>?;
    var currentPatient = args?["patient"];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              onDelete(context, currentPatient?.phone as String);
            },
            icon: Icon(Icons.delete, color: lightColorScheme.primary),
          )
        ],
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
                child: KTextStyle(
                    text:
                        "    ${currentPatient?.name as String} from ${currentPatient?.addressCity as String} where \n     temperature is ${currentPatient?.temp} °C",
                    color: lightColorScheme.scrim,
                    size: 16),
              ),
              buildPatientAddressForm(),
              buildSubmitButton(() async {
                if (_formKeyTwo.currentState!.validate()) {
                  try {
                    var patient = PatientModel(
                      addressCity: _residencyCityController.text ??
                          currentPatient?.addressCity as String,
                      name: _fullNamesController.text ??
                          currentPatient?.name as String,
                      phone: _phoneNumberController.text ??
                          currentPatient?.phone as String,
                      temp: residenceTemp.toInt() ?? currentPatient?.temp,
                    );
                    await PatientRepository.update(patient);
                    Navigator.pop(context);
                  } catch (e) {
                    showErrorToast(context);
                  }
                }
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
      child: Form(
        key: _formKeyTwo,
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
              buildPhoneField(_phoneNumberController),
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
      ),
    );
  }

  Flexible buildSubmitButton(Function() onPressed, {String title = 'Update'}) {
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
