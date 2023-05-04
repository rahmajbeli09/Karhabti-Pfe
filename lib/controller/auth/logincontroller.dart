
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class LoginController extends GetxController{
  signIn(String email, String password);
  login();
  goToSignUp(); 
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

  login(){
    var formdata = formstate.currentState;
    if (formdata!.validate()){
        print("valid");
    }else{
      print("not Valid");
    }
    Get.offAllNamed(AppRoute.homescreen);

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