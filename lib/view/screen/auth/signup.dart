import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/authcontroller.dart';
import 'package:karhabti_pfe/controller/auth/signupcontroller.dart';
import '../../../core/function/validinput.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';

class SignUp extends StatelessWidget { //It means that it does not have any mutable state, and its state is only dependent on the parameters passed to it. This class represents a reusable UI widget 
   SignUp({Key? key}) : super(key: key); //The constructor takes a Key parameter and passes it to the superclass constructor. The key parameter is optional and allows for the widget's identity to be preserved across widget rebuilds.
 SignUpControllerImp controller = Get.put(SignUpControllerImp()); //This method is part of the GetX package and registers a new instance of the SignUpControllerImp class to be globally accessible within the widget tree.
 
 final key = GlobalKey<FormState>(); //The key variable is defined to hold a global key that is used to identify this widget in the widget tree.
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
          CustomTextTiltleFormAuth(text :"20".tr),
         const SizedBox(height: 20,),
          CustomTextBodyAuth(text: "21".tr),
         const SizedBox(height: 60,),
        
          CustomTextFormAuth( 
            //The CustomTextFormAuth widget is used to create input fields for the user to enter their username, email, phone number, and password. It accepts various parameters, such as valid, which is a callback function that validates the input based on certain criteria, mycontroller, which is an instance of the TextEditingController class used to control the input field's text, hinttext, which is the placeholder text for the input field, and iconData, which is the icon displayed next to the input field.
            
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
                 ),
                );
  }
}