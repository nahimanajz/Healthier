import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthier/utils/firebase.instance.dart';

import '../models/patient.model.dart';

class PatientRepository {
  static Future<PatientModel?> getPatientById(String id) async {
    final ref = db.collection("patients").doc(id).withConverter(
          fromFirestore: PatientModel.fromFireStore,
          toFirestore: (PatientModel patient, _) => patient.toFireStore(),
        );
    final docSnap = await ref.get();
    return docSnap.data();
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllPatients() async {
    return db.collection("patients").get().then(
          (querySnapshot) => querySnapshot
              .docs, //TODO: Object.data to get single patient records on UI
          onError: (e) => print("Error completing $e"),
        );
  }
}
