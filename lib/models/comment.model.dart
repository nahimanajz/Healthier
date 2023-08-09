import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  late final String rate;
  late final String text;

  CommentModel({rate, text});

  factory CommentModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return CommentModel(
      rate: data?["rate"],
      text: data?["text"],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (rate != null) "rate": rate,
      if (text != null) "text": text,
    };
  }
}
