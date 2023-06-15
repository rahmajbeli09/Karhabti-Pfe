import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controller/technicien/reclamationtechController.dart';
import '../../../../widget/boutton.dart';
import '../../../../widget/home/customtextfieldpost.dart';

// ignore: must_be_immutable
class MessageTech extends StatelessWidget {
   MessageTech({Key? key}) : super(key: key);
ReclamationtechController controller = Get.put(ReclamationtechController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Envoyer une réclamation',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white.withAlpha(0),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          child: ListView(
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/rec.png",
                    height: 190,
                  ),
                  SizedBox(height: 10),
                  CustomTextfieldAuth(
                    mycontroller: controller.titre,
                    height: 20,
                    hinttext: "Ex: Indisponibilité d'un tel service",
                    labelText: "Titre",
                  ),
                  CustomTextfieldAuth(
                    mycontroller: controller.description,
                    height: 70,
                    hinttext: "Ex: Détails de la réclamation",
                    labelText: "Description",
                  ),
                  SizedBox(height: 20),
                  Boutton(
                    text: "Envoyer",
                    color: Colors.amber,
                    onPressed: () {
                      controller.sendReclamation();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}