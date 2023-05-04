import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:karhabti_pfe/repository/user_repository/user_repository.dart';
import 'package:karhabti_pfe/services/user_model.dart';
import 'package:karhabti_pfe/view/screen/auth/login.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/homepage.dart';

import 'package:karhabti_pfe/view/screen/pageone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../repository/user_repository/exceptions/signup_email_pwd_failure.dart';
import '../../repository/user_repository/tech_repository.dart';
import '../../services/tech_model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final userRepo = Get.put(UserRepository());
  final techRepo = Get.put(TechRepository());
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
  Get.offAll(()=>PageOne()); 
}else{
  Get.offAll(()=>HomePage());
}
 }
  void register(String email , password)async{
    try{
     await auth.createUserWithEmailAndPassword(email: email, password: password);
  _user.value!=null? Get.offAll(()=>PageOne()) : Get.offAll(()=>HomePage()); //Homescreen
    }on FirebaseAuthException catch(e){
final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
print('FIREBASE AUTH EXCEPTION - ${ex.message}');
throw ex;
    
    }catch(_){
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  
  }
  Future<void> createUser(UserModel user) async {
await userRepo.createUser(user);
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
