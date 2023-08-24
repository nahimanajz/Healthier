import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ConsultationModel {
  String? feelings;
  DateTime date = DateTime.now();
  bool? isPrescribed;
  String? documentId;

  ConsultationModel(
      {this.feelings, this.documentId, this.isPrescribed = false});

  factory ConsultationModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return ConsultationModel(
        documentId: snapshot.id,
        feelings: data?["feelings"],
        isPrescribed: data?["isPrescribed"]);
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (feelings != null) "feelings": feelings,
      "date": DateFormat('yyyy-MM-dd').format(date),
      "isPrescribed": isPrescribed,
    };
  }
}
