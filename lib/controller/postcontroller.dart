import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../repository/user_repository/tech_repository.dart';
import '../repository/user_repository/user_repository.dart';
import '../services/tech_model.dart';
import '../services/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostController extends GetxController {
  late TextEditingController prix;
  late TextEditingController description;
  late TextEditingController titre;
  late ImagePickerController image;
  final CollectionReference _piecesCollection =
      FirebaseFirestore.instance.collection('pièce_de_rechange');

  @override
  void onInit() {
    prix = TextEditingController();
    description = TextEditingController();
    titre = TextEditingController();
    image = ImagePickerController();
    super.onInit();
  }

  Future<void> savePiece(bool isTechnician) async {
    try {
      String imageURL = '';
      String titreValue = titre.text;
      String descriptionValue = description.text;
      String prixValue = prix.text;

      if (image.pickedImage != null) {
        // Upload the image file to Firebase Storage and get the download URL
        String imageFileName =
            DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/$imageFileName.jpg');

        UploadTask uploadTask =
            storageReference.putFile(File(image.pickedImage!.path));
        TaskSnapshot snapshot = await uploadTask;

        if (snapshot.state == TaskState.success) {
          imageURL = await snapshot.ref.getDownloadURL();
        }
      }

      final UserRepository userRepository = Get.put(UserRepository());
      final TechRepository techRepository = Get.put(TechRepository());
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

      // Get the current user's email
      final User? currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        print('Current User not found!');
        return;
      }

      final String userEmail = currentUser.email!;

      if (isTechnician) {
        // Retrieve the technician details using the email
        final TechModel? tech =
            await techRepository.getUserDetailss(userEmail);
        print("Email: $userEmail");
        if (tech == null) {
          print('Technician not found!');
          return;
        }

        final String? techId = tech.id;

        // Save the values to Firestore for technician
        await _piecesCollection.add({
          'userId': techId,
          'titre': titreValue,
          'description': descriptionValue,
          'prix': prixValue,
          'imageURL': imageURL,
        }).then((_) {
          Get.snackbar(
            "Success!",
            "Your data has been saved.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          );
        }).catchError((error) {
          Get.snackbar(
            "Error!",
            "Failed to save data: $error",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red,
          );
        });
      } else {
        // Retrieve the user details using the email
        final UserModel? user = await userRepository.getUserDetail(userEmail);
        print("Email: $userEmail");
        if (user == null) {
          print('User not found!');
          return;
        }

        final String? userId = user.id;

        // Save the values to Firestore for client
        await _piecesCollection.add({
          'userId': userId,
          'titre': titreValue,
          'description': descriptionValue,
          'prix': prixValue,
          'imageURL': imageURL,
        }).then((_) {
          Get.snackbar(
            "Success!",
            "Your data has been saved.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          );
        }).catchError((error) {
          Get.snackbar(
            "Error!",
            "Failed to save data: $error",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red,
          );
        });
      }
    } catch (error, stackTrace) {
      print('Exception occurred: $error\n$stackTrace');
    }
  }

  @override
  void dispose() {
    prix.dispose();
    description.dispose();
    titre.dispose();
    super.dispose();
  }
}

class ImagePickerController {
  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;

  Future<void> pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedImage = await _imagePicker.getImage(source: source);

    if (pickedImage != null) {
      _pickedImage = File(pickedImage.path);
    }
  }

  File? get pickedImage => _pickedImage;
}
