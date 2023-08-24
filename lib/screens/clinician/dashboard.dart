import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:healthier2/repositories/patient.repository.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/utils/preferences.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    phoneTxt.text = phoneTxt.text ?? args?["patientId"];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quick Prescription"),
        backgroundColor: lightColorScheme.secondary,
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
          ),
        ],
      ),
      body: Container(
        decoration: gradientDecoration,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: buildTextFormField("Phone Number", phoneTxt),
        ),
      ),
      drawer: const ClinicianNavDrawer(),
      floatingActionButton: SpeedDial(
        children: [
          SpeedDialChild(
            backgroundColor: lightColorScheme.primary,
            shape: const CircleBorder(),
            child: Icon(Icons.book, color: lightColorScheme.background),
            label: 'Reports',
            onTap: () async {
              var patient =
                  await PatientRepository.getPhoneNumber(phoneTxt.text);

              if (patient?.phone != null) {
                Navigator.pushNamed(context, '/prescriptionsList', arguments: {
                  "patientId": patient?.phone,
                  "isAccessingReport": true
                });
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: lightColorScheme.primary,
            shape: const CircleBorder(),
            child: Icon(Icons.arrow_forward, color: lightColorScheme.secondary),
            label: 'Prescribe',
            onTap: () async {
              var patient =
                  await PatientRepository.getPhoneNumber(phoneTxt.text);

              if (patient != null) {
                savePatientPrefs(patient);
                Navigator.pushNamed(context, '/prescribe', arguments: {
                  "patientName": patient.name,
                  "patientPhoneNumber": patient.phone
                });
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: lightColorScheme.primary,
            shape: const CircleBorder(),
            child: Icon(Icons.location_city, color: lightColorScheme.secondary),
            label: 'Edit info',
            onTap: () async {
              var patient =
                  await PatientRepository.getPhoneNumber(phoneTxt.text);

              if (patient != null) {
                savePatientPrefs(patient);
                Navigator.pushNamed(context, '/edit/patientInfo',
                    arguments: {"patient": patient});
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: lightColorScheme.primary,
            shape: const CircleBorder(),
            child: Icon(Icons.question_mark, color: lightColorScheme.secondary),
            label: 'Consultations',
            onTap: () async {
              var patient =
                  await PatientRepository.getPhoneNumber(phoneTxt.text);

              if (patient != null) {
                savePatientPrefs(patient);
                Navigator.pushNamed(context, '/clinician/consultations',
                    arguments: {"patient": patient});
              }
            },
          ),
        ],
        child: const Icon(Icons.menu),
      ),
    );
  }
}

class ClinicianNavDrawer extends StatelessWidget {
  const ClinicianNavDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xfffffffff),
      surfaceTintColor: const Color(0xfffffffff),
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
      padding: const EdgeInsets.all(12),
      child: Wrap(
        runSpacing: 2,
        children: [
          const Divider(
            thickness: 1.0,
          ),
          ListTile(
            leading: const Icon(Icons.home_filled),
            title: const KTextStyle(
              color: Colors.black87,
              size: 16,
              text: "Home",
              fontWeight: FontWeight.w400,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.wrap_text),
            title: const KTextStyle(
              color: Colors.black87,
              size: 16,
              text: "Prescribe",
              fontWeight: FontWeight.w400,
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/patientInfo");
            },
          ),
        ],
      ),
    );
  }
}
