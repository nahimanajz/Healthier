import 'package:healthier2/models/consultation.model.dart';
import 'package:healthier2/utils/firebase.instance.dart';

class ConsultationRepository {
  static Future<void> create(ConsultationModel consultation,
      {String? patientId}) async {
    await db
        .collection("/patients/$patientId/consultations")
        .withConverter(
            fromFirestore: ConsultationModel.fromFireStore,
            toFirestore: (ConsultationModel consultation, _) =>
                consultation.toFireStore())
        .add(consultation);
  }

  static Stream<List<ConsultationModel>> getAll({String patientId = "08"}) {
    var docsSnapshots = db
        .collection("patients")
        .doc(patientId)
        .collection("consultations")
        .orderBy('isPrescribed', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((consultation) =>
                ConsultationModel.fromFireStore(consultation, null))
            .toList());

    return docsSnapshots;
  }

  static Future<String> markAsPrescribed(
      {String? patientId, String? consultationId}) async {
    var message;
    final prescriptionRef = db
        .collection("patients")
        .doc(patientId)
        .collection("consultations")
        .doc(consultationId);

    prescriptionRef
        .update({"isPrescribed": true})
        .then((value) => {message = "Successful approved medicine"})
        .catchError((err) => message = err);
    return message;
  }
}
