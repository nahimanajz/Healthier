import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ObedienceModel {
  String? status;
  String? medicineName;
  String? date; //YYYY-MM-DD
  String? period; // Morning, noon, evening, night

  ObedienceModel({this.period, this.date, this.status, this.medicineName});

  factory ObedienceModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return ObedienceModel(
      status: data?["status"],
      medicineName: data?["medicineName"],
      date: data?["date"],
      period: data?["period"],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (status != null) "status": status,
      if (medicineName != null) "medicineName": medicineName,
      if (date != null)
        "date": DateFormat('yyyy-MM-dd').format(DateTime.parse(date as String)),
      if (period != null) "period": period,
    };
  }
}
