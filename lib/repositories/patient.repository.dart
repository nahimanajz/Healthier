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

  static Future<PatientModel?> getPhoneNumber(String phoneNumber) async {
    final ref = db
        .collection("patients")
        .where("phone", isEqualTo: phoneNumber)
        .withConverter(
            fromFirestore: PatientModel.fromFireStore,
            toFirestore: (PatientModel patient, _) => patient.toFireStore());

    final querySnapshot = await ref.get();
    final patient = querySnapshot.docs.first;
    return patient.data();
  }

  static Future<bool> isPatientExist(String email) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("patients")
        .where("email", isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
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
        .doc(patient.phone)
        .set(patient)
        .then((documentSnapshot) => documentSnapshot,
            onError: (e) => throw Exception("something went wrong $e"));
  }

  static Future<QuerySnapshot<Object?>> getPatientPrescriptions(
      {String patientId = "08"}) async {
    return await db
        .collection('patients')
        .doc(patientId)
        .collection('prescriptions')
        .get();
  }

  static Future<PatientModel> getPatientByEmail({String? email}) async {
    final snapshot = FirebaseFirestore.instance
        .collection("patients")
        .where("email", isEqualTo: email)
        .withConverter(
            fromFirestore: PatientModel.fromFireStore,
            toFirestore: (PatientModel patient, _) => patient.toFireStore());
    final patient = await snapshot.get();
    return patient.docs.first.data();
  }
}
