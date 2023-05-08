import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class FraisController extends GetxController {

}
class FraisControllerImp extends FraisController{
    late TextEditingController assurance ;
    late TextEditingController vignette ;
    late TextEditingController visite ; 
     @override
  void onInit() {
    assurance = TextEditingController();
    vignette = TextEditingController();
    visite = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    assurance.dispose();
    vignette.dispose();
    visite.dispose();
    super.dispose();
  }

}