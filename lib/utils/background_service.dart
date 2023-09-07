import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:healthier2/models/medicine.model.dart';
import 'package:healthier2/models/obedience.model.dart';
import 'package:healthier2/services/notification.service.dart';
import 'package:healthier2/utils/main.util.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 1), (timer) async {
    // change to minute to test functionality
    try {
      await Firebase.initializeApp();
      String patientId =
          await preferences.getString("signedInUserId") as String;

      var prescriptions =
          await NotificationService.getNotifiablePrescriptions();
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "Hi",
          content: "you have  prescriptions ${prescriptions.length} ",
        );
        // finally notify user
      }

      for (var prescription in prescriptions) {
        var medicines = await NotificationService.getNotifiableMedicines(
            prescription.documentId as String);
        for (var medicine in medicines) {
          setObedience(
              medicine, patientId, prescription.documentId as String, service);
        }
      }
    } catch (e) {
      print("errro is this one $e");
    }
  });
}

setObedience(MedicineModel medicine, String patientId, String prescriptionId,
    ServiceInstance service) async {
  DateTime startDate;
  DateTime endDate;
  DateTime currentTime = DateTime.now();

  startDate = DateTime.parse(medicine.date as String);
  endDate = DateTime.parse(medicine.endDate as String);

  if (currentTime.isAfter(startDate) && currentTime.isBefore(endDate)) {
    String period = checkPeriod(medicine.timeOfTheDay);
    String status = "Missed " + checkPeriod(medicine.timeOfTheDay) + " Dose";

    bool isNotified = await NotificationService.isAlreadyNotified(
        patientEmail: patientId,
        prescriptionId: prescriptionId,
        period: period);

    if (isNotified == true) {
      ObedienceModel obedience = ObedienceModel(
          period: period,
          status: status,
          date: currentTime.toString(),
          medicineName: medicine.name);

      await NotificationService.createMissedDoses(
          obedience: obedience,
          patientEmail: patientId,
          prescriptionId: prescriptionId);

      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "Hi there",
          content:
              "Get healthy by taking your ${medicine.name} in ${period} medical dose",
        );
      }
    } else {
      debugPrint("it is already notified");
    }
  }
}
