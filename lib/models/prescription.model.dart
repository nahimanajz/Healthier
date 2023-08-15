import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthier2/models/medicine.model.dart';

import 'comment.model.dart';

class PrescriptionModel {
  String? documentId;
  String? illness;
  List<MedicineModel>? medicines;
  List<CommentModel>? comments;

  PrescriptionModel({
    this.documentId = "",
    this.illness,
    this.comments,
    this.medicines,
  });

  factory PrescriptionModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return PrescriptionModel(
      documentId: snapshot.id,
      illness: data?["illness"],
      comments:
          data?["comments"] is Iterable ? List.from(data?["comments"]) : null,
      medicines:
          data?["medicines"] is Iterable ? List.from(data?["medicines"]) : null,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {if (illness != null) "illness": illness};
  }
}
