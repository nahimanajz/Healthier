import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthier/utils/color_schemes.g.dart';
import 'package:healthier/widgets/styles/gradient.decoration.dart';

import '../widgets/styles/KTextStyle.dart';

class PrescribeScreen extends StatefulWidget {
  const PrescribeScreen({super.key});

  @override
  State<PrescribeScreen> createState() => _PrescribeScreenState();
}

class _PrescribeScreenState extends State<PrescribeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNamesController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _residencyCityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fullNamesController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _fullNamesController.dispose();
    _phoneNumberController.dispose();
    _residencyCityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          KTextStyle(
                            text: 'Patient Address',
                            color: lightColorScheme.onSurface,
                            size: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          buildTextFormField(
                              "Full Names", _fullNamesController),
                          buildTextFormField(
                              "Phone Number", _phoneNumberController),
                          buildTextFormField(
                              "Residency City", _residencyCityController),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint(_fullNamesController.text);
                        debugPrint(_phoneNumberController.text);
                        debugPrint(_residencyCityController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: lightColorScheme.primary),
                      child: Text(
                        "Continue",
                        style: TextStyle(color: lightColorScheme.surface),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildTextFormField(
      String title, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: lightColorScheme.background,
        labelText: title,
        labelStyle: TextStyle(
            color: lightColorScheme.scrim,
            fontSize: 14,
            decorationColor: lightColorScheme.scrim),
      ),
    );
  }
}
