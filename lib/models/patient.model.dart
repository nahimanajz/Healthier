import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthier2/models/prescription.model.dart';

class PatientModel {
  final String? addressCity;
  final String? name;
  final String? phone;
  final int? temp;
  final List<PrescriptionModel>? prescriptions;

  PatientModel({
    this.addressCity,
    this.name,
    this.phone,
    this.temp,
    this.prescriptions,
  });

  factory PatientModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return PatientModel(
      name: data?["name"],
      phone: data?["phone"],
      temp: data?["temp"],
      addressCity: data?["addressCity"],
      prescriptions: data?["prescriptions"] is Iterable
          ? List.from(data?["prescriptions"])
          : null,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (name != null) "name": name,
      if (phone != null) "phone": phone,
      if (temp != null) "temp": temp,
      if (addressCity != null) "addressCity": addressCity,
      "prescriptions": prescriptions
    };
  }
}
