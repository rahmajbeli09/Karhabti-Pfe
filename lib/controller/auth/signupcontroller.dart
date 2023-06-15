import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class SignUpController extends GetxController {
  var isBlur = false.obs;

  void gotosuccesssignup();
  void goToHome();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController password2;
  bool isshowpassword = true;

  void showPassword() {
    isshowpassword = !isshowpassword;
    update();
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
  void gotosuccesssignup() {
    Get.offAllNamed(AppRoute.successSignUp);
  }

  @override
  void goToHome() {
    Get.offAllNamed(AppRoute.homescreen);
  }
}
