import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/function/alertexitapp.dart';
import 'package:karhabti_pfe/core/function/validinput.dart';
import 'package:karhabti_pfe/view/widget/auth/customtextbodyauth.dart';
import 'package:karhabti_pfe/view/widget/auth/socialmedia.dart';
import 'package:karhabti_pfe/view/widget/auth/textsignuporsignin.dart';
import '../../../controller/auth/logintechcontroller.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
class LoginTech extends StatelessWidget {
  const LoginTech({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginTechControllerImp controller =Get.put(LoginTechControllerImp());
    return Scaffold(
                 body:WillPopScope(child:  Container(
                  width: 500,
        padding: EdgeInsets.symmetric(vertical: 60),
          decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/background.jpeg" ),
      fit: BoxFit.fitHeight,
    ),
  ),
                   child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                    margin: EdgeInsets.only(top: 40),
                    child: Form(
                      key: controller.formstate,
                      child: ListView(
                        children: [
                           CustomTextTiltleFormAuth(text :"14".tr),
                          const SizedBox(height: 20,),
                           CustomTextBodyAuth(text: "15".tr),
                          const SizedBox(height: 145,),
                           CustomTextFormAuth(
                             valid:(val){
                               return ValidInput(val!, 8,30, "email");
                             },
                           mycontroller: controller.email,
                           hinttext: "16".tr,
                           iconData: Icons.email_outlined,
                          ),
                           GetBuilder<LoginTechControllerImp>
                           (builder: (controller) => CustomTextFormAuth(
                            obscureText: controller.isshowpassword,
                            onTapIcon:(){
                              controller.showPassword();
                            } ,
                              valid:(val){
                               return ValidInput(val!, 8,30, "password");
                             },
                           mycontroller: controller.password,
                           hinttext: "17".tr,
                           iconData: Icons.lock_outlined ,
                          ),),
                           Text("18".tr , textAlign: TextAlign.end, style: TextStyle(fontSize: 12 ,  decoration: TextDecoration.underline),),
                      const SizedBox(height: 50,),
                      CustomTextSignUpOrSignIn(
                      texttwo: "14".tr,textone: "19".tr, 
                      onTap: (){
                        controller.goToSignUp();
                      },),
                       CustomButtomAuth(text: "13".tr, onPressed :() {
                        controller.login();
                       }),
                       SocialMedia()
                        ],
                      ),
                    ),
                   ),
                 ), onWillPop: alertExitApp)
                );
  }
} 