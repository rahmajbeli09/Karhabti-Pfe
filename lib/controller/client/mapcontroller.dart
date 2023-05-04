import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  Position? ab;
  CameraPosition? kGooglePlex;
  Set<Marker> mymarker = {};

  Future<void> getpos() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    ab = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    kGooglePlex = CameraPosition(
      target: LatLng(ab!.latitude, ab!.longitude),
      zoom: 17.4746,
    );
  }

  Future<void> chang() async {
    mymarker.remove(Marker(markerId: MarkerId("1")));
    await mymarker.add(Marker(
      markerId: MarkerId("1"),
      position: LatLng(ab!.latitude, ab!.longitude),
    ));
  }

  @override
  void onInit() {
    getpos();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
