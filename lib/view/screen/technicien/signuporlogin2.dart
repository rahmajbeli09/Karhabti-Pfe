import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/technicien/signuporlogin2controller.dart';


class SignUpOrLogin2 extends StatelessWidget {
  const SignUpOrLogin2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpOrLogin2ControllerImp controller = Get.put(SignUpOrLogin2ControllerImp());
    return Scaffold(
      body:Container(
        padding: EdgeInsets.symmetric(vertical: 60),
          decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/background.jpeg" ),
      fit: BoxFit.fitHeight,
    ),
  ),
        child: SafeArea(
          child:
                 Column(
                   children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 203, 30),
            borderRadius: BorderRadius.circular(150),
                      ),
                      child: Image.asset("assets/images/logo.png"),
                    ),
                                        SizedBox(height: 150,),
                    Text("Bienvenue" , style: TextStyle(fontSize: 40 , fontFamily: "Comfortaa", fontWeight: FontWeight.w800),),
                    SizedBox(height: 15,),
                    Text("Connectez-vous si vous avez de compte \n ou inscrivez-vous pour nous rejoindre ",
                    style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 15),
                    ),
                    SizedBox(height: 100,),
                     Container(
                      padding: EdgeInsets.symmetric(),
                      margin: EdgeInsets.symmetric(horizontal:35),
                       child: Row(
                        children: [
                          MaterialButton(onPressed: (){
                            controller.goToLogin();
                          } , child: Text("13".tr , style: TextStyle(fontFamily: "Comfortaa",),), color: Colors.white, textColor: Colors.black,padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 18),),
                          Spacer(),
                          MaterialButton(onPressed: (){
                            controller.goToSignUp();
                          } , child: Text("14".tr , style: TextStyle(fontFamily: "Comfortaa",),),color: Colors.white,textColor: Colors.black, padding: EdgeInsets.symmetric(horizontal: 22 , vertical: 18),)
                        ],
                ),
        ),
                   ],
                 )),
      ));
  }
}