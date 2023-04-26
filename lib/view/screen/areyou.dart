import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/auth/custombuttonauth.dart';

import '../../controller/areyoucontroller.dart';

class AreYou extends StatelessWidget {
  const AreYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   AreYouControllerImp controller = Get.put(AreYouControllerImp());

    return Scaffold(
      body:Container(
        width: 500,
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
                    SizedBox(height: 120,),
                     Text("Etes-Vous..?", style: TextStyle(fontFamily: "Comfortaa" , fontSize: 20 , fontWeight: FontWeight.w600),),
                     SizedBox(height: 30,),
                     CustomButtomAuth(text: "Client",onPressed: (){
                      controller.goToOnBoarding();
                     },),
                     SizedBox(height: 10,),
                    CustomButtomAuth(text: "Technicien",onPressed: (){
                      controller.goToOnBoarding2();
                    },)
                   ],
                 )),
      ));

    
  }
}