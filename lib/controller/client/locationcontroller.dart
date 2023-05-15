import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../repository/user_repository/tech_repository.dart';
import '../../services/tech_model.dart';
import '../auth/authcontroller.dart';

class LocationController extends GetxController {
    final _authController = Get.put(AuthController());
  final techRepo = Get.put(TechRepository());
  Future<Position?> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request user to enable it
      Get.snackbar('Erreur', 'Veuillez activer votre localisation.');
      return null;
    }

    // Request permission to access the device's location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission to access the device's location is denied, request user to enable it
        Get.snackbar('Erreur', 'Veuillez autoriser l\'accès à votre localisation.');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permission to access the device's location is permanently denied, request user to enable it from app settings
      Get.snackbar('Erreur', 'Veuillez autoriser l\'accès à votre localisation depuis les paramètres de l\'application.');
      return null;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<void> getPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isRestricted) {
      await Permission.location.request();
    }
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
  }
  
Future<void> saveLocation(TechModel user ,double latitude, double longitude) async {
   final techRef = FirebaseFirestore.instance.collection('techniciens').doc(user.id);
    final location = GeoPoint(latitude, longitude);
   await techRef.update({'location': location});
}
  
}
