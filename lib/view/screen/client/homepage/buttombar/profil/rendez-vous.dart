import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../controller/client/rendezvouscontroller.dart';
import '../../../../../widget/home/calendrier.dart';

// ignore: must_be_immutable
class RendezVous extends StatelessWidget {
   RendezVous({Key? key}) : super(key: key);
  RendezVousControllerImp controller = Get.put(RendezVousControllerImp());
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
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                height: 200,
                width: 200,
                child: Image.asset("assets/images/rendez-vous.png"),
          ),
          Text("Mes \n Rendez-Vous" , textAlign: TextAlign.center,style: TextStyle(fontSize: 23 , fontFamily: "Comfortaa"  , fontWeight: FontWeight.w900),)
              ],
            ),
            Calendrier(),
          ],
        ),
      ));
  }
}