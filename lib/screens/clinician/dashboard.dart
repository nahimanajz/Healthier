import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
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
          backgroundColor: const Color.fromARGB(255, 98, 80, 27)),
      body: Container(
        decoration: gradientDecoration,
        padding: EdgeInsets.all(20),
        child: Center(
          child: buildTextFormField("Phone Number", phoneTxt),
        ),
      ),
      drawer: const NavigationDrawer(),
      floatingActionButton: buildFaButton(
        context,
        () async {
          //TODO: HANDLE search,
          var patient = await PatientRepository.getPhoneNumber(phoneTxt.text);
          if (patient?.name != null) {
            debugPrint("patient not found");
          }
          print(patient?.name);
          Navigator.pushNamed(context, "/prescribe", arguments: {
            "patientName": patient?.name,
            "patientPhoneNumber": patient?.phone
          });
        },
        Icon(Icons.arrow_forward, color: lightColorScheme.background),
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
              fontWeight: FontWeight.w300,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.wrap_text),
            title: KTextStyle(
              color: Colors.black87,
              size: 16,
              text: "Prescribe",
              fontWeight: FontWeight.w300,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/patientInfo");
            },
          ),
          ListTile(
            leading: Icon(Icons.download),
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
          Divider(
            thickness: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: KTextStyle(
              color: Colors.black87,
              size: 16,
              text: "Feedback",
              fontWeight: FontWeight.w300,
            ),
            onTap: () {
              // TODO: Download all records from firebase in pdf format
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: KTextStyle(
              color: Colors.black87,
              size: 16,
              text: "Adherence",
              fontWeight: FontWeight.w300,
            ),
            onTap: () {
              // TODO: Download all records from firebase in pdf format
            },
          ),
        ],
      ),
    );
  }
}
