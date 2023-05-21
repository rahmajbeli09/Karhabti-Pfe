import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:karhabti_pfe/repository/user_repository/tech_repository.dart';

import '../../../../../services/tech_model.dart';

class MapController extends GetxController {
  final myMarker = Set<Marker>().obs;
  final kGooglePlex = CameraPosition(
    target: LatLng(2, 3),
    zoom: 17.4746,
  ).obs;
  final techRepo = Get.put(TechRepository());
  final BitmapDescriptor blueMarkerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);



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


  // void goToList() {
  //   Get.toNamed(AppRoute.liste);
  // }

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


  void fetchTechnicianLocations() async {
    List<TechModel> users = await techRepo.fetchTechnicianLocations();
    myMarker.value = users.map((user) {
      return Marker(
        markerId: MarkerId(user.id ?? ''),
        position: LatLng(user.latitude, user.longitude),
        icon: blueMarkerIcon,
        onTap: () {
          showTechnicianInfo(user);
        },
      );
    }).toSet();
  }
  void showTechnicianInfo(TechModel user) { //hedhi bech talla3lek les informations mtaa technicien fi container 
      print("Showing technician info: ${user.fullname}");
     showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Technician Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: ${user.fullname}'),
              Text('Phone: ${user.phoneNumber}'),
              // Text('Email: ${user.email}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
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
                mapType: MapType.hybrid,
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
                  controller.fetchTechnicianLocations();
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
