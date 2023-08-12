import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthier2/utils/firebase.instance.dart';

import '../models/patient.model.dart';

class PatientRepository {
  static Future<PatientModel?> getPatientById(String id) async {
    final ref = db.collection("patients").doc(id).withConverter(
          fromFirestore: PatientModel.fromFireStore,
          toFirestore: (PatientModel patient, _) => patient.toFireStore(),
        );
    final docSnap = await ref.get();
    return docSnap.data();
  }

  static Future<List<Map<String, dynamic>>> getAllPatients() async {
    List<Map<String, dynamic>> patients = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("patients").get();

    for (var element in querySnapshot.docs) {
      patients.add(element.data() as Map<String, dynamic>);
    }
    log(patients.first.toString());
    return patients;
  }

  static Future<void> create(PatientModel patient) async {
    return db
        .collection("patients")
        .withConverter(
            fromFirestore: PatientModel.fromFireStore,
            toFirestore: (PatientModel patient, _) => patient.toFireStore())
        .add(patient)
        .then((documentSnapshot) =>
            log("patient is saved Id${documentSnapshot.id}"));
  }
}
