import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthier2/models/consultation.model.dart';
import 'package:healthier2/repositories/consultation.repository.dart';
import 'package:healthier2/services/consultation.service.dart';

import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/utils/toast.dart';
import 'package:healthier2/widgets/back.to.home.button.dart';
import 'package:healthier2/widgets/styles/gradient.decoration.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreen();
}

class _ConsultationScreen extends State<ConsultationScreen> {
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: lightColorScheme.primary),
        ),
        backgroundColor: lightColorScheme.secondary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: gradientDecoration,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 1,
                child: Center(
                  child: SvgPicture.asset('assets/images/clinic.svg'),
                ),
              ),
              buildPatientAddressForm(),
              buildSignButton(title: "Save", () async {
                try {
                  final consultation =
                      ConsultationModel(feelings: descriptionController.text);
                  await ConsultationService.create(consultation);

                  await Navigator.pushNamed(context, "/patient/dashboard");
                } catch (e) {
                  showErrorToast(context);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Flexible buildPatientAddressForm() {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          minLines: 3,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          controller: descriptionController,
          decoration: InputDecoration(
            labelText: "Feelings",
            hintText: 'Provide your abnormacy feeligns',
            labelStyle: TextStyle(color: lightColorScheme.primary),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 3, color: lightColorScheme.secondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: lightColorScheme.primary),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(width: 7, color: lightColorScheme.primary),
            ),
          ),
        ),
      ),
    );
  }
}
