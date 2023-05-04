import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/services/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

   createUser(UserModel user) async {
   await  _db.collection("Users").add(user.toJson()).whenComplete(() => Get.snackbar(
          "success !",
          "your account has been created",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        )).catchError((error, StackTrace) {
      Get.snackbar(
        "error",
        "Something went wrong. Try again",
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(error.toString());
    });
  }
    //step 2 : fetch user
Future<UserModel> getUserDetails(String email) async {
  final snapshot = await _db.collection("Users").where("email", isEqualTo: email).get();
  final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  return userData;
}

  Future<void> updateUserRecord(UserModel user) async{
await _db.collection("Users").doc(user.id).update(user.toJson());
  }


}