import 'package:flutter/material.dart';
import 'package:healthier2/models/medicine.model.dart';
import 'package:healthier2/repositories/medicine.repository.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/utils/data/medicines.dart';
import 'package:healthier2/utils/main.util.dart';
import 'package:healthier2/widgets/styles/gradient.decoration.dart';

import '../widgets/styles/KTextStyle.dart';

class DosageScreen extends StatefulWidget {
  const DosageScreen({super.key});

  @override
  State<DosageScreen> createState() => _DosageState();
}

class _DosageState extends State<DosageScreen> {
  int dosage = 0;
  int duration = 0;
  bool isMorningActive = false;
  bool isNoonActive = false;
  bool isEveningActive = false;
  bool isNightActive = false;

  //
  int foodCorrelation = 0;
  int repeat = 0;
  setDailyRepeat() {
    setState(() {
      repeat = 1;
    });
  }

  setWeeklylyRepeat() {
    setState(() {
      repeat = 2;
    });
  }

  setMonthlyRepeat() {
    setState(() {
      repeat = 3;
    });
  }

  void setBeforeFood() {
    setState(() {
      foodCorrelation = 1;
    });
  }

  void setAfterFood() {
    setState(() {
      foodCorrelation = 2;
    });
  }

  void setAnytimeFood() {
    setState(() {
      foodCorrelation = 3;
    });
  }

  void toggleMorning() {
    setState(() {
      isMorningActive = !isMorningActive;
    });
  }

  void toggleNoon() {
    setState(() {
      isNoonActive = !isNoonActive;
    });
  }

  void toggleEvening() {
    setState(() {
      isEveningActive = !isEveningActive;
    });
  }

  void toggleNight() {
    setState(() {
      isNightActive = !isNightActive;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onDosageIncrement() {
    setState(() {
      dosage += 1;
    });
  }

  void onDosageDecrement() {
    setState(() {
      if (dosage > 1) {
        dosage -= 1;
      } else {
        dosage = 1;
      }
    });
  }

  void onDurationIncrement() {
    setState(() {
      duration += 1;
    });
  }

  void onDurationDecrement() {
    setState(() {
      if (duration > 1) {
        duration -= 1;
      } else {
        duration = 1;
      }
    });
  }

  onAddMedicine(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    debugPrint(arguments.toString()); //ok

    var dailyTimes = formatTimeOfDay(
        isMorningActive, isNoonActive, isEveningActive, isNightActive);
    var repeatType = formatDuration(repeat);
    //
    var medicine = MedicineModel(
        medicineType: arguments?["medicineType"],
        name: arguments?["medicineName"],
        dosage: dosage.toString(),
        timeOfTheDay: dailyTimes,
        tobeTakenAt: formatTobeTaken(foodCorrelation),
        repeat: repeatType,
        endDate: calculateEndDate(DateTime.now(), duration, repeatType));

    debugPrint((medicine.toFireStore()).toString()); //ok

    // MedicineR
    MedicineRepository.create(
        phone: arguments?["phone"],
        prescriptionId: arguments?["prescriptionId"],
        medicineData: medicine);
  }

  @override
  Widget build(BuildContext context) {
    var dayTimes = [
      buildElevatedButton(toggleMorning, isMorningActive, "Morning"),
      buildElevatedButton(toggleNoon, isNoonActive, "Noon"),
      buildElevatedButton(toggleEvening, isEveningActive, "Evening"),
      buildElevatedButton(toggleNight, isNightActive, "Night"),
    ];
    var foodCorrelations = [
      buildElevatedButton(setBeforeFood, foodCorrelation == 1, "Before Food"),
      buildElevatedButton(setAfterFood, foodCorrelation == 2, "After Food"),
      buildElevatedButton(setAnytimeFood, foodCorrelation == 3, "Anytime")
    ];
    var repeats = [
      buildElevatedButton(setDailyRepeat, repeat == 1, "Daily"),
      buildElevatedButton(setWeeklylyRepeat, repeat == 2, "Weekly"),
      buildElevatedButton(setMonthlyRepeat, repeat == 3, "Monthly"),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //TODO: this back works after implementing navigations
            Navigator.pop(context, 2);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: KTextStyle(
          text: 'Prescription for',
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
                  child: KTextStyle(
                    text:
                        '''1 Tablet everyday for 1 week in morning, noon after food ''',
                    color: lightColorScheme.surface,
                    fontWeight: FontWeight.w700,
                    size: 20.0,
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  decoration: gradientDecoration,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceAround, // TODO: wrap in padding
                        children: [
                          buildColumn("Dosage", '${dosage} Tablet',
                              onDosageDecrement, onDosageIncrement),
                          buildColumn(
                              "Duration",
                              '${duration} ${formatDuration(repeat)}',
                              onDurationDecrement,
                              onDurationIncrement)
                        ],
                      ),
                      buildWrap("Time of the day", dayTimes),
                      buildWrap("To be taken", foodCorrelations),
                      buildWrap("Repeat ", repeats),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              // TODO: Add new medicine to prescriptions array
                              onPressed: () {
                                onAddMedicine(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: StadiumBorder(
                                  side: BorderSide(
                                      color: lightColorScheme.primary),
                                ),
                              ),
                              child: KTextStyle(
                                text: "Add Medicine",
                                color: lightColorScheme.primary,
                                size: 14.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Wrap buildWrap(String title, var children) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 10.0,
      spacing: 4.0,
      direction: Axis.horizontal,
      children: [
        KTextStyle(text: title, color: Color(0xFF333333), size: 14.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: children,
        )
      ],
    );
  }

  ElevatedButton buildElevatedButton(
      void Function() onPressed, bool isActive, String title) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor:
              isActive ? lightColorScheme.primary : lightColorScheme.secondary),
      child: KTextStyle(
          text: title,
          color: isActive ? lightColorScheme.onPrimary : lightColorScheme.scrim,
          size: 14.0),
    );
  }

  Column buildColumn(String label, String medValueAndType,
      void Function() onDecrement, void Function() onIncrement) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        KTextStyle(
          text: label,
          color: Color(0xFF333333),
          fontWeight: FontWeight.w400,
          size: 14.0,
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red.shade400),
              onPressed: onDecrement,
              highlightColor: Colors.green.shade700,
            ),
            KTextStyle(
              text: medValueAndType,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w300,
              size: 16.0,
            ),
            IconButton(
              highlightColor: Colors.green.shade700,
              icon: Icon(Icons.add_circle, color: Colors.green.shade400),
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }
}
