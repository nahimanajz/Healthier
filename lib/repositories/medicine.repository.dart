import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthier2/models/medicine.model.dart';
import 'package:healthier2/utils/firebase.instance.dart';
import 'dart:developer';

class MedicineRepository {
  static Future<dynamic> create(
      {required String phone,
      required String prescriptionId,
      required MedicineModel medicineData}) async {
    var document = await db
        .collection("patients")
        .doc(phone)
        .collection("prescriptions")
        .doc(prescriptionId)
        .collection("medicines")
        .withConverter(
            fromFirestore: MedicineModel.fromFireStore,
            toFirestore: (MedicineModel medicine, _) => medicine.toFireStore())
        .add(medicineData)
        .then(
            (documentSnapshot) =>
                debugPrint("Medicine Id===>${documentSnapshot.id}"),
            onError: (e) => debugPrint("saving medicine error${e}"));

    return document;
  }
}
