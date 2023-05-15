import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/services/user_model.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/panne/map.dart';
import 'package:karhabti_pfe/view/widget/boutton.dart';
import '../../../../../controller/auth/authcontroller.dart';
import '../../../../../controller/client/locationcontroller.dart';
import '../../../../../repository/user_repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: must_be_immutable
class Localisezvous extends StatelessWidget {
//    Localisezvous({Key? key}) : super(key: key);
//     LocationController controller = Get.put(LocationController());
//     double ?x;
//     double ?y;
//     Future <void> getLocation() async {
//      controller.getPermission();
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//       print('Latitude: ${position.latitude}');
//   print('Longitude: ${position.longitude}');

// }


  @override
  Widget build(BuildContext context) {
     final LocationController controller = Get.put(LocationController());
    final authController = Get.put(AuthController());
    final userRepo = Get.put(UserRepository());

    Future<void> _updateUserLocation() async {
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
        final UserModel user = await userRepo.getUserDetails(email);
        final String? id = user.id;
        if (id != null) {
          // Check if the document exists
          final DocumentSnapshot doc =
              await FirebaseFirestore.instance.collection('Users').doc(id).get();
          if (!doc.exists) {
            print('Document with ID $id does not exist.');
            return;
          }

          // Update the user document in Firestore
          await userRepo.updateUserLocation(id, email, latitude, longitude);

          // Retrieve the technician's location data from Firestore
          final DocumentSnapshot doc3 =
              await FirebaseFirestore.instance.collection('Users').doc(id).get();
          final Map<String, dynamic> data = doc3.data() as Map<String, dynamic>;
          final double? lat = data['latitude'];
          final double? long = data['longitude'];
          print('Updated User location: $lat, $long');
        } else {
          print('Could not access user ID');
        }
      }
    }

    return Scaffold(
         appBar : AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back , color: Colors.black),
    onPressed: () {
      Get.back(); 
    },
  ),
  centerTitle: true,
  title: Text('Trouver un expert' , style: TextStyle(color: Colors.black , fontFamily: "Comfortaa" , fontWeight: FontWeight.bold , fontSize: 18),),
  elevation: 0,
  backgroundColor: Colors.white.withAlpha(0),
),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
        child: Column(
          children: [
            Image.asset("assets/images/loc.png" , height: 300,),
              SizedBox(height: 50,),
              Text(" Merci de determiner votre position" , style: TextStyle(fontSize: 19 , fontFamily: "comfortaa" , fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Text( "Cliquez sur le bouton 'Localisez-vous' pour accéder à une liste de techniciens qualifiés se trouvant à proximité de votre position." , style: TextStyle(fontSize: 13 , fontFamily: "comfortaa" , fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              SizedBox(height: 80,),
              Boutton(
                text: "Localisez-Vous" ,
                 onPressed: ()async{

                controller.getLocation();
               await Get.to(MapPage());
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
    final UserModel user = await userRepo.getUserDetails(email);
    final String? id = user.id;
    if (id != null) {
      // Check if the document exists
      final DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('Users').doc(id).get();
      if (!doc.exists) {
        print('Document with ID $id does not exist.');
        return;
      }

      // Update the user document in Firestore
      await userRepo.updateUserLocation(id, email, latitude, longitude);

      // Retrieve the USER's location data from Firestore
      final DocumentSnapshot doc3 =
          await FirebaseFirestore.instance.collection('Users').doc(id).get();
      final Map<String, dynamic> data = doc3.data() as Map<String, dynamic>;
      final double? lat = data['latitude'];
      final double? long = data['longitude'];
      print('Updated User location: $lat, $long');
    } else {
      print('Could not access user ID');
    }
  }
              },
              color: Color.fromARGB(255, 255, 203, 30),)
          ],
        ),
      ),
    );
  }
}