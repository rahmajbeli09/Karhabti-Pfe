import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:karhabti_pfe/controller/client/locationcontroller.dart';


class MapTech extends StatefulWidget {
  final double? x;
  final double? y;

  const MapTech({Key? key, this.x, this.y}) : super(key: key);

  @override
  _MapTechState createState() => _MapTechState();
}

class _MapTechState extends State<MapTech> {
  Position? cl;
  CameraPosition? _kGooglePlex;
  Set<Marker> mymarker = {};

 getpos() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // show a dialog or snackbar explaining that the permission is required
      // and ask the user to grant it from the app settings
      return;
    }
  }
    cl = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _kGooglePlex = CameraPosition(target: LatLng(cl!.latitude, cl!.longitude), zoom: 17.4746);
  }

  Future<void> changeMarker(double newLat, double newLong) async {
    setState(() {
      mymarker.remove(Marker(markerId: MarkerId("1")));
      mymarker.add(Marker(markerId: MarkerId("1"), position: LatLng(newLat, newLong)));
    });
  }

  @override
  void initState() {
    getpos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            GoogleMap(
              markers: mymarker,
              initialCameraPosition: _kGooglePlex == null ? CameraPosition(target: LatLng(2, 3)) : _kGooglePlex!,
            ),
            Positioned(
              bottom: 110.0,
              left: 335.0,
              child: IconButton(
                onPressed: () async {
                  await getpos();
                  changeMarker(cl!.latitude, cl!.longitude);
                },
                icon: Icon(Icons.my_location_outlined, size: 30, color: Color.fromARGB(255, 249, 5, 5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
