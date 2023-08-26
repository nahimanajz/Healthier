import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'obedience.model.dart';

class MedicineModel {
  String? documentId;
  String? quantity;
  String? medicineType;
  String? name;
  bool? isAvailable;
  int? lostCounts;
  String? dosage;
  int? duration;
  String? timeOfTheDay;
  String? tobeTakenAt;
  String? repeat;
  DateTime date = DateTime.now();
  DateTime? endDate;
  List<ObedienceModel>? obediences;

  MedicineModel(
      {this.documentId = "",
      this.quantity,
      this.medicineType,
      this.name,
      this.isAvailable = false,
      this.lostCounts = 0,
      this.dosage,
      this.duration,
      this.timeOfTheDay,
      this.tobeTakenAt,
      this.repeat,
      this.obediences,
      this.endDate});

  factory MedicineModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return MedicineModel(
      documentId: snapshot.id,
      medicineType: data?["medicineType"],
      name: data?["name"],
      quantity: data?["quantity"],
      dosage: data?["dosage"],
      duration: data?["duration"],
      timeOfTheDay: data?["timeOfTheDay"],
      tobeTakenAt: data?["tobeTakenAt"],
      repeat: data?["repeat"],
      isAvailable: data?["isAvailable"],
      lostCounts: data?["lostCounts"],
      //endDate: data?["endDate"],
      obediences: data?["obediences"] is Iterable
          ? List.from(data?["obediences"])
          : null,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "name": name,
      "quantity": quantity,
      "medicineType": medicineType,
      "dosage": dosage,
      "timeOfTheDay": timeOfTheDay,
      "tobeTakenAt": tobeTakenAt,
      "repeat": repeat,
      "duration": duration,
      "date": DateFormat('yyyy-MM-dd').format(date),
      "lostCounts": lostCounts,
      "endDate": endDate,
      "isAvailable": isAvailable
    };
  }
}
