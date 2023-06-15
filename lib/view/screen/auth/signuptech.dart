import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/authcontroller.dart';
import 'package:karhabti_pfe/controller/auth/signuptechcontroller.dart';
import 'package:karhabti_pfe/core/function/alertexitapp.dart';
import 'package:karhabti_pfe/core/function/validinput.dart'; // Import the validinput.dart file
import 'package:karhabti_pfe/services/tech_model.dart';
import 'package:karhabti_pfe/view/widget/auth/socialmedia.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';

// ignore: must_be_immutable
class SignUpTech extends StatelessWidget {
  SignUpTech({Key? key}) : super(key: key);

  SignUpTechControllerImp controller = Get.put(SignUpTechControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: GestureDetector(
          
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
                  const SizedBox(height: 20),
                  CustomTextBodyAuth(text: "21".tr),
                  const SizedBox(height: 20),
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
                  GetBuilder<SignUpTechControllerImp>(
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
                  GetBuilder<SignUpTechControllerImp>(
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
                  Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 187, 183, 183).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Obx(
                      () => DropdownButton<String>(
                        value: controller.selectedOption.value,
                        items: [
                          'mécanicien',
                          'electricien',
                          'tolier',
                          'lavage',
                          'technicien en pneumatique',
                          'technicien en vitrage',
                          'technicien en climatisation',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.updateSelectedOption(newValue!);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomButtomAuth(
                    text: "14".tr,
                    onPressed: () {
                      if (controller.formstate.currentState?.validate() ?? false) { // Validate the form fields
                        AuthController.instance.register(
                          controller.email.text.trim(),
                          controller.password.text.trim(),
                        );
                        final user = TechModel(
                          fullname: controller.username.text.trim(),
                          email: controller.email.text.trim(),
                          phoneNumber: controller.phone.text.trim(),
                          password: controller.password.text.trim(),
                          role: controller.selectedOption.value,
                        );
                        AuthController.instance.createTech(user);
                        controller.SignUp();
                        controller.goToHomePageTech();
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
        onWillPop: alertExitApp,
      ),
    );
  }
}
