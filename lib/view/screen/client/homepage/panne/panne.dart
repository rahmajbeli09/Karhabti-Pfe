import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:karhabti_pfe/view/widget/boutton.dart';
import '../../../../../controller/client/panneController.dart';

class Panne extends StatelessWidget {
   Panne({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PanneControllerImp controller = Get.put(PanneControllerImp());
    return Scaffold(
      appBar : AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back , color: Colors.black),
    onPressed: () {
      Get.back(); 
    },
  ),
  centerTitle: true,
  title: Text('50'.tr , style: TextStyle(color: Colors.black , fontFamily: "Comfortaa" , fontWeight: FontWeight.bold , fontSize: 18),),
  elevation: 0,
  backgroundColor: Colors.white.withAlpha(0),
),
      body: Column(
        children: [
          Image.asset("assets/images/pannepage.png" , height:400 , width: 400,),
          Text("51".tr,style: TextStyle(fontFamily: "Comfortaa" , fontSize: 20, fontWeight: FontWeight.w900),textAlign: TextAlign.center,),
         SizedBox(height: 20,),
         Boutton(text: "52".tr , onPressed: (){
            controller.goToLoc();
          } ,
          color :Color.fromARGB(255, 255, 203, 30)),
          SizedBox(height: 5,),
           Boutton(text: "53".tr , onPressed: (){
            controller.goToLoc();
          } ,
          color: Color.fromARGB(255, 255, 203, 30),),
                    SizedBox(height:25,),
          GestureDetector(
            onTap: (){
              Get.toNamed(AppRoute.messagepanne);
            },
            child: Text("54".tr , style: TextStyle(decoration: TextDecoration.underline ,fontFamily: "Comfortaa" , fontSize: 15, fontWeight: FontWeight.w700),textAlign: TextAlign.center, )),

        ],
      ),
    );
  }
}