
import 'package:healthier2/models/medicine.model.dart';
import 'package:healthier2/utils/firebase.instance.dart';

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
        .then((documentSnapshot) => documentSnapshot, onError: (e) => e);

    return document;
  }

  static Stream<List<MedicineModel>> getAll(
      {String phone = "08", String prescriptionId = "gY9MrVC1c1wWyvOrWBAn"}) {
    var docsSnapshot = db
        .collection("patients")
        .doc(phone)
        .collection("prescriptions")
        .doc(prescriptionId)
        .collection("medicines")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => MedicineModel.fromFireStore(document, null))
            .toList());
    return docsSnapshot;
  }
}
