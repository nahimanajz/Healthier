import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthier2/utils/firebase.instance.dart';
import '../models/prescription.model.dart';

final class PrescriptionRepository {
  static Future<dynamic> create(
      {required String phone,
      required PrescriptionModel prescriptionData}) async {
    var document = await db
        .collection("patients")
        .doc(phone)
        .collection("prescriptions")
        .withConverter(
            fromFirestore: PrescriptionModel.fromFireStore,
            toFirestore: (PrescriptionModel patient, _) =>
                patient.toFireStore())
        .add(prescriptionData)
        .then((documentSnapshot) => documentSnapshot);

    return document;
  }

  static Future<PrescriptionModel?> getPrescriptionById(
      String patientId, prescriptionId) async {
    final ref = db
        .collection("patients")
        .doc(patientId)
        .collection("prescriptions")
        .doc(prescriptionId)
        .withConverter(
          fromFirestore: PrescriptionModel.fromFireStore,
          toFirestore: (PrescriptionModel prescription, _) =>
              prescription.toFireStore(),
        );
    final docSnap = await ref.get();
    return docSnap.data();
  }

  static Stream<List<PrescriptionModel>> getAll({String patientId = "08"}) {
    var docsSnapshots = db
        .collection("patients")
        .doc(patientId)
        .collection("prescriptions")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => PrescriptionModel.fromFireStore(document, null))
            .toList());

    return docsSnapshots;
  }

  static Future<void> approveMedicine(
      String patientId, String prescriptionId) async {
    final prescriptionRef = db
        .collection("patients")
        .doc(patientId)
        .collection("prescriptions")
        .doc(prescriptionId);

    prescriptionRef.update({"isMedecineAvailable": true}).then(
        (documentSnapshot) => print(
            "medicine is approved"), //TODO: THIS MESSAGE WILL BE SHOWN IN A DIALOG
        onError: (e) => print("Error approving medicine availability $e"));
  }
}