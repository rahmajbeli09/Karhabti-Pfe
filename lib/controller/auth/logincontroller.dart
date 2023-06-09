
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class LoginController extends GetxController{
  login();
  goToSignUp();
}

class LoginControllerImp extends LoginController{
  
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  
  late TextEditingController email ; 
  late TextEditingController password ; 

  login(){
    var formdata = formstate.currentState;
    if (formdata!.validate()){
        print("valid");
    }else{
      print("not Valid");
    }
    Get.toNamed(AppRoute.home);

  }
  
  @override
  goToSignUp() {
    Get.toNamed(AppRoute.signup);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
  
  
}