import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/services/tech_model.dart';

class TechRepository extends GetxController {
  static TechRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

   createUser(TechModel user) async {
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
  
}
