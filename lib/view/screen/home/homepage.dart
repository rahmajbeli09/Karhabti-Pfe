
import 'package:flutter/material.dart';
import 'package:karhabti_pfe/view/widget/home/horizontalcontainer.dart';
import 'package:karhabti_pfe/view/widget/home/verticalcontainer.dart';

import '../../widget/home/iconbuttonbar.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){} , child: Icon(Icons.notifications , color: Colors.black,), backgroundColor: Colors.white,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          children: [
            Row(
              children: [
                IconButtonBar(icon: Icons.home_sharp,),
                IconButtonBar(icon: Icons.car_rental_outlined)
              ],
            ),
            Spacer(),
            Row(
          children: [
            IconButtonBar(icon: Icons.directions_car_filled_outlined),
            IconButtonBar(icon: Icons.person),
          ],
        ),
          ],
        ),
            
          ),
      

      
      body: Container(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18 ,vertical: 5),
              child: Row(children: [
                Container(
                  child: Expanded(child: Text("Garagi" ,                   style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800 ,  )
)),
                ),
                SizedBox(width: 190),
                Container(
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/images/profil.png"),
                ),
              ]),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5 , left: 25),
              child: Text("Prochain rendez-vous" , style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 17),)
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HorizontalContainer(title: "Vidange", image: "assets/images/vid.png", heur: "10:30",ampm: "am",date: "27 sep 22", sizedbox: 45,),
                    HorizontalContainer(title: " Plaquette et \n disque de \n  freins", image: "assets/images/frein.png", heur: "10:30",ampm: "am",date: "27 sep 22",sizedbox: 0,),
                    HorizontalContainer(title: "Charge \nclimatiseur", image: "assets/images/ch-clim.png", heur: "10:30",ampm: "am",date: "27 sep 22",sizedbox: 30,),
                    HorizontalContainer(title: "Decalaminage\n auto", image: "assets/images/deca.png", heur: "10:30",ampm: "am",date: "27 sep 22",sizedbox: 0,),
                    HorizontalContainer(title: "Changement \n batterie", image: "assets/images/ch-batt.png", heur: "10:30",ampm: "am",date: "27 sep 22",sizedbox: 10,),
                    HorizontalContainer(title: "Diagnostic \nauto", image: "assets/images/diagnostic.png", heur: "10:30",ampm: "am",date: "27 sep 22",sizedbox: 30,),

                  
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children:[
                    Row(
                      children: [
                          InkWell(child: VerticalContainer( text:"Vidange" , image: "assets/images/vid.png",color1: Color.fromARGB(255, 233, 169, 120),color2: Color.fromARGB(255, 227, 157, 225),), onTap: (){},),
                         InkWell(child: VerticalContainer( text:" Plaquette et \n    disque de   \n       freins" , image: "assets/images/frein.png",color1: Color.fromARGB(255, 186, 182, 179),color2: Color.fromARGB(255, 255, 255, 255),), onTap: (){},),
                      ],
                    ),
                     Row(children: [
                     InkWell(child: VerticalContainer( text:"   Charge  \nclimatiseur" , image: "assets/images/ch-clim.png",color1: Color.fromARGB(255, 120, 222, 233),color2: Color.fromARGB(255, 227, 157, 225),), onTap: (){},),
                     InkWell(child: VerticalContainer( text:"Decalaminage\n        auto" , image: "assets/images/deca.png",color1: Color.fromARGB(255, 144, 203, 130),color2: Color.fromARGB(255, 227, 157, 225),), onTap: (){},), 
                     ],),
                    Row(children: [
                     InkWell(child: VerticalContainer( text:"Changement \n    batterie" , image: "assets/images/ch-batt.png",color1: Color.fromARGB(255, 124, 126, 124),color2: Color.fromARGB(255, 215, 209, 215),), onTap: (){},),
                     InkWell(child: VerticalContainer( text:"Diagnostic\n     auto" , image: "assets/images/diagnostic.png",color1: Color.fromARGB(255, 241, 156, 91),color2: Color.fromARGB(255, 171, 208, 238),), onTap: (){},),
                    ],)
                  ]
                ),
              ),
              
              
         
          ],
        ),
      ),
    );
  }
}