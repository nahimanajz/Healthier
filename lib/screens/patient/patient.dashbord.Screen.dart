import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthier2/models/patient.model.dart';
import 'package:healthier2/screens/patient/consulation.screen.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/widgets/styles/KTextStyle.dart';
import '../../widgets/styles/gradient.decoration.dart';

class PatientDashboardScreen extends StatefulWidget {
  const PatientDashboardScreen({super.key});
  @override
  State<StatefulWidget> createState() => _PatientDashboardScreenState();
}

class _PatientDashboardScreenState extends State<PatientDashboardScreen> {
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
    final patientInfo = args?["patientInfo"] as PatientModel?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient"),
        backgroundColor: lightColorScheme.secondary,
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.bedPulse,
              color: lightColorScheme.tertiary,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/patient/consultation");
            },
          ),
          IconButton(
            icon: Icon(
              Icons.info,
              color: lightColorScheme.tertiary,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/patientInfo");
            },
          ),
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
          // TODO show list of medicine and and add button to add new medicine which opens bottom sheet form
          child: Text("patients list of medicine"),
        ),
      ),
      drawer: PatientNavDrawer(patient: patientInfo),
    );
  }
}

class PatientNavDrawer extends StatelessWidget {
  final PatientModel? patient;
  PatientNavDrawer({Key? key, this.patient}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xfffffffff),
      surfaceTintColor: const Color(0xfffffffff),
      width: 250,
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
            leading: const Icon(Icons.add_rounded),
            title: const KTextStyle(
              color: Colors.black87,
              size: 16,
              text: "Consultation",
              fontWeight: FontWeight.w400,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.wrap_text),
            title: const KTextStyle(
              color: Colors.black87,
              size: 16,
              text: "Prescriptions",
              fontWeight: FontWeight.w400,
            ),
            onTap: () {
              print("patient id${patient?.addressCity as String}");
              Navigator.of(context).pushNamed("/prescriptionsList",
                  arguments: {"patientId": patient?.phone as String});
            },
          ),
        ],
      ),
    );
  }
}
