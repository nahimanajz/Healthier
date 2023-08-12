import 'package:healthier2/models/comment.model.dart';
import 'package:healthier2/utils/firebase.instance.dart';

class CommentRepository {
  static Future<void> create(
      CommentModel comment, String patientId, String prescriptionId) async {
    db
        .collection(
            "/patients/$patientId/prescriptions/$prescriptionId/comments")
        .withConverter(
            fromFirestore: CommentModel.fromFireStore,
            toFirestore: (CommentModel comment, _) => comment.toFireStore())
        .add(comment);
  }
}
