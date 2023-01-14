import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? name;
  String? email;
  List<String>? wishListIds;

  UserModel({this.userId, this.name, this.email, this.wishListIds});

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    userId = doc.id;
    name = doc['name'];
    email = doc['email'];
    wishListIds = doc['wishListIds'];
  }
}
