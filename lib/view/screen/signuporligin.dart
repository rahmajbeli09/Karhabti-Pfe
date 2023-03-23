import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/signuporlogincontroller.dart';


class SignUpOrLogin extends StatelessWidget {
  const SignUpOrLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpOrLoginControllerImp controller = Get.put(SignUpOrLoginControllerImp());
    return Scaffold(
      body:SafeArea(
        child:Column(
          children: [
            Container(
              width: 350,
              height: 380,
              child: Image.asset("assets/images/loginorsignup.png")),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Text("11".tr , style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800 , fontFamily: "Comfortaa"  ), textAlign: TextAlign.center,)),
           SizedBox(height: 20,),
            Container(
             margin: EdgeInsets.symmetric(horizontal: 50),
              child: Text("12".tr,
               style: TextStyle( fontWeight: FontWeight.w600 ,
               fontSize: 12.5,
               fontFamily: "Comfortaa",
                color: Colors.grey, ),
                textAlign: TextAlign.center,
                textScaleFactor: 1.2,)),
                SizedBox(height: 80,),
              
               Container(
                margin: EdgeInsets.symmetric(horizontal:35),
                 child: Row(
                  children: [
                    MaterialButton(onPressed: (){
                      controller.goToLogin();
                    } , child: Text("13".tr , style: TextStyle(fontFamily: "Comfortaa",),), color: Colors.white, textColor: Colors.black,padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 18),),
                    MaterialButton(onPressed: (){
                      controller.goToSignUp();
                    } , child: Text("14".tr , style: TextStyle(fontFamily: "Comfortaa",),),color: Colors.white,textColor: Colors.black, padding: EdgeInsets.symmetric(horizontal: 22 , vertical: 18),)
                  ],
              ),
               ),
         

          ],
        ) ),
    );
  }
}