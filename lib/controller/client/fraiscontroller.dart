import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../repository/user_repository/user_repository.dart';
import '../../services/user_model.dart';

class FraisControllerImp extends GetxController {
  final UserRepository userRepository = Get.put(UserRepository());
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

void saveFraisData(DateTime assuranceValue, DateTime vignetteValue, DateTime visiteValue) async {
    // Convert dates to Firestore Timestamps
    final Timestamp assuranceTimestamp = Timestamp.fromDate(assuranceValue);
    final Timestamp vignetteTimestamp = Timestamp.fromDate(vignetteValue);
    final Timestamp visiteTimestamp = Timestamp.fromDate(visiteValue);

    // Get the current user's email
    final User? currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      print('User not found!');
      return;
    }
    final String userEmail = currentUser.email!;

    // Retrieve the user details using the email
    final UserModel? user = await userRepository.getUserDetail(userEmail);
    if (user == null) {
      print('User not found!');
      return;
    }

    final String? userId = user.id;

    // Create a new document in the 'frais' collection
    final CollectionReference fraisCollection = FirebaseFirestore.instance.collection('frais');
    final DocumentReference documentRef = fraisCollection.doc();

    // Set the fields for the new document
    await documentRef.set({
      'userId': userId,
      'vignette': vignetteTimestamp,
      'assurance': assuranceTimestamp,
      'visite': visiteTimestamp,
    });

    // Call the method to save the token
    await saveToken(documentRef);
  }

  Future<void> saveToken(DocumentReference documentRef) async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token == null) {
      print('Failed to retrieve token.');
      return;
    }

    Map<String, dynamic> data = {
      "token": token,
      "timestamp": DateTime.now().toUtc().toString(),
    };

    // Update the existing document with the token field
    await documentRef.update(data).then((value) {
      print("Token saved successfully");
    }).catchError((error) {
      print("Failed to save token: $error");
    });
  }


// Future<DocumentSnapshot<Map<String, dynamic>>?> fetchFraisData() async {
//   final User? currentUser = _firebaseAuth.currentUser;
//   if (currentUser == null) {
//     print('User not found!');
//     return null;
//   }
//   final String userEmail = currentUser.email!;

//   // Retrieve the user details using the email
//   final UserModel? user = await userRepository.getUserDetail(userEmail);
//   if (user == null) {
//     print('User not found!');
//     return null;
//   }

//   final String? userId = user.id;

//   // Fetch the frais document for the user
//   final QuerySnapshot<Map<String, dynamic>> fraisQuerySnapshot = await FirebaseFirestore.instance
//       .collection('frais')
//       .where('userId', isEqualTo: userId)
//       .limit(1)
//       .get();

//   if (fraisQuerySnapshot.docs.isNotEmpty) {
//     // Return the first document from the query snapshot
//     return fraisQuerySnapshot.docs.first;
//   } else {
//     print('Frais document not found!');
//     return null;
//   }
// }


  
}
