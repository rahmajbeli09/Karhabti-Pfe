import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widget/home/customtextfieldpost.dart';
import '../../../../widget/home/image.dart';

class Postulation extends StatelessWidget {

   Postulation({Key? key}) : super(key: key);

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
  title: Text('Ajouter une annonce' , style: TextStyle(color: Colors.black , fontFamily: "Comfortaa" , fontWeight: FontWeight.bold , fontSize: 18),),
  elevation: 0,
  backgroundColor: Colors.white.withAlpha(0),
),
      
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
        child: Form(
          child: ListView(
            children: [
              Column(children: [
                Image.asset("assets/images/post.png" , height: 190,),
                SizedBox(height: 10,),
                CustomTextfieldAuth(
                  height:20,
                  hinttext: "Ex: Plaquettes de frein",
                  labelText: "Titre",

                ),
                CustomTextfieldAuth(
                  height: 70,
                  hinttext: "Ex: haute qualité qui offre une performance fiable",
                  labelText: "Description",
                ),
                CustomTextfieldAuth(
                  height: 20,
                  hinttext: "Ex: 100dt",
                  labelText: "Prix",
                ),
                 ImagePickerWidget(),
                SizedBox(height: 60,),
                MaterialButton(onPressed:(){}, 
          child: Text ("Postuler",style:const TextStyle(fontWeight: FontWeight.bold , fontSize: 15 , fontFamily: "Comfortaa",)),
          color: Color.fromARGB(255, 255, 203, 30),
          padding: EdgeInsets.symmetric(horizontal: 140 , vertical: 10),
          
          ),
              ]),
            ],
          ),
        ),
      ),
      

    );
    
  }
}