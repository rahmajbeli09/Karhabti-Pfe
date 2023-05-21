import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/client/ventachcontroller.dart';


// ignore: must_be_immutable
class VenteAchat extends StatelessWidget {
   VenteAchat({Key? key}) : super(key: key);
    VentAchCotrollerImp controller = Get.put(VentAchCotrollerImp());
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
  title: Text('Recherche de pièces ' , style: TextStyle(color: Colors.black , fontFamily: "Comfortaa" , fontWeight: FontWeight.bold , fontSize: 18),),
  elevation: 0,
  backgroundColor: Colors.white.withAlpha(0),
),
      body: ListView(
        children: [
          Column(children: [
            AnimatedOpacity(
                opacity: 1.0, 
                duration: Duration(milliseconds: 500),
                child: Container(
                margin:EdgeInsets.symmetric(vertical: 10, horizontal: 20) ,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Rechercher",
                      hintStyle: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 131, 127, 127) ,fontFamily: "Comfortaa",fontWeight: FontWeight.w800) ,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                      const EdgeInsets.symmetric(vertical:20, horizontal: 20),
                      suffixIcon: InkWell(
                        onTap: () {
                          // Ici, vous pouvez ajouter des actions lorsque l'utilisateur clique sur l'icône de recherche
                        },
                        child: Icon(Icons.search , color: Color.fromARGB(255, 131, 127, 127),),
                      ),
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(14) ) ,),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 280 , top: 500),
                decoration: BoxDecoration(
                color:Color.fromARGB(255, 255, 203, 30),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(onPressed: (){
                  controller.goToPostulation();
                }, icon: Icon(Icons.add ))),

          ]),
        ],
      ),
    );
  }
}