import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthier2/models/prescription.model.dart';

class PatientModel {
  late final String addressCity;
  late final String name;
  late final String phone;
  late final int temp;
  late final List<PrescriptionModel>? prescriptions;

  PatientModel({addressCity, name, phone, temp, prescription, prescriptions});

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
