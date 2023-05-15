import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/boutton.dart';
import 'package:karhabti_pfe/view/widget/home/fraistextformfiled.dart';

import '../../../../controller/client/fraiscontroller.dart';

// ignore: must_be_immutable
class Frais extends StatelessWidget {
   Frais({Key? key}) : super(key: key);
  FraisControllerImp controller = Get.put(FraisControllerImp());  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar : AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back , color: Colors.black),
    onPressed: () {
      Get.back(); 
    },
  ),
  centerTitle: true,
  title: Text("Suivre l'échéance de papiers" , style: TextStyle(color: Colors.black , fontFamily: "Comfortaa" , fontWeight: FontWeight.bold , fontSize: 18),),
  elevation: 0,
  backgroundColor: Colors.white.withAlpha(0),
),
body: Container(
  margin: EdgeInsets.symmetric(horizontal: 15 ),
  child: Form(child: 
  ListView(
    children: [
      Image.asset("assets/images/frais2.png" , height: 200,),
      Text("Suivez vos paiements en temps réel et recevez des notifications instantanées pour ne jamais manquer une facture" , textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 15 , fontFamily: "Comfortaa"),),
      SizedBox(height: 40,),
      FraisTextFormFiled(
         controller.assurance,
        text: "Date d'échéance de l'assurance automobile"),
      FraisTextFormFiled( controller.vignette,text: "Date d'expiration de la vignette"),
      FraisTextFormFiled( controller.visite,text: "Date de la prochaine visite technique"),
      SizedBox(height: 30,),
      Boutton(text: "Sauvegarder", color: Color.fromARGB(255, 255, 203, 30))
    ],
  ),
  )
  ,)
    );
    
    
    
  }
}