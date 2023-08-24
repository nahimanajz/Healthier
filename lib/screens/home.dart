import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthier2/services/user.service.dart';
import 'package:healthier2/utils/background_service.dart';
import 'package:healthier2/widgets/custom_icon_button.dart';
import 'package:healthier2/widgets/custom_textFormField.dart';
import 'package:healthier2/widgets/styles/KTextStyle.dart';

import '../utils/color_schemes.g.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _phoneTxtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSignedUser(context);
    initializeService();
    FlutterBackgroundService().invoke("setAsBackground");
    FlutterBackgroundService().invoke("setAsForeground");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                //TODO: OPEN bottom sheet modal

                onSaveUser(usertype: "pharmacist");
                Navigator.pushNamed(context, "/pharmacy/detail");
              },
            ),
            CustomIconButton(
              userType: "Clinician",
              icon: Icon(Icons.local_hospital,
                  color: lightColorScheme.primary, size: 90.0),
              onNavigateTo: () {
                onSaveUser(usertype: "clinician");
                Navigator.pushNamed(context, "/dashboard");
              },
            ),
            CustomIconButton(
              userType: "Patient",
              icon: Icon(Icons.hotel_sharp,
                  color: lightColorScheme.primary, size: 90.0),
              onNavigateTo: () {
                _showFullModal(context, "/verifyPatient", usertype: 'patient');
              },
            ),
          ],
        ),
      ),
    );
  }

  _showFullModal(context, String route, {required String usertype}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: lightColorScheme.scrim,
                    width: 1,
                  ),
                ),
              ),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KTextStyle(
                        text: usertype,
                        size: 20,
                        color: lightColorScheme.primary,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  buildTextFormField("Phone", _phoneTxtController),
                  ElevatedButton(
                    onPressed: () {
                      onSaveUser(
                          phone: _phoneTxtController.text, usertype: "patient");
                      Navigator.pushNamed(context, route);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: lightColorScheme.primary,
                      shape: StadiumBorder(
                        side: BorderSide(color: lightColorScheme.primary),
                      ),
                    ),
                    child: KTextStyle(
                      text: "Sign in",
                      color: lightColorScheme.onPrimary,
                      size: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
