import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/forgetpasswordcontroller.dart';
import 'package:karhabti_pfe/core/function/alertexitapp.dart';
import 'package:karhabti_pfe/view/screen/auth/forgetpassword/resetpassword.dart';
import '../../../widget/auth/custombuttonauth.dart';
import '../../../widget/auth/customtextbodyauth.dart';
import '../../../widget/auth/customtextformauth.dart';
import '../../../widget/auth/customtexttitleauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  ForgetPasswordControllerImp controller = Get.put(ForgetPasswordControllerImp());

  Future<void> passwordReset(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: controller.email.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text("Password reset link sent! Please check your email."));
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(e.message.toString()));
        },
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Reset Password"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Go back to the login screen
            Get.back();
          },
        ),
      ),
      body: WillPopScope(
        child: Container(
          width: 500,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back2.jpeg"),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Form(
            key: controller.formstate,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 80),
                  child: Image.asset(
                    "assets/images/forgetpassword.png",
                    height: 180,
                    width: 50,
                    alignment: Alignment.topLeft,
                  ),
                ),
                CustomTextTiltleFormAuth(text: "Vérifier l'e-mail"),
                const SizedBox(height: 10,),
                CustomTextBodyAuth(text: "Entrer votre adresse e-mail pour recevoir un code"),
                SizedBox(height: 45,),
                CustomTextFormAuth(
                  mycontroller: controller.email,
                  hinttext: "16",
                  iconData: Icons.email_outlined,
                ),
                const SizedBox(height: 10,),
                CustomButtomAuth(
                  text: "Verifier",
                  onPressed: () {
                    passwordReset(context);
                  },
                ),
              ],
            ),
          ),
        ),
        onWillPop: alertExitApp,
      ),
    );
  }
}
