import 'package:get/get.dart';
 import 'package:geolocator/geolocator.dart';


abstract class Location_Controller extends GetxController {
 double? x;
 double?y;
getLocation() ;
getpermission();
}
class Location_ControllerImp extends Location_Controller {

getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
      x=position.latitude;

  print('Latitude: ${position.latitude}');
  print('Longitude: ${position.longitude}');
}

  @override
  getpermission()async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
  }

}
