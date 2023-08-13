import 'package:cloud_firestore/cloud_firestore.dart';

class ObedienceModel {
  String? status;
  ObedienceModel({this.status});

  factory ObedienceModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return ObedienceModel(
      status: data?["status"],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (status != null) "status": status,
    };
  }
}
