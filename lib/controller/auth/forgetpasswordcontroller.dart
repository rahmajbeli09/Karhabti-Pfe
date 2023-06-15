
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';


abstract class ForgetPasswordController extends GetxController{
 
  checkemail();
  
  goToVerifyCode();
  goToVerifyCodetech();
}

class ForgetPasswordControllerImp extends ForgetPasswordController{
  
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email ; 
 
  bool isshowpassword = true ;
   showPassword(){
    isshowpassword = isshowpassword == true ?false : true;
    update();
   }
  


  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
  
  @override
  goToVerifyCode() {
    Get.toNamed(AppRoute.verifycode);
  }
  
  @override
  checkemail() {}
  
  @override
  goToVerifyCodetech() {
    Get.toNamed(AppRoute.verifycodetech);
  }
}