import 'package:cloud_firestore/cloud_firestore.dart';

import 'comment.model.dart';
import 'obedience.model.dart';

class PrescriptionModel {
  late final String description;
  late final bool isMedicineAvailable;
  late final String medicineName;
  late final String medicineType;
  late final String illness;

  late final List<CommentModel>? comments;
  late final List<ObedienceModel>? obedience;

  PrescriptionModel(
      {description,
      isMedicineAvailable,
      medicineName,
      medicineType,
      illness,
      comments,
      obedience});

  factory PrescriptionModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return PrescriptionModel(
      description: data?["description"],
      isMedicineAvailable: data?["isMedicineAvailable"],
      medicineName: data?["medicineName"],
      medicineType: data?["medicineType"],
      illness: data?["illness"],
      comments:
          data?["comments"] is Iterable ? List.from(data?["comments"]) : null,
      obedience:
          data?["obedience"] is Iterable ? List.from(data?["obedience"]) : null,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (description != null) "description": description,
      if (isMedicineAvailable != null)
        "isMedicineAvailable": isMedicineAvailable,
      if (medicineName != null) "medicineName": medicineName,
      if (medicineType != null) "medicineType": medicineType,
      if (illness != null) "illness": illness,
      if (comments != null) "comments": comments,
      if (obedience != null) "comments": obedience
    };
  }
}
