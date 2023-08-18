import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:healthier2/services/obedience.service.dart';
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
  print('FLUTTER BACKGROUND FETCH');

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

  final patientId = preferences.getString("patientId");
  if (patientId != null) {
    // bring to foreground
    Timer.periodic(const Duration(seconds: 10000000000000), (timer) async {
      print("patient signed data$patientId");
      doHandleObedienceCheck(patientId as String);
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "Hi there",
          content: "Kindly take your medical dose",
        );
      }
    });
  }
}

// all firestore data
doHandleObedienceCheck(String patientId) async {
  var medicines = await ObedienceService.getPatientMedicines(patientId);
  ObedienceService.scheduleDoseReminder(medicines);
}
