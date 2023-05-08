import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

class MapController extends GetxController {
  final myMarker = Set<Marker>().obs;
  final kGooglePlex = CameraPosition(
    target: LatLng(2, 3),
    zoom: 17.4746,
  ).obs;

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
  void goToList(){
    Get.toNamed(AppRoute.liste);
   }
  Future<void> changeMarker(double newLat, double newLong) async {
    myMarker.remove(Marker(markerId: MarkerId("1")));
    myMarker.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(newLat, newLong),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  final controller = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Obx(
              () => GoogleMap(
                markers: controller.myMarker.value,
                initialCameraPosition: controller.kGooglePlex.value,
              ),
            ),
            Positioned(
              bottom: 110.0,
              left: 335.0,
              child: IconButton(
                onPressed: () async {
                  await controller.getPosition();
                  await controller.changeMarker(
                      controller.kGooglePlex.value.target.latitude,
                      controller.kGooglePlex.value.target.longitude);
                      controller.goToList();
                },
                icon: Icon(
                  Icons.my_location_outlined,
                  size: 30,
                  color: Color.fromARGB(255, 249, 5, 5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
