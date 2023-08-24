import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthier2/models/user.model.dart';
import 'package:healthier2/utils/firebase.instance.dart';

class UserRepository {
  static Future<void> create(UserModel user) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email as String,
        password: user.password as String,
      );

      await db
          .collection("users")
          .doc(userCredential.user?.email)
          .withConverter(
              fromFirestore: UserModel.fromFireStore,
              toFirestore: (UserModel user, _) => user.toFireStore())
          .set(user);
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  static Future<UserModel?> signIn(
      {required String email, required String password}) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .withConverter(
              fromFirestore: UserModel.fromFireStore,
              toFirestore: (UserModel user, _) => user.toFireStore())
          .get();

      final snapshot2 = await FirebaseFirestore.instance
          .collection('users')
          .where('password', isEqualTo: password)
          .withConverter(
              fromFirestore: UserModel.fromFireStore,
              toFirestore: (UserModel user, _) => user.toFireStore())
          .get();

      final pass1 = snapshot.docs.first.data().password;
      final pass2 = snapshot2.docs.first.data().password;

      if (pass1 != pass2) {
        throw Exception("Credentils mismatch");
      }
      return snapshot.docs.first.data();
    } catch (e) {
      throw Exception("Invalid credentials");
    }
  }

  // User who is admin should see other users who are patient
  static Stream<List<UserModel>> getAllUsers(String userId) {
    final records = db
        .collection("users")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => UserModel.fromFireStore(document, null))
            .toList());

    return records;
  }

  static Future<void> update(String email, UserModel user) async {
    await db.collection("users").doc(email).update(user.toFireStore());
  }

  static Future<void> deleteUser({String? email}) async {
    await db.collection("users").doc(email).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }
}
