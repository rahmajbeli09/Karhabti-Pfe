import 'package:flutter/material.dart';

import '../../../../widget/home/calendrier.dart';
import '../../../../widget/home/nomet prenomcontainer.dart';

class HomeTechPage extends StatelessWidget {
  const HomeTechPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          NomEtPrenomContainer(),
          SizedBox(height: 40,),
          Text("Consulter Vos rendez-Vous", style: TextStyle(fontSize: 20 , fontFamily: "Comfortaa" , fontWeight: FontWeight.w900),),
          SizedBox(height: 20),
          Calendrier(),
        ],
      ),
    );
  }
}