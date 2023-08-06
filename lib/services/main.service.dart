import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

class MainService {
  /*
  Future<void> loadData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> dataQuery =
          await db.collection("patients").get();
      var patients = dataQuery.docs.map((patient) => patient).toList();
      if (kDebugMode) {
        print(patients);
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error ${e.message}");
      }
    }
  } */
}
