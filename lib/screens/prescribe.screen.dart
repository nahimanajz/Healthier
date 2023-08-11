import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthier/services/country.service.dart';
import 'package:healthier/utils/color_schemes.g.dart';
import 'package:healthier/widgets/styles/gradient.decoration.dart';

import '../utils/data/data.dart';
import '../utils/data/medicines.dart';
import '../widgets/custom_textFormField.dart';
import '../widgets/styles/KTextStyle.dart';

class PrescribeScreen extends StatefulWidget {
  const PrescribeScreen({super.key});

  @override
  State<PrescribeScreen> createState() => _PrescribeScreenState();
}

class _PrescribeScreenState extends State<PrescribeScreen> {
  final _formKeyOne = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  final _fullNamesController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _residencyCityController = TextEditingController();
  final _medicineNameController = TextEditingController();
  final _medicineTypeController = TextEditingController();

  String prescriptionTitle = "Patient Address";
  int activeTab = 1;
  String districtQuery = "";

  @override
  void initState() {
    super.initState();
    CountryService.getTemperature();

    print("get weather${CountryService.getTemperature()}");
    _fullNamesController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _fullNamesController.dispose();
    _phoneNumberController.dispose();
    _residencyCityController.dispose();
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
                showActiveStep(),
                buildStepperButton(() async {
                  if (activeTab == 2) {
                    debugPrint(_medicineTypeController.text);
                    /**
                    *  TODO: 1. get temperature
                    *  2. save this record in database
                      3. navigate to prescription form
                    *
                    */

                    await Navigator.pushNamed(context, "/dosage");
                  }
                  setState(
                      () => activeTab = activeTab == 1 ? activeTab += 1 : 1);
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Flexible buildStepOne() {
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
                  dialogTitle: 'Residence City'),
            ],
          ),
        ),
      ),
    );
  }

  Flexible buildStepTwo() {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(20.0),
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
              buildTextFormField("Medicine Name", _medicineNameController),
              buildSelectFormField(_medicineTypeController, medicines,
                  labelText: 'Medicine Type',
                  dialogTitle: ' Medicine type',
                  searchHint: 'Search medicine')
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

  Widget showActiveStep() {
    if (activeTab == 1) {
      return buildStepOne();
    }
    return buildStepTwo();
  }
}
