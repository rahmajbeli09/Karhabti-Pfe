import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/services/tech_model.dart';

import '../../controller/auth/authcontroller.dart';

class TechRepository extends GetxController {
  static TechRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
      final authController = Get.find<AuthController>;

   Future<void> createTech(TechModel user) async {
  final userJson = user.toJson();
    final hashedPassword = TechModel.hashPassword(user.password);

  await _db.collection("Techniciens").add({
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
Future<TechModel>getUserDetails(String email) async {
  final snapshot = await _db.collection("Techniciens").where("email", isEqualTo: email).get();
  final user = snapshot.docs.map((e) => TechModel.fromSnapshot(e)).single;
    return user ;
  
  }
  Future<void> updateUserRecord(String id, TechModel user) async {
  try {
    // Verify that the id property of the UserModel instance matches the ID parameter
    if (id != user.id) {
      throw Exception("User ID doesn't match Firestore document ID");
    }

    await _db.collection("Techniciens").doc(id).update(user.toJson());
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
  Future<TechModel?> getUserDetailss(String email) async {
    final snapshot =
        await _db.collection("Techniciens").where("email", isEqualTo: email).get();

    if (snapshot.docs.isNotEmpty) {
      final tech = TechModel.fromSnapshot(snapshot.docs.first);
      print("tech details passed ");
      return tech;
    } else {
      print("mochkla tech");
      return null;
    }
  }
  getTechByEmail(String? email) {}

Future<void> updateTechnicienLocation(String id, String email, double latitude, double longitude) async {
if (email != null) {
  try {
    Map<String, dynamic> locationData = {
      'latitude': latitude,
      'longitude': longitude,
    };
    await _db.collection('Techniciens').doc(id).update(locationData);
    print('Technician location updated: ($latitude, $longitude)');
  } catch (e) {
    print('Failed to update technician location: $e');
  }
}

   
  }
    // Fetches the profile picture URL for the user with the given email
  Future<String?> getUserProfilePictureURL(String email) async {
    final snapshot =
        await _db.collection("Techniciens").where("email", isEqualTo: email).get();

    if (snapshot.docs.isNotEmpty) {
      final user = TechModel.fromSnapshot(snapshot.docs.first);
      return user.imageURL;
    } else {
      return null;
    }
  }
Future<List<TechModel>> fetchTechnicianLocations() async {
  final snapshot = await _db.collection("Techniciens").get();

  // Parse the user documents into a list of TechModel models
  List<TechModel> users = snapshot.docs.map((doc) {
    return TechModel.fromSnapshot(doc);
  }).toList();

  // Filter technicians with non-null latitude and longitude
  List<TechModel> techniciansWithLocation = users.where((user) {
    return user.latitude != null && user.longitude != null;
  }).toList();

  return techniciansWithLocation;
}
//this method was created to retrive the user details to link the frais collection with the users
  Future<TechModel?> getUserDetaiil(String email) async {
    final snapshot =
        await _db.collection("Techniciens").where("email", isEqualTo: email).get();

    if (snapshot.docs.isNotEmpty) {
      final user = TechModel.fromSnapshot(snapshot.docs.first);
      print("user details passed ");
      return user;
    } else {
      print("mochkla f techrep");
      return null;
    }
  }

  
}
