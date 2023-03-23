import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/logincontroller.dart';
import 'package:karhabti_pfe/core/function/validinput.dart';
import 'package:karhabti_pfe/view/widget/auth/customtextbodyauth.dart';
import 'package:karhabti_pfe/view/widget/auth/textsignuporsignin.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
import '../../widget/mode.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller =Get.put(LoginControllerImp());
    return Scaffold(
      appBar  : AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
          actions: [
          Mode(),
            ],
          ),
           
                 body: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  child: Form(
                    key: controller.formstate,
                    child: ListView(
                      children: [
         
          CustomTextTiltleFormAuth(text :"14".tr),
         const SizedBox(height: 20,),
          CustomTextBodyAuth(text: "15".tr),
         const SizedBox(height: 50,),
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
              return ValidInput(val!, 8,30, "password");
            },
          mycontroller: controller.password,
          hinttext: "17".tr,
          iconData: Icons.lock_outlined,
         ),
          Text("18".tr , textAlign: TextAlign.end, style: TextStyle(fontSize: 12),),
             
                    const SizedBox(height: 220,),
                    CustomTextSignUpOrSignIn(
                    texttwo: "14".tr,textone: "19".tr, 
                    onTap: (){
                      controller.goToSignUp();
                    },),
                     CustomButtomAuth(text: "13".tr, onPressed :() {
                      controller.login();
                     }),
                      ],
                    ),
                  ),
                 ),
                );
  }
} 