
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class SignUpTechController extends GetxController{
  SignUp();
  goToSignUp();
  goToHomePage();
}

class SignUpTechControllerImp extends SignUpTechController{
  
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username ; 
  late TextEditingController phone ; 
  late TextEditingController email ; 
  late TextEditingController password ; 
   var selectedOption = "mécanicien".obs;

  
   

  SignUp(){
    var formdata = formstate.currentState;
    if (formdata!.validate()){
        print("valid");
    }else{
      print("not Valid");
    }
  }
  
  @override
  goToSignUp() {
    Get.toNamed(AppRoute.signup);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    username = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    phone.dispose();
    super.dispose();
  }
  
  @override
  goToHomePage() {
    Get.toNamed(AppRoute.hometech);
  }
  void updateSelectedOption(String newOption) {
    
    selectedOption.value = newOption;
  }
}