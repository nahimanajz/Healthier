import 'package:flutter/material.dart';
import 'package:healthier/utils/color_schemes.g.dart';
import 'package:healthier/widgets/styles/KTextStyle.dart';
import '../../widgets/styles/gradient.decoration.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Dashboard"),
          backgroundColor: Colors.amber.shade100),
      body: Container(
        decoration: gradientDecoration,
        child: Image.asset("assets/images/clinicians.png"),
      ),
      drawer: const NavigationDrawer(),
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
      padding: EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
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
              Navigator.of(context).pushNamed("/prescribe");
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
              // TODO: Download all records from firebase in pdf format
            },
          )
        ],
      ),
    );
  }
}
