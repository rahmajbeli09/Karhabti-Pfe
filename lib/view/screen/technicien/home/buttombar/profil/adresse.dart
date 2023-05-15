import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/authcontroller.dart';
import 'package:karhabti_pfe/controller/client/locationcontroller.dart';
import 'package:karhabti_pfe/repository/user_repository/tech_repository.dart';
import 'package:karhabti_pfe/services/tech_model.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/panne/map.dart';
import 'package:karhabti_pfe/view/screen/technicien/home/buttombar/profil/maptech.dart';
import 'package:karhabti_pfe/view/widget/boutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Adresse extends StatelessWidget {
  const Adresse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationController controller = Get.put(LocationController());
    final authController = Get.put(AuthController());
    final techRepo = Get.put(TechRepository());

    Future<void> _updateTechnicianLocation() async {
      // Get the current location of the technician
      final Position? position = await controller.getLocation();
      final double? latitude = position?.latitude;
      final double? longitude = position?.longitude;
      if (latitude == null || longitude == null) {
        Get.snackbar('Erreur', 'Impossible de récupérer votre emplacement.');
        return;
      }

      // Get the user email
      final String? email = authController.firebaseUser.value?.email;
      if (email != null) {
        // Retrieve the technician document based on the email
        final TechModel technician = await techRepo.getUserDetails(email);
        final String? id = technician.id;
        if (id != null) {
          // Check if the document exists
          final DocumentSnapshot doc =
              await FirebaseFirestore.instance.collection('Techniciens').doc(id).get();
          if (!doc.exists) {
            print('Document with ID $id does not exist.');
            return;
          }

          // Update the technician document in Firestore
          await techRepo.updateTechnicienLocation(id, email, latitude, longitude);

          // Retrieve the technician's location data from Firestore
          final DocumentSnapshot doc2 =
              await FirebaseFirestore.instance.collection('Techniciens').doc(id).get();
          final Map<String, dynamic> data = doc2.data() as Map<String, dynamic>;
          final double? lat = data['latitude'];
          final double? long = data['longitude'];
          print('Updated technician location: $lat, $long');
        } else {
          print('Could not access user ID');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Enregistrer votre locale',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Image.asset(
              'assets/images/loc.png',
              height: 300,
            ),
            SizedBox(height: 50),
            Text(
              'Merci de déterminer votre adresse',
              style: TextStyle(
                fontSize: 19,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Cliquez sur le bouton "Localisez-vous" pour avoir des clients qui ont besoin de votre aide se trouvant à proximité de votre position.',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 80),
Boutton(
  text: "Localisez-Vous",
onPressed: () async {
  // Navigate to the MapTech screen
  Get.to(MapTech());

  // Get the current location of the technician
  Position? position = await controller.getLocation();
  double? latitude = position?.latitude;
  double? longitude = position?.longitude;
  if (latitude == null || longitude == null) {
    Get.snackbar('Erreur', 'Impossible de récupérer votre emplacement.');
    return;
  }

  // Get the user email
  final String? email = authController.firebaseUser.value?.email;
  if (email != null) {
    // Retrieve the technician document based on the email
    final TechModel technician = await techRepo.getUserDetails(email);
    final String? id = technician.id;
    if (id != null) {
      // Check if the document exists
      final DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('Techniciens').doc(id).get();
      if (!doc.exists) {
        print('Document with ID $id does not exist.');
        return;
      }

      // Update the technician document in Firestore
      await techRepo.updateTechnicienLocation(id, email, latitude, longitude);

      // Retrieve the technician's location data from Firestore
      final DocumentSnapshot doc2 =
          await FirebaseFirestore.instance.collection('Techniciens').doc(id).get();
      final Map<String, dynamic> data = doc2.data() as Map<String, dynamic>;
      final double? lat = data['latitude'];
      final double? long = data['longitude'];
      print('Updated technician location: $lat, $long');
    } else {
      print('Could not access user ID');
    }
  }
},

  color: Color.fromARGB(255, 255, 203, 30),
),

    ],    ),
      ),
    );
  }
}