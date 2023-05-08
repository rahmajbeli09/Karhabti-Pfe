import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/authcontroller.dart';
import 'package:karhabti_pfe/repository/user_repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/user_model.dart';

class EditController extends GetxController {
  static EditController get instance => Get.find();
  final _authController = Get.put(AuthController());
  final userRepo = Get.put(UserRepository());
//Step3 : Get user email and pass to user repository to fetch user record
 getUserData() async {
    final email = _authController.firebaseUser.value?.email;
    if (email != null) {
      return await userRepo.getUserDetails(email);
    } else {
      Get.snackbar("error","Login to continue");
    
    
    }
  }


updateRecord(String id, UserModel user) async {
   print('Saving changes for user: $user');
  await userRepo.updateUserRecord(id, user);
}



}
