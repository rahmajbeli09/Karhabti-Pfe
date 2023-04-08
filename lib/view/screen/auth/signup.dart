import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/signupcontroller.dart';
import '../../../core/function/validinput.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';

class SignUp extends StatelessWidget {
   SignUp({Key? key}) : super(key: key);
 SignUpControllerImp controller = Get.put(SignUpControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
                 body: Container(
                        width: 500,
        padding: EdgeInsets.symmetric( horizontal: 25 , vertical: 10),
          decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/back2.jpeg" ),
      fit: BoxFit.fitHeight,
    ),
  ),
                  child: Form(
                  key: controller.formstate,
                  
                    child: ListView(
                      children: [
          CustomTextTiltleFormAuth(text :"20".tr),
         const SizedBox(height: 20,),
          CustomTextBodyAuth(text: "21".tr),
         const SizedBox(height: 60,),
        
          CustomTextFormAuth(
             valid:(val){
                return ValidInput(val!, 8,30, "username");
            },
          mycontroller: controller.username,
          hinttext: "22".tr,
          iconData: Icons.person_outline,
         ),
          CustomTextFormAuth(
             valid:(val){
              return ValidInput(val!, 8,30, "email");
            },
          mycontroller: controller.email,
          hinttext: "16".tr,
          iconData: Icons.email_outlined,
         ),
          CustomTextFormAuth(
             valid:(val){
               return ValidInput(val!, 8,30, "phone");
            },
          mycontroller: controller.phone,
          hinttext: "23".tr,
          iconData: Icons.phone_outlined,
         ),
          CustomTextFormAuth(
             valid:(val){
             return ValidInput(val!, 8,30, "password");
            },
            mycontroller: controller.password,
          hinttext: "17".tr,
          iconData: Icons.lock_outlined, 
         ),
         CustomTextFormAuth(
             valid:(val){
             return ValidInput(val!, 8,30, "password");
            },
            mycontroller: controller.password,
          hinttext: "17".tr,
          iconData: Icons.lock_outlined, 
         ),
         
         const SizedBox(height: 60,),
              CustomButtomAuth(text: "14".tr, onPressed :() {
                controller.SignUp();
                controller.goToHomePage();
              }),
                    
                      ],
                    ),
                  ),
                 ),
                );
  }
}