import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repository/user_repository/user_repository.dart';
import '../../services/user_model.dart';

class ReclamationController extends GetxController {
  final TextEditingController titre = TextEditingController();
  final TextEditingController description = TextEditingController();
  final CollectionReference _reclamationCollection =
      FirebaseFirestore.instance.collection('reclamations');
  final UserRepository userRepository = Get.find<UserRepository>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> sendReclamation() async {
    try {
      final String titreValue = titre.text;
      final String descriptionValue = description.text;

      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        print('User not found!');
        return;
      }
      final userEmail = currentUser.email!;

      final UserModel? user = await userRepository.getUserDetail(userEmail);
      if (user == null) {
        print('User not found!');
        return;
      }

      final userId = user.id;

      await _reclamationCollection
          .add({
            'email': userEmail,
            'userId': userId,
            'titre': titreValue,
            'description': descriptionValue,
          })
          .then((_) => showSnackbar(
                'Success!',
                'Votre reclamation à été bien enregistré , un administrateur la traitera le plutot possible, Merci',
                Colors.green,
              ))
          .catchError((error) => showSnackbar(
                'Error!',
                'Failed to save data: $error',
                Colors.red,
              ));
    } catch (error, stackTrace) {
      print('Exception occurred: $error\n$stackTrace');
    }
  }

  void showSnackbar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color.withOpacity(0.1),
      colorText: color,
    );
  }

  @override
  void dispose() {
    titre.dispose();
    description.dispose();
    super.dispose();
  }
}
