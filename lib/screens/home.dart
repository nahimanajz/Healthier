import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthier/widgets/custom_icon_button.dart';

import '../utils/color_schemes.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColorScheme.primary,
        title: const Text(
          "Mention who you are to continue",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Roboto'),
        ),
      ),
      backgroundColor: lightColorScheme.primary,
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(12.0, 40, 12.0, 0.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
          children: [
            CustomIconButton(
              userType: "Pharmacist",
              icon: FaIcon(
                FontAwesomeIcons.userNurse,
                size: 96,
                color: lightColorScheme.primary,
              ),
              onNavigateTo: () {
                Navigator.pushNamed(context, "/pharmacy/detail");
              },
            ),
            CustomIconButton(
              userType: "Clinician",
              icon: Icon(Icons.local_hospital,
                  color: lightColorScheme.primary, size: 90.0),
              onNavigateTo: () {
                Navigator.pushNamed(context, "/prescribe");
              },
            ),
            CustomIconButton(
              userType: "Patient",
              icon: Icon(Icons.hotel_sharp,
                  color: lightColorScheme.primary, size: 90.0),
              onNavigateTo: () {
                Navigator.pushNamed(context, "/verifyPatient");
              },
            ),
          ],
        ),
      ),
    );
  }
}
