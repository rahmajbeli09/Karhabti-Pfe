import 'package:get/get.dart';
 import 'package:geolocator/geolocator.dart';


abstract class Location_Controller extends GetxController {
  getLocation() ;
}
class Location_ControllerImp extends Location_Controller {

getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print('Latitude: ${position.latitude}');
  print('Longitude: ${position.longitude}');
}

}
