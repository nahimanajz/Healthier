import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? rate;
  String? text;
  String? medicineName;

  CommentModel({this.rate, this.text, this.medicineName});

  factory CommentModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return CommentModel(
        rate: data?["rate"],
        text: data?["text"],
        medicineName: data?["medicineName"]);
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (rate != null) "rate": rate,
      if (text != null) "text": text,
      if (medicineName != null) "medicineName": medicineName,
    };
  }
}
