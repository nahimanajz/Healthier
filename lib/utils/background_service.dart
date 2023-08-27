import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:healthier2/models/medicine.model.dart';
import 'package:healthier2/models/obedience.model.dart';

import 'package:healthier2/repositories/obedience.repository.dart';
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

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    String petientId = await preferences.getString("signedInUserId") as String;
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Hi",
        content: "you have  prescriptions ",
      );
      // finally notify user
    }
    var prescriptions = await NotificationService.getNotifiableMedicines();
    print("testing");

    for (var prescription in prescriptions) {
      if (prescription.medicines != null) {
        for (var medicine in prescription.medicines as List<MedicineModel>) {
          //medicine
          setObedience(
              medicine, petientId, prescription.documentId as String, service);
        }
      }
    }
  });
}

setObedience(MedicineModel medicine, String patientId, String prescriptionId,
    ServiceInstance service) {
  DateTime startDate;
  DateTime endDate;
  DateTime currentTime = DateTime.now();

  startDate = DateTime.parse(medicine.date as String);
  endDate = DateTime.parse(medicine.endDate as String);

  if (currentTime.isAfter(startDate) && currentTime.isBefore(endDate)) {
    String status = checkStatus(medicine.timeOfTheDay);
    String period = checkPeriod(medicine.timeOfTheDay);
    print("status==>${status}");
    ObedienceModel obedience = ObedienceModel(
        period: period,
        status: status,
        date: currentTime.toIso8601String(),
        medicineName: medicine.name);

    ObedienceRepository.createMissedDoses(obedience, patientId, prescriptionId);

    // finally notify user
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Hi there",
        content: "Get healthy by taking your medical dose",
      );
    }
  }
}
