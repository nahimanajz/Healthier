// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? password;
  String? userType;
  String? documentId;

  UserModel({
    this.email,
    this.password,
    this.userType,
    this.documentId,
  });

  factory UserModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return UserModel(
        email: data?["email"],
        userType: data?["userType"],
        documentId: snapshot.id);
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (userType != null) "userType": userType,
    };
  }
}
