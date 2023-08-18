import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/widgets/back.to.home.button.dart';
import 'package:healthier2/widgets/custom_textFormField.dart';
import 'package:healthier2/widgets/styles/KTextStyle.dart';
import '../../widgets/styles/gradient.decoration.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final phoneTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Quick Prescription"),
          backgroundColor: lightColorScheme.secondary),
      body: Container(
        decoration: gradientDecoration,
        padding: EdgeInsets.all(20),
        child: Center(
          child: buildTextFormField("Phone Number", phoneTxt),
        ),
      ),
      drawer: const NavigationDrawer(),
      floatingActionButton: SpeedDial(
        child: Icon(Icons.menu),
        children: [
          SpeedDialChild(
            backgroundColor: lightColorScheme.primary,
            shape: CircleBorder(),
            child: Icon(Icons.book, color: lightColorScheme.background),
            label: 'Reports',
            onTap: () async {
              var patient =
                  await PatientRepository.getPhoneNumber(phoneTxt.text);
              //TODO: navigate to prescriprions list with person id parameter
              // from prescriptions navigate back to report customizer
              if (patient?.phone != null) {
                Navigator.pushNamed(context, '/prescriptionsList', arguments: {
                  "patientId": patient?.phone,
                  "isAccessingReport": true
                });
              }
              ;
            },
          ),
          SpeedDialChild(
            backgroundColor: lightColorScheme.primary,
            shape: CircleBorder(),
            child: Icon(Icons.arrow_forward, color: lightColorScheme.secondary),
            label: 'Prescribe',
            onTap: () async {
              var patient =
                  await PatientRepository.getPhoneNumber(phoneTxt.text);

              Navigator.pushNamed(context, '/prescribe', arguments: {
                "patientName": patient?.name,
                "patientPhoneNumber": patient?.phone
              });
            },
          ),
          // Add more SpeedDialChild widgets for other routes
        ],
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFFFFFFFF),
      surfaceTintColor: Color(0xFFFFFFFFF),
      width: 200,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }

  buildHeader(BuildContext context) {
    return Container(
      // color: Colors.green.shade700,
      child: Column(
        children: [
          Image.asset("assets/images/clinicians.png"),
          const SizedBox(height: 12),
          KTextStyle(
              text: "Sante Clinic",
              color: lightColorScheme.primary,
              size: 20,
              fontWeight: FontWeight.w600),
          KTextStyle(
              text: "Nyamirambo",
              color: lightColorScheme.primary,
              size: 14,
              fontWeight: FontWeight.w500),
        ],
      ),
    );
  }

  buildMenuItems(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Wrap(
        runSpacing: 2,
        children: [
          Divider(
            thickness: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: KTextStyle(
              color: Colors.black87,
              size: 16,
              text: "Home",
              fontWeight: FontWeight.w400,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.wrap_text),
            title: KTextStyle(
              color: Colors.black87,
              size: 16,
              text: "Prescribe",
              fontWeight: FontWeight.w400,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/patientInfo");
            },
          ),
          ListTile(
            leading: Icon(Icons.report_outlined),
            title: KTextStyle(
              color: Colors.black87,
              size: 16,
              text: "Reports",
              fontWeight: FontWeight.w400,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/clinician/report");
            },
          ),
        ],
      ),
    );
  }
}
