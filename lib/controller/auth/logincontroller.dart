
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class LoginController extends GetxController{
  signIn(String email, String password);
  login();
  goToSignUp(); 
  goToForgetPassword(); 
}

class LoginControllerImp extends LoginController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email ; 
  late TextEditingController password ; 
   bool isshowpassword = true ;
   showPassword(){
    isshowpassword = isshowpassword == true ?false : true;
    update();
   }

login() async {
  var formdata = formstate.currentState;
  if (formdata!.validate()) {
    print("valid");
    try {
      await signIn(email.text.trim(), password.text.trim());
      // Navigate to the home page if the login is successful
      Get.offAllNamed(AppRoute.homescreen);
    } catch (e) {
      print("Login failed");
      // Display a snackbar indicating the login failure
      Get.snackbar(
        "Login failed",
        "Invalid email or password",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          "Invalid email or password",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  } else {
    print("not Valid");
  }
}


  
  @override
  goToSignUp() {
    Get.toNamed(AppRoute.signup);
  }

  @override
  void onInit() {
    
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
  
  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
  
  
  @override
  
  Future<void> signIn(String email, String password) async {
   
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User signed in: ${userCredential.user}');
      Get.toNamed(AppRoute.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
 
  
}