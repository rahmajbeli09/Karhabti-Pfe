import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:karhabti_pfe/view/screen/auth/login.dart';
import 'package:karhabti_pfe/view/screen/home/homepage.dart';
import 'package:karhabti_pfe/view/screen/onboarding.dart';
import 'package:karhabti_pfe/view/screen/pageone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  final FirebaseAuth auth = FirebaseAuth.instance;
@override
void onReady(){
  super.onReady();
 _user =Rx<User?>(auth.currentUser);
 _user.bindStream(auth.userChanges());
 ever(_user, _initialScreen); 
 }
 _initialScreen(User? user){
if (user==null){
  print("login page");
  Get.offAll(()=>OnBoarding());
}else{
  Get.offAll(()=>HomePage());
}
 }
  void register(String email , password)async{
    try{
     await auth.createUserWithEmailAndPassword(email: email, password: password);

    }catch(e){
      Get.snackbar("about User", "user message",
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account creation failed",
          style: TextStyle(
            color: Colors.white
          )
          ),
          messageText: Text(
            e.toString(),
              style: TextStyle(
            color: Colors.white
          )
          )
          );
    }
  
  }
    void login(String email , password)async{ //hedhiya bdit feha w makamaltech fel login.dart en attendant el bouton logout bch ntesti bih
    try{
     await auth.signInWithEmailAndPassword(email: email, password: password);

    }catch(e){
      Get.snackbar("about Login", "login message",
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login failed",
          style: TextStyle(
            color: Colors.white
          )
          ),
          messageText: Text(
            e.toString(),
              style: TextStyle(
            color: Colors.white
          )
          )
          );
    }
  
  }
  void LogOut() async{ //Flutter Firebase App Setup Tutorial & Getx Authentication | Using Email & Password | Part 2 min 39
    await auth.signOut();
  }
}
