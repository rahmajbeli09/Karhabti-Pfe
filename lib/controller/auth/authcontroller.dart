import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:karhabti_pfe/repository/user_repository/user_repository.dart';
import 'package:karhabti_pfe/services/user_model.dart';
import 'package:karhabti_pfe/view/screen/auth/login.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/homescreen.dart';
import 'package:karhabti_pfe/view/screen/pageone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../repository/user_repository/exceptions/signup_email_pwd_failure.dart';
import '../../repository/user_repository/tech_repository.dart';
import '../../services/tech_model.dart';
import '../../view/screen/client/homepage/buttombar/homepage.dart';
import '../../view/screen/technicien/home/hometechscreen.dart';

import 'package:google_sign_in/google_sign_in.dart';




class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late final Rx<User?> firebaseUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final userRepo = Get.put(UserRepository());
  final techRepo = Get.put(TechRepository());
    String? getUserId() {
    return firebaseUser.value?.uid;
  }
@override
void onReady(){
  super.onReady();
 firebaseUser =Rx<User?>(auth.currentUser);
 firebaseUser.bindStream(auth.userChanges());
 ever(firebaseUser, _initialScreen); 
 }
 // i need to check with this method if it works i need to apply it for technician
// Widget handleAuthState() {
//   return StreamBuilder<User?>(
//     stream: FirebaseAuth.instance.authStateChanges(),
//     builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//       if (snapshot.hasData) {
//         return HomeScreen();
//       } else {
//         return Login();
//       }
//     },
//   );
// }

void _initialScreen(User? user) async {
  if (user == null) {
    // user is not logged in, show login page
    Get.offAll(() => PageOne());
  } else {
    // check if user exists in Users collection
    final email = user.email;
    final userModel = await userRepo.getUserByEmail(email);
    if (userModel != null) {
      // user exists in Users collection, show home screen
      Get.offAll(() => HomeScreen());
    } else {
      // check if user exists in Techniciens collection
      final techModel = await techRepo.getTechByEmail(email);
      if (techModel != null) {
        // user exists in Techniciens collection, show tech home screen
        Get.offAll(() => HomeTechScreen());
      } 
    }
  }
}



  void register(String email , password)async{
    try{
  await auth.createUserWithEmailAndPassword(email: email, password: password);
if (firebaseUser.value != null) {
  Get.offAll(() => PageOne());
} else {
  Get.offAll(() => HomeScreen());
}

    
    }catch(e){
            Get.snackbar(
        "error",
        "please verify your data! ",
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  
  }
  Future<void> createUser(UserModel user) async { //for the user
await userRepo.createUser(user);
  }
Future<void> createTech(TechModel user) async {
  await techRepo.createTech(user);
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
    String? getUserEmail() {
    return firebaseUser.value?.email;
  }
  void LogOut() async{ //Flutter Firebase App Setup Tutorial & Getx Authentication | Using Email & Password | Part 2 min 39
    await auth.signOut();
  }
  
}
