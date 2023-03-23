import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService{

  late SharedPreferences sharedPreferences ; //déclare une variable 
  Future<MyServices> init()async{
   sharedPreferences = await SharedPreferences.getInstance();//initialise la variable 
   return this ; 
  }
}

initialServices() async{
 await Get.putAsync(() => MyServices().init());
}

