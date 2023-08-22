import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/color_schemes.g.dart';
import '../widgets/back.to.home.button.dart';
import '../widgets/custom_textFormField.dart';
import '../widgets/styles/KTextStyle.dart';
import '../widgets/styles/gradient.decoration.dart';

class PharmacyDetailScreen extends StatefulWidget {
  const PharmacyDetailScreen({super.key});

  @override
  State<PharmacyDetailScreen> createState() => _PharmacyDetailScreenState();
}

class _PharmacyDetailScreenState extends State<PharmacyDetailScreen> {
  final _nameController = TextEditingController();
  final _prescriptionCodeController = TextEditingController();
  final _pharmacyFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleSubmit() {
    //TODO: handle submit to database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildBackToHomeButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: _pharmacyFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          KTextStyle(
                            text: 'Pharmacy Detail ',
                            color: lightColorScheme.onSurface,
                            size: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          buildTextFormField(
                            "Name",
                            _nameController,
                          ),
                          buildTextFormField(
                              "Prescription Code", _prescriptionCodeController,
                              keyboardType: TextInputType.number),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //TODO: save info and then navigate to prescription
                    Navigator.pushNamed(context, "/prescription/detail");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: lightColorScheme.primary),
                  child: Text(
                    "Continue",
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
}
