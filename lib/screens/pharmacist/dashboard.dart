import 'package:flutter/material.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/widgets/styles/KTextStyle.dart';
import '../../widgets/styles/gradient.decoration.dart';

class PharmacistDashboardScreen extends StatefulWidget {
  const PharmacistDashboardScreen({super.key});
  @override
  State<StatefulWidget> createState() => _PharmacistDashboardScreenState();
}

class _PharmacistDashboardScreenState extends State<PharmacistDashboardScreen> {
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
        title: const Text("Welcome Pharmacist"),
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
          // TODO show list of medicine and and add button to add new medicine which opens bottom sheet form
          child: Text("pharmacist"),
        ),
      ),
      drawer: const PharmacistNavDrawer(),
    );
  }
}

class PharmacistNavDrawer extends StatelessWidget {
  const PharmacistNavDrawer({Key? key}) : super(key: key);
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
              text: "Medicine",
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
              // Navigator.of(context).pushNamed("/patientInfo");
            },
          ),
        ],
      ),
    );
  }
}
