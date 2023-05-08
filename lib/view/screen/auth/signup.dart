import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/authcontroller.dart';
import 'package:karhabti_pfe/controller/auth/signupcontroller.dart';
import 'package:karhabti_pfe/core/function/alertexitapp.dart';
import 'package:karhabti_pfe/services/user_model.dart';
import 'package:karhabti_pfe/view/widget/auth/socialmedia.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
import 'package:karhabti_pfe/repository/user_repository/user_repository.dart';


class SignUp extends StatelessWidget { //It means that it does not have any mutable state, and its state is only dependent on the parameters passed to it. This class represents a reusable UI widget 
   SignUp({Key? key}) : super(key: key); //The constructor takes a Key parameter and passes it to the superclass constructor. The key parameter is optional and allows for the widget's identity to be preserved across widget rebuilds.
 SignUpControllerImp controller = Get.put(SignUpControllerImp()); //This method is part of the GetX package and registers a new instance of the SignUpControllerImp class to be globally accessible within the widget tree.
 AuthController controller2 =Get.put(AuthController());
 //final key = GlobalKey<FormState>(); //The key variable is defined to hold a global key that is used to identify this widget in the widget tree.
  @override
  Widget build(BuildContext context) { //The build method is overridden to create the UI of the sign-up screen. It returns a Scaffold widget with an AppBar and a Container containing the sign-up form
   var email = TextEditingController();
   var password = TextEditingController();
    return Scaffold(
    
                 body: GestureDetector(
                  onTap: (){
                    AuthController.instance.register(controller.email.text.trim(), controller.password.text.trim());
                  } ,
                  child: Container(
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
                        Image.asset("assets/images/signup.png" , height: 170, width: 50, alignment: Alignment.topLeft,),
          CustomTextTiltleFormAuth(text :"20".tr),
         const SizedBox(height: 10,),
          CustomTextBodyAuth(text: "21".tr),
        SizedBox(height: 15,),
          CustomTextFormAuth(
             //valid:(val){
             //   return ValidInput(val!, 8,30, "username");
           // },
          mycontroller: controller.username,
          hinttext: "22".tr,
          iconData: Icons.person_outline,
         ),
          CustomTextFormAuth(
           //  valid:(val){
            //  return ValidInput(val!, 8,30, "email");
           // },
          mycontroller: controller.email,
          hinttext: "16".tr,
          iconData: Icons.email_outlined,
         ),
          CustomTextFormAuth(
            // valid:(val){
               //return ValidInput(val!, 8,30, "phone");
            //},
          mycontroller: controller.phone,
          hinttext: "23".tr,
          iconData: Icons.phone_outlined,
         ),
          GetBuilder<SignUpControllerImp>
                           (builder: (controller) => CustomTextFormAuth(
                            obscureText: controller.isshowpassword,
                            onTapIcon:(){
                              controller.showPassword();
                            } ,
                              //valid:(val){
                               //return ValidInput(val!, 8,30, "password");
                            // },
                           mycontroller: controller.password,
                           hinttext: "17".tr,
                           iconData: Icons.lock_outlined ,
                          ),),
         GetBuilder<SignUpControllerImp>
                           (builder: (controller) => CustomTextFormAuth(
                            obscureText: controller.isshowpassword,
                            onTapIcon:(){
                              controller.showPassword();
                            } ,
                             // valid:(val){
                              // return ValidInput(val!, 8,30, "password");
                           //  },
                           mycontroller: controller.password2,
                           hinttext: "17".tr,
                           iconData: Icons.lock_outlined ,
                          ),),
         const SizedBox(height: 10,),
                       CustomButtomAuth(text: "14".tr, onPressed :() {
                AuthController.instance.register(controller.email.text.trim(), controller.password.text.trim()); //fi 
                final user = UserModel(
                  fullname: controller.username.text.trim(),
                  email: controller.email.text.trim(),
                  password: controller.password.text.trim(),
                  phoneNumber: controller.phone.text.trim(),
                  
                );
                AuthController.instance.createUser(user);
                controller.SignUp();
                controller.goToHomePage();
                 controller.isBlur.value = true;
              }),
              SocialMedia(),
                    
                      ],
                    ),
                  ),
                 ),
                 ),
                );
  }
}