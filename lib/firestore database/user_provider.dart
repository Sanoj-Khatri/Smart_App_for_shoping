import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartapp_fyp/models/user_model.dart';

class UserProvider {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //creating an user
  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(user.userId)
          .set({"name": user.name, "email": user.email, "wishListIds": []});
      return true;
    } catch (e) {
      return false;
    }
  }
}
