import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthier2/models/consultation.model.dart';
import 'package:healthier2/models/prescription.model.dart';

class PatientModel {
  final String? addressCity;
  final String? name;
  final String? phone;
  final int? temp;
  final String? documentId;
  final String? email;
  final List<PrescriptionModel>? prescriptions;
  final List<ConsultationModel>? consultations;

  PatientModel(
      {this.email,
      this.addressCity,
      this.name,
      this.phone,
      this.temp,
      this.prescriptions,
      this.consultations,
      this.documentId});

  factory PatientModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return PatientModel(
      documentId: snapshot.id,
      name: data?["name"],
      email: data?["email"],
      phone: data?["phone"],
      temp: data?["temp"],
      addressCity: data?["addressCity"],
      prescriptions: data?["prescriptions"] is Iterable
          ? List.from(data?["prescriptions"])
          : null,
      consultations: data?["consultations"] is Iterable
          ? List.from(data?["consultations"])
          : null,
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
      if (temp != null) "temp": temp,
      if (addressCity != null) "addressCity": addressCity,
    };
  }
}
