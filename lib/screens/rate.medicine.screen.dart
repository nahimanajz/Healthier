import 'package:flutter/material.dart';
import 'package:healthier2/models/comment.model.dart';
import 'package:healthier2/repositories/comment.respository.dart';
import 'package:healthier2/widgets/alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utils/color_schemes.g.dart';
import '../widgets/styles/KTextStyle.dart';

enum MedicineRates { bad, good, healthy }

class RateMedicineScreen extends StatefulWidget {
  const RateMedicineScreen({super.key});

  @override
  State<RateMedicineScreen> createState() => _RateMedicineScreenState();
}

class _RateMedicineScreenState extends State<RateMedicineScreen> {
  double _currentSlideValue = 0.0;
  String rate = MedicineRates.bad.name;
  String healthPercent = 0.toString();
  final commentController = TextEditingController();
  String? prescriptionId;
  String? medicineName;
  String? illness;

  onSaveComment(BuildContext context) {
    print(medicineName);
//TODO: show toast once data are saved in db
    var comment = CommentModel(
        rate: rate, text: commentController.text, medicineName: medicineName);
    CommentRepository.create(comment, "08", prescriptionId as String);
    //TODO: SHOW ALERT MESSAGE
    showAlert(context);
  }

  onChanged(value) {
    setState(() {
      _currentSlideValue = value;
      healthPercent = _currentSlideValue.round().toString();
      if (value < 50) {
        rate = MedicineRates.bad.name;
      } else if (value == 100) {
        rate = MedicineRates.healthy.name;
      } else {
        rate = MedicineRates.good.name;
      }
    });
  }

  preparePrescription(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    setState(() {
      prescriptionId = args?["prescriptionId"];
      medicineName = args?["medicineName"];
      illness = args?["illness"];
    });
  }

  @override
  Widget build(BuildContext context) {
    preparePrescription(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: KTextStyle(
          text: 'Rate Medicine Effectiveness',
          color: lightColorScheme.surface,
          size: 14.0,
        ),
        backgroundColor: lightColorScheme.primary,
      ),
      body: SafeArea(
        child: Container(
          color: lightColorScheme.primary,
          child: ListView(
            children: [
              Flexible(
                flex: 1,
                //TODO: put every state value at appropriate location in below long text
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                  child: Center(
                    child: KTextStyle(
                      text: "Rate ${medicineName} for ${illness}",
                      color: lightColorScheme.surface,
                      fontWeight: FontWeight.w700,
                      size: 16.0,
                    ),
                  ),
                ),
              ),
              Flexible(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(33.0),
                        topRight: Radius.circular(33.0)),
                    color: lightColorScheme.onPrimary),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    KTextStyle(
                      text: '$healthPercent%',
                      color: lightColorScheme.scrim,
                      size: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                    KTextStyle(
                      text: rate,
                      color: lightColorScheme.scrim,
                      size: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    Slider(
                        value: _currentSlideValue,
                        label: healthPercent,
                        max: 100,
                        activeColor: lightColorScheme.primary,
                        inactiveColor: lightColorScheme.secondary,
                        divisions: 3,
                        onChanged: onChanged),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        minLines: 3,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: commentController,
                        decoration: InputDecoration(
                          labelText: "Comment",
                          hintText: 'How did you feel about this medicine?',
                          labelStyle:
                              TextStyle(color: lightColorScheme.primary),
                          prefixIcon: Icon(Icons.comment),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: lightColorScheme.secondary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: lightColorScheme.primary),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Color.fromARGB(255, 66, 125, 145)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                width: 7, color: lightColorScheme.primary),
                          ),
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: onSaveComment(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Custom border radius
                        ),
                        backgroundColor: lightColorScheme.primary,
                      ),
                      child: KTextStyle(
                          text: '  Save  ',
                          color: lightColorScheme.onPrimary,
                          size: 14.0),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
