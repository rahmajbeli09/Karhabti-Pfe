import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();
  signUp(String email, String password);
  SignUp();
  goToSignUp();
  goToHomePage();
}

class SignUpControllerImp extends SignUpController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController username ; 
  late TextEditingController phone ; 
  late TextEditingController email ; 
  late TextEditingController password ; 

//call this function from design and it will do the rest
Future<void> registerUser(String email, String password) async {
 await signUp(email, password);
}
  SignUp(){
    var formdata = formstate.currentState;
    if (formdata!.validate()){
        print("valid");
    }else{
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
    phone = TextEditingController();
    username = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    phone.dispose();
    super.dispose();
  }
  
  @override
  goToHomePage() {
    Get.toNamed(AppRoute.home);
  }
   @override
    Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User created: ${userCredential.user}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      print(user.uid);
    }
  });
  }

} 