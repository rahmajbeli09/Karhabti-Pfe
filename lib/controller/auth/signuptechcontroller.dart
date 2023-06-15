import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class SignUpTechController extends GetxController {
  void SignUp();
  void goToSignUp();
  void goToHomePageTech();
  void gotosuccesssignup();
}

class SignUpTechControllerImp extends SignUpTechController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController password2;
  bool isshowpassword = true;

  var selectedOption = "mécanicien".obs;

  void showPassword() {
    isshowpassword = !isshowpassword;
    update();
  }

  String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Please enter $fieldName";
    }

    if (fieldName == "email") {
      if (!GetUtils.isEmail(value)) {
        return "Please enter a valid email address";
      }
    }

    if (fieldName == "phone") {
      if (value == null || value.isEmpty) {
        return "Please enter a phone number";
      } else if (!RegExp(r'^[0-9]{8}$').hasMatch(value)) {
        return "Please enter a valid 8-digit phone number";
      }
    }

    if (fieldName == "password") {
      if (value.length < 8) {
        return "Password must be at least 8 characters";
      }
    }

    return null;
  }

  @override
  void SignUp() {
    Get.offAllNamed(AppRoute.homescreentech);
  }

  @override
  void goToSignUp() {
    Get.toNamed(AppRoute.signup);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    password2 = TextEditingController();
    phone = TextEditingController();
    username = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    password2.dispose();
    username.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  void goToHomePageTech() {
    Get.offAllNamed(AppRoute.homescreentech);
  }

  void updateSelectedOption(String newOption) {
    selectedOption.value = newOption;
  }

  @override
  void gotosuccesssignup() {
    Get.offAllNamed(AppRoute.successSignUptech);
  }
}
