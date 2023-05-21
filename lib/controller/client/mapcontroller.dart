import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karhabti_pfe/repository/user_repository/tech_repository.dart';
import 'package:karhabti_pfe/services/tech_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/constant/routes.dart';
import '../../repository/user_repository/user_repository.dart';

class MapController extends GetxController {
    Position? ab;
  // CameraPosition? kGooglePlex;
  Set<Marker> mymarker = {};
  final myMarker = Set<Marker>().obs;
  
  final kGooglePlex = CameraPosition(
    target: LatLng(2, 3),
    zoom: 17.4746,
  ).obs;
  final techRepo = Get.put(TechRepository());
   final userRepo = Get.put(UserRepository());
  final BitmapDescriptor blueMarkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);


Future<void> getPosition() async {
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();

  final cl = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  kGooglePlex.value = CameraPosition(
    target: LatLng(cl.latitude, cl.longitude),
    zoom: 17.4746,
  );
}


Future<void> changeMarker(double newLat, double newLong) async {
  myMarker.remove(Marker(markerId: MarkerId("1")));
  myMarker.add(
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(newLat, newLong),
    ),
  );
  kGooglePlex.value = CameraPosition(
    target: LatLng(newLat, newLong),
    zoom: kGooglePlex.value.zoom,
  );
}



 Future<void> fetchTechnicianLocations() async {
  List<TechModel> users = await techRepo.fetchTechnicianLocations();
  final List<Marker> markers = [];

  // Add technician markers
  final blueMarkerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  markers.addAll(users.map((user) {
    return Marker(
      markerId: MarkerId(user.id ?? ''),
      position: LatLng(user.latitude, user.longitude),
      icon: blueMarkerIcon,
      onTap: () {
        showTechnicianInfo(user);
      },
    );
  }));

  // Add your location marker
  final redMarkerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  markers.add(
    Marker(
      markerId: MarkerId('user_location'),
      position: LatLng(
        kGooglePlex.value.target.latitude,
        kGooglePlex.value.target.longitude,
      ),
      icon: redMarkerIcon,
    ),
  );

  // Add your location marker using the current location instead of kGooglePlex
  final cl = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  markers.add(
    Marker(
      markerId: MarkerId('user_location'),
      position: LatLng(cl.latitude, cl.longitude),
      icon: redMarkerIcon,
    ),
  );

  myMarker.value = markers.toSet();
  updateMarkers();
}



   void showTechnicianInfo(TechModel user) {
  Fluttertoast.showToast(
    msg: "Techniciens: ${user.fullname}\nPhone: ${user.phoneNumber}\nEmail: ${user.email}",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey[600],
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

  void updateMarkers() {
    update(); // Notify the observers that the marker set has been updated
  }

  void goToTechnicianList() {
    Get.toNamed(AppRoute.liste);
  }




    @override
  void onInit() {
   
    fetchTechnicianLocations(); // Fetch technicians' locations when the controller is initialized
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
