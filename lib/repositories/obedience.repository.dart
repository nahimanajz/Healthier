import 'package:healthier2/models/obedience.model.dart';
import 'package:healthier2/utils/firebase.instance.dart';

class ObedienceRepository {
  static Future<void> create(
      ObedienceModel obedience, String patientId, String prescriptionId) async {
    db
        .collection(
            "/patients/$patientId/prescriptions/$prescriptionId/obedience")
        .withConverter(
            fromFirestore: ObedienceModel.fromFireStore,
            toFirestore: (ObedienceModel obedience, _) =>
                obedience.toFireStore())
        .add(obedience);
  }
}
