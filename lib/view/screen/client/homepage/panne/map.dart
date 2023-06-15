import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:karhabti_pfe/repository/user_repository/tech_repository.dart';

import '../../../../../services/tech_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MapController extends GetxController {
  final myMarker = Set<Marker>().obs;
  final kGooglePlex = CameraPosition(
    target: LatLng(2, 3),
    zoom: 17.4746,
  ).obs;
  final techRepo = Get.put(TechRepository());
  final BitmapDescriptor blueMarkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

  Future<void> getPosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    final cl = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Add your location as a marker
    myMarker.add(
      Marker(
        markerId: MarkerId("MyLocation"),
        position: LatLng(cl.latitude, cl.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    kGooglePlex.value = CameraPosition(
      target: LatLng(cl.latitude, cl.longitude),
      zoom: 15.4746,
    );
  }

  void fetchTechnicianLocations() async {
    List<TechModel> users = await techRepo.fetchTechnicianLocations();

    // Clear the existing markers except the user's location marker
    myMarker.removeWhere((marker) => marker.markerId.value != "MyLocation");

    // Add technician's locations as markers
    users.forEach((user) {
      myMarker.add(
        Marker(
          markerId: MarkerId(user.id ?? ''),
          position: LatLng(user.latitude, user.longitude),
          icon: blueMarkerIcon,
          onTap: () {
            showTechnicianInfo(user);
          },
        ),
      );
    });
  }

  void showTechnicianInfo(TechModel user) {
    print("Showing technician info: ${user.fullname}");
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informations concernant ce technicien'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nom: ${user.fullname}'),
              Text('Numéro de téléphone: ${user.phoneNumber}'),
              Text('Role: ${user.role ?? "N/A"}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _makePhoneCall(user.phoneNumber);
                    },
                    style: TextButton.styleFrom(primary: Colors.yellow),
                    child: Text('Appeler'),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(primary: Colors.yellow),
                    child: Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    if (await canLaunch('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      Fluttertoast.showToast(
        msg: "Impossible de passer l'appel",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
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
