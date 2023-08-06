import 'package:flutter/material.dart';
import 'package:healthier/utils/color_schemes.g.dart';

import '../widgets/back.to.home.button.dart';
import '../widgets/custom_textFormField.dart';

class VerifyPatientRecordsScreen extends StatefulWidget {
  const VerifyPatientRecordsScreen({super.key});

  @override
  State<VerifyPatientRecordsScreen> createState() =>
      _VerifyPatientRecordsScreenState();
}

class _VerifyPatientRecordsScreenState
    extends State<VerifyPatientRecordsScreen> {
  final _phoneNumberController = TextEditingController();

  var screenHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleVerify() {
    //TODO: handle verify from database then redirect to view list with all related prescriptions

    Navigator.pushNamed(context, "/prescriptionsList");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: buildBackToHomeButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: lightColorScheme.secondary,
      body: SafeArea(
        child: ListView(
          children: [buildCard()],
        ),
      ),
    );
  }

  Widget buildCard() => Card(
        margin: EdgeInsets.only(left: 0.0, top: 70.0, right: 0.0, bottom: 0.0),
        elevation: 2,
        color: lightColorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: lightColorScheme.primary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  )),
              child: const Text(
                "Let\'s Verify your records",
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              color: lightColorScheme.surface,
              height: screenHeight - (screenHeight * 50 / 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildTextFormField("Phone", _phoneNumberController,
                      keyboardType: TextInputType.phone),
                  ElevatedButton(
                    onPressed: handleVerify,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: lightColorScheme.primary,
                        minimumSize: const Size.fromHeight(50)),
                    child: Text(
                      "Verify",
                      style: TextStyle(color: lightColorScheme.surface),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
