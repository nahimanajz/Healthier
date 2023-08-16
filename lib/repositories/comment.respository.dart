import 'package:healthier2/models/comment.model.dart';
import 'package:healthier2/utils/firebase.instance.dart';

class CommentRepository {
  static Future<void> create(
      CommentModel comment, String patientId, String prescriptionId) async {
    await db
        .collection(
            "/patients/$patientId/prescriptions/$prescriptionId/comments")
        .withConverter(
            fromFirestore: CommentModel.fromFireStore,
            toFirestore: (CommentModel comment, _) => comment.toFireStore())
        .add(comment);
  }

  static Stream<List<CommentModel>> getPatientComments(
      {String patientId = "08",
      String prescriptionId = "0Zr5iCdlpjWJeAqnoF1V"}) {
    final records = db
        .collection("/patients")
        .doc(patientId)
        .collection("prescriptions")
        .doc(prescriptionId)
        .collection("comments")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => CommentModel.fromFireStore(document, null))
            .toList());

    return records;
  }
}
