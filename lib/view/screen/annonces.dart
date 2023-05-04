import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Annonces extends StatelessWidget {
  const Annonces({Key? key}) : super(key: key);

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
  title: Text('Consulter vos annonces' , style: TextStyle(color: Colors.black , fontFamily: "Comfortaa" , fontWeight: FontWeight.bold , fontSize: 18),),
  elevation: 0,
  backgroundColor: Colors.white.withAlpha(0),
),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Column(children: [
              Image.asset("assets/images/annonce.png"),
              Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 148, 138, 138),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("assets/images/batterie.png",height: 100,width: 100,),
              Text("   Batterie",style:const TextStyle(fontWeight: FontWeight.w400 , fontSize: 15 , fontFamily: "Comfortaa")),
            ],
          ),
                        Text("   Prix",style:const TextStyle(fontWeight: FontWeight.w400 , fontSize: 15 , fontFamily: "Comfortaa")),

        ],
      ),
    )

            ]),
          ],
        ),
      ),
    
    );
  }
}