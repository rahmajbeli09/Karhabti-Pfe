import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  late GoogleMapController _mapController;
  Rx<Position?> currentLocation = Rx<Position?>(null);

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  currentLocation.value = position;
  
  // Ajoutez cette vérification pour vous assurer que _mapController est initialisé
  if (_mapController != null) {
    animateCameraToCurrentLocation();
  }
}
  void animateCameraToCurrentLocation() {
    if (_mapController != null && currentLocation.value != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              currentLocation.value!.latitude,
              currentLocation.value!.longitude,
            ),
            zoom: 14.0,
          ),
        ),
      );
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    animateCameraToCurrentLocation();
  }
}