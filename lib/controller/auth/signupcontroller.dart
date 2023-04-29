import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class SignUpController extends GetxController{
  SignUp();
  goToSignUp();
  goToHomePage();
}

class SignUpControllerImp extends SignUpController{
  
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username ; 
  late TextEditingController phone ; 
  late TextEditingController email ; 
  late TextEditingController password ; 
   

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
    Get.toNamed(AppRoute.home);
  }
}