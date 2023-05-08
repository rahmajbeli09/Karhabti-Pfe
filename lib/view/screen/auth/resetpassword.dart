import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/function/alertexitapp.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtexttitleauth.dart';
// ignore: must_be_immutable
class ResetPassword extends StatelessWidget {
   ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                 body: WillPopScope(child: Container(
                        width: 500,
        padding: EdgeInsets.symmetric( horizontal: 25 , vertical: 10),
          decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/back2.jpeg" ),
      fit: BoxFit.fitHeight,
    ),
  ),
                  child: Form(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 80),
                          child: Image.asset("assets/images/verifycode.png" , height: 180, width: 50, alignment: Alignment.topLeft,)),
                          CustomTextTiltleFormAuth(text :"vérifier l'e-mail"),
                        const SizedBox(height: 10,),
                          CustomTextBodyAuth(text: "21".tr),
                        SizedBox(height: 45,),
                        const SizedBox(height: 10,),
                                      CustomButtomAuth(text: "14".tr, onPressed :() {
               
              }),
                      ],
                    ),
                  ),
                 ),
                 
                 onWillPop: alertExitApp)
                );
  }
}