import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/authcontroller.dart';
import 'package:karhabti_pfe/controller/auth/signupcontroller.dart';
import 'package:karhabti_pfe/core/function/alertexitapp.dart';
import 'package:karhabti_pfe/services/user_model.dart';
import 'package:karhabti_pfe/view/screen/auth/signup.dart';
import 'package:karhabti_pfe/view/widget/auth/socialmedia.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
import 'package:karhabti_pfe/repository/user_repository/user_repository.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  SignUpControllerImp controller = Get.put(SignUpControllerImp());
  AuthController controller2 = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          AuthController.instance.register(
            controller.email.text.trim(),
            controller.password.text.trim(),
          );
        },
        child: Container(
          width: 500,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back2.jpeg"),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Form(
            key: controller.formstate,
            child: ListView(
              children: [
                Image.asset(
                  "assets/images/signup.png",
                  height: 170,
                  width: 50,
                  alignment: Alignment.topLeft,
                ),
                CustomTextTiltleFormAuth(text: "20".tr),
                const SizedBox(height: 10),
                CustomTextBodyAuth(text: "21".tr),
                SizedBox(height: 15),
                CustomTextFormAuth(
                  mycontroller: controller.username,
                  hinttext: "22".tr,
                  iconData: Icons.person_outline,
                  validator: (val) => controller.validateField(val, "username"),
                ),
                CustomTextFormAuth(
                  mycontroller: controller.email,
                  hinttext: "16".tr,
                  iconData: Icons.email_outlined,
                  validator: (val) => controller.validateField(val, "email"),
                ),
                CustomTextFormAuth(
                  mycontroller: controller.phone,
                  hinttext: "23".tr,
                  iconData: Icons.phone_outlined,
                  validator: (val) => controller.validateField(val, "phone"),
                ),
                GetBuilder<SignUpControllerImp>(
                  builder: (controller) => CustomTextFormAuth(
                    obscureText: controller.isshowpassword,
                    onTapIcon: () {
                      controller.showPassword();
                    },
                    mycontroller: controller.password,
                    hinttext: "17".tr,
                    iconData: Icons.lock_outlined,
                    validator: (val) => controller.validateField(val, "password"),
                  ),
                ),
                GetBuilder<SignUpControllerImp>(
                  builder: (controller) => CustomTextFormAuth(
                    obscureText: controller.isshowpassword,
                    onTapIcon: () {
                      controller.showPassword();
                    },
                    mycontroller: controller.password2,
                    hinttext: "17".tr,
                    iconData: Icons.lock_outlined,
                    validator: (val) => controller.validateField(val, "password"),
                  ),
                ),
                const SizedBox(height: 10),
                CustomButtomAuth(
                  text: "14".tr,
                  onPressed: () {
                    if (controller.formstate.currentState?.validate() ?? false) {
                      AuthController.instance.register(
                        controller.email.text.trim(),
                        controller.password.text.trim(),
                      );
                      final user = UserModel(
                        fullname: controller.username.text.trim(),
                        email: controller.email.text.trim(),
                        password: controller.password.text.trim(),
                        phoneNumber: controller.phone.text.trim(),
                      );
                      AuthController.instance.createUser(user);
                      //controller.SignUp();
                      controller.gotosuccesssignup();
                      controller.isBlur.value = true;
                    } else {
                      Get.snackbar(
                        "un problème es survenu:",
                        "Merci de vérifier vos données",
                        backgroundColor: Colors.redAccent,
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                      );
                    }
                  },
                ),
                // SocialMedia(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
