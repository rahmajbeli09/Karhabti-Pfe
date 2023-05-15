import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/authcontroller.dart';
import 'package:karhabti_pfe/controller/client/locationcontroller.dart';
import 'package:karhabti_pfe/repository/user_repository/tech_repository.dart';
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

    Future<void> _updateTechnicianLocation() async {
      // Get the current location of the technician
      final Position? position = await controller.getLocation();
      final double? latitude = position?.latitude;
      final double? longitude = position?.longitude;
      if (latitude == null || longitude == null) {
        Get.snackbar('Erreur', 'Impossible de récupérer votre emplacement.');
        return;
      }

      // Get the ID of the authenticated user
      final AuthController authController = Get.find<AuthController>();
      final String? id = authController.firebaseUser.value?.uid;
      if (id == null) {
        print('could not access user id');
        return;
      }

      // Check if the technician document exists in Firestore
      final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Techniciens').doc(id).get();
      if (!doc.exists) {
        print('Document with ID $id does not exist.');
        return;
      }

      // Update the technician document in Firestore
      final TechRepository techRepo = Get.find<TechRepository>();
      await techRepo.updateTechnicienLocation(id, latitude, longitude);
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
    Get.to(MapTech());
    Position? position = await controller.getLocation();
    double? latitude = position?.latitude;
    double? longitude = position?.longitude;
    if (latitude == null || longitude == null) {
      Get.snackbar('Erreur', 'Impossible de récupérer votre emplacement.');
      return;
      
    }

    AuthController authController = Get.find<AuthController>();
    TechRepository techRepo = Get.find<TechRepository>();
    String? id = authController.firebaseUser.value?.uid;
    if (id != null) {
      // Check if the document exists
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Techniciens').doc("l32bx2FqUsSlo1921Wpp").get();
      if (!doc.exists) {
        print('Document with ID  ${"l32bx2FqUsSlo1921Wpp"}  does not exist.');
        
        return;
      }


      // Update the technician document in Firestore
      await techRepo.updateTechnicienLocation(id,latitude, longitude);

      // Retrieve the technician's location data from Firestore
      DocumentSnapshot doc2 = await FirebaseFirestore.instance.collection('Techniciens').doc(id).get();
      Map<String, dynamic> data = doc2.data() as Map<String, dynamic>;
      double? lat = data['latitude'];
      double? long = data['longitude'];
      print('Updated technician location: $lat, $long');
    } else {
      print('could not access user id');
    }
  },
  color: Color.fromARGB(255, 255, 203, 30),
   ),
    ],    ),
      ),
    );
  }
}