import 'package:healthier2/models/drugstore.model.dart';
import 'package:healthier2/utils/firebase.instance.dart';

class DrugStoreRepository {
  static Future<void> create(DrugStoreModel drugStore) async {
    await db
        .collection("drugstores")
        .withConverter(
            fromFirestore: DrugStoreModel.fromFireStore,
            toFirestore: (DrugStoreModel drugstore, _) =>
                drugstore.toFireStore())
        .add(drugStore);
  }

  static Stream<List<DrugStoreModel>> getAll() {
    var docsSnapshots = db.collection("drugstores").snapshots().map(
        (snapshot) => snapshot.docs
            .map((drugstore) => DrugStoreModel.fromFireStore(drugstore, null))
            .toList());
    return docsSnapshots;
  }

  static Stream<List<DrugStoreModel>> getByPharmacyId({String? pharmacyId}) {
    var docsSnapshots = db
        .collection("drugstores")
        .where("userId", isEqualTo: pharmacyId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((drugstore) => DrugStoreModel.fromFireStore(drugstore, null))
            .toList());

    return docsSnapshots;
  }

  static Future<void> update(DrugStoreModel drug) async {
    await db
        .collection("drugstores")
        .doc(drug.documentId)
        .update(drug.toFireStore());
  }

  static Future<void> delete(String drugId) async {
    await db.collection("drugstores").doc(drugId).delete();
  }
}
