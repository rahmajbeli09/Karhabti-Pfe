import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/home/calendrier.dart';
import '../../../../controller/technicien/homepagetechcontroller.dart';
import '../../../widget/home/nomet prenomcontainer.dart';

// ignore: must_be_immutable
class RendezVousTech extends StatelessWidget {
   RendezVousTech({Key? key}) : super(key: key);
  HomePageTechControllerImp controller = Get.put(HomePageTechControllerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar : AppBar(
  leading: IconButton(
    icon: Icon(Icons.arrow_back , color: Colors.black),
    onPressed: () {
      Get.back(); 
    },
  ),
  centerTitle: true,
  title: Text('Consulter vos rendez-vous' , style: TextStyle(color: Colors.black , fontFamily: "Comfortaa" , fontWeight: FontWeight.bold , fontSize: 18),),
  elevation: 0,
  backgroundColor: Colors.white.withAlpha(0),
),
      body: Column(
        children: [
          NomEtPrenomContainer(),
          SizedBox(height: 60,),
          Text("Consulter Vos rendez-Vous", style: TextStyle(fontSize: 20 , fontFamily: "Comfortaa" , fontWeight: FontWeight.w900),),
          SizedBox(height: 20,),
          Calendrier(),

        ],
      ),
    );
  }
}