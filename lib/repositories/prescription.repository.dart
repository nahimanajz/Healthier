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

  static Future<List<PrescriptionModel>> getAllForNotification(
      {String? patientId}) async {
    var docsSnapshots = await db
        .collection("patients")
        .doc(patientId)
        .collection("prescriptions")
        .get();

    List<PrescriptionModel> prescriptions = docsSnapshots.docs
        .map((doc) => PrescriptionModel.fromFireStore(doc, null))
        .toList();
    return prescriptions;
  }

  static Future<String> approveMedicine(
      {String? patientId, String? prescriptionId, String? medicineId}) async {
    var message;
    final prescriptionRef = db
        .collection("patients")
        .doc(patientId)
        .collection("prescriptions")
        .doc(prescriptionId)
        .collection("medicines")
        .doc(medicineId);
    prescriptionRef
        .update({"isAvailable": true})
        .then((value) => {message = "Successful approved medicine"})
        .catchError((err) => message = err);

    return message;
  }
}
