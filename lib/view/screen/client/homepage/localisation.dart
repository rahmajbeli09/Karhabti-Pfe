import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/boutton.dart';
import '../../../../controller/client/locationcontroller.dart';

class Localisezvous extends StatelessWidget {
   Localisezvous({Key? key}) : super(key: key);
    Location_ControllerImp controller = Get.put(Location_ControllerImp());
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
  title: Text('Trouver un expert' , style: TextStyle(color: Colors.black , fontFamily: "Comfortaa" , fontWeight: FontWeight.bold , fontSize: 18),),
  elevation: 0,
  backgroundColor: Colors.white.withAlpha(0),
),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
        child: Column(
          children: [
            Image.asset("assets/images/loc.png" , height: 300,),
              SizedBox(height: 50,),
              Text(" Merci de determiner votre position" , style: TextStyle(fontSize: 19 , fontFamily: "comfortaa" , fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Text( "Cliquez sur le bouton 'Localisez-vous' pour accéder à une liste de techniciens qualifiés se trouvant à proximité de votre position." , style: TextStyle(fontSize: 13 , fontFamily: "comfortaa" , fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              SizedBox(height: 80,),
              Boutton(text: "Localisez-Vous" , onPressed: (){
                controller.getLocation();
              },
              color: Color.fromARGB(255, 255, 203, 30),)
          ],
        ),
      ),
    );
  }
}