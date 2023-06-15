import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/services/user_model.dart';

import '../../controller/auth/authcontroller.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
final authController = Get.find<AuthController>;
  Future<void> createUser(UserModel user) async {
  final hashedPassword = UserModel.hashPassword(user.password);

  await _db.collection("Users").add({
    ...user.toJson(),
    "password": hashedPassword,
  }).then((_) {
    Get.snackbar(
      "Success!",
      "Your account has been created",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );
  }).catchError((error) {
    Get.snackbar(
      "Error",
      "Something went wrong. Try again",
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.red,
    );
    print(error.toString());
  });
}

//step 2: fetch user
Future<UserModel>getUserDetails(String email) async {
  final snapshot = await _db.collection("Users").where("email", isEqualTo: email).get();
  final user = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return user ;
  
  }
  
  // Fetches the profile picture URL for the user with the given email
  Future<String?> getUserProfilePictureURL(String email) async {
    final snapshot =
        await _db.collection("Users").where("email", isEqualTo: email).get();

    if (snapshot.docs.isNotEmpty) {
      final user = UserModel.fromSnapshot(snapshot.docs.first);
      return user.imageURL;
    } else {
      return null;
    }
  }


Future<void> updateUserRecord(String id, UserModel user) async {
  try {
    // Verify that the id property of the UserModel instance matches the ID parameter
    if (id != user.id) {
      throw Exception("User ID doesn't match Firestore document ID");
    }

    await _db.collection("Users").doc(id).update(user.toJson());
    print('User data updated: $user');
    Get.snackbar(
      "Success",
      "User data updated successfully",
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );
  } catch (e) {
    print('Failed to update user data: $e');
    Get.snackbar(
      "Error",
      "Failed to update user data: $e",
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.red,
    );
  }
}

  getUserByEmail(String? email) {}
 Future<void> updateUserLocation(String id, String email, double latitude, double longitude) async {
if (email != null) {
  try {
    Map<String, dynamic> locationData = {
      'latitude': latitude,
      'longitude': longitude,
    };
    await _db.collection('Users').doc(id).update(locationData);
    print('User location updated: ($latitude, $longitude)');
  } catch (e) {
    print('Failed to update User location: $e');
  }
}

   
  }
//this method was created to retrive the user details to link the frais collection with the users
  Future<UserModel?> getUserDetail(String email) async {
    final snapshot =
        await _db.collection("Users").where("email", isEqualTo: email).get();

    if (snapshot.docs.isNotEmpty) {
      final user = UserModel.fromSnapshot(snapshot.docs.first);
      print("user details passed ");
      return user;
    } else {
      print("mochkla");
      return null;
    }
  }


}