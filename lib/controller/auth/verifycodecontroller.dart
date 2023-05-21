import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class VerifyCodeController extends GetxController{

  checkecode();
  
  goToResetPassword();
  goToResetPasswordTech();
}

class VerifyCodeControllerImp extends VerifyCodeController{

  @override
  void onInit() {
    super.onInit();
  }

  
  @override
  goToResetPassword() {
    Get.toNamed(AppRoute.resetPassword);
  }
  
  @override
  checkecode() {}
  
  @override
  goToResetPasswordTech() {
    Get.toNamed(AppRoute.resetPasswordtech);
  }
}