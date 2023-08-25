import 'package:cloud_firestore/cloud_firestore.dart';

class DrugStoreModel {
  String? medicineName;
  int? quantity;
  String? userId;
  String? documentId;

  DrugStoreModel({
    this.medicineName,
    this.quantity,
    this.userId,
    this.documentId,
  });

  factory DrugStoreModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return DrugStoreModel(
        documentId: snapshot.id,
        userId: data?["userId"],
        quantity: data?["quantity"],
        medicineName: data?["medicineName"]);
  }
  Map<String, dynamic> toFireStore() {
    return {
      if (medicineName != null) "medicineName": medicineName,
      if (userId != null) "userId": userId,
      if (quantity != null) "quantity": quantity,
    };
  }
}
