
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class ForgetPasswordController extends GetxController{
  var isBlur = false.obs;

  checkemail();
  
  goToVerifyCode();
}

class ForgetPasswordControllerImp extends ForgetPasswordController{
  
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username ; 
  late TextEditingController phone ; 
  late TextEditingController email ; 
 
  bool isshowpassword = true ;
   showPassword(){
    isshowpassword = isshowpassword == true ?false : true;
    update();
   }
  


  @override
  void onInit() {
    email = TextEditingController();
    phone = TextEditingController();
    username = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    username.dispose();
    phone.dispose();
    super.dispose();
  }
  
  @override
  goToVerifyCode() {
    Get.offAllNamed(AppRoute.verifycode);
  }
  
  @override
  checkemail() {}
}