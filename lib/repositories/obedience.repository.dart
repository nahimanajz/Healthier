import 'package:healthier2/models/obedience.model.dart';
import 'package:healthier2/utils/firebase.instance.dart';
import 'package:intl/intl.dart';

class ObedienceRepository {
  static Future<void> create(
      ObedienceModel obedience, String patientId, String prescriptionId) async {
    db
        .collection(
            "/patients/$patientId/prescriptions/$prescriptionId/obediences")
        .withConverter(
            fromFirestore: ObedienceModel.fromFireStore,
            toFirestore: (ObedienceModel obedience, _) =>
                obedience.toFireStore())
        .add(obedience);
  }

  static Future<void> createMissedDoses(
      ObedienceModel obedience, String patientId, String prescriptionId) async {
    db
        .collection(
            "/patients/$patientId/prescriptions/$prescriptionId/obediences")
        .withConverter(
            fromFirestore: ObedienceModel.fromFireStore,
            toFirestore: (ObedienceModel obedience, _) =>
                obedience.toFireStore())
        .add(obedience);
  }

  static Stream<List<ObedienceModel>> getObedience(
      {String patientId = "08",
      String prescriptionId = "31G30nR7Qwy4r9aavhZn"}) {
    final records = db
        .collection("/patients")
        .doc(patientId)
        .collection("prescriptions")
        .doc(prescriptionId)
        .collection("obediences")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((obedience) => ObedienceModel.fromFireStore(obedience, null))
            .toList());

    return records;
  }

  static Future<bool> isAlreadyNotified(
      {required String patientId,
      required String prescriptionId,
      required String period}) async {
    final records = await db
        .collection("/patients")
        .doc(patientId)
        .collection("prescriptions")
        .doc(prescriptionId)
        .collection("obediences")
        .where("date",
            isEqualTo: DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .where("period", isEqualTo: period)
        .get();
    return records.docs.isEmpty;
  }
}
