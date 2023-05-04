import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/boutton.dart';
import 'package:karhabti_pfe/view/widget/home/editProfilContainer.dart';

import '../../../../../../controller/client/editprofilcntroller.dart';


class EditProfil extends StatelessWidget {
  final EditController editController = Get.put(EditController());

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
          'Modifier vos cordonnées',
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
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 550,
                width: 400,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Image.asset("assets/images/profil.png" , height: 100,)
                      ],
                    ),
                    EditProfilContainer(
                      id: "userName",
                      title: "Nom d'utilisateur :",
                      text: "Rahma Jbeli",
                    ),
                    EditProfilContainer(
                      id : "adresse",
                      title: "Adresse E-mail :",
                      text: "Rahma@gmail.com",
                    ),
                    EditProfilContainer(
                      id : "motdepasse",
                      title: "Mot de passe :",
                      text: "rahma123",
                    ),
                     EditProfilContainer(
                      id: "tel",
                      title: "Numero de telephone  :",
                      text: "21935704",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Boutton(text: "Enregistrer", color: Color.fromARGB(255, 255, 203, 30))
            ],
          ),
          // Conteneur d'édition
          Obx(() => editController.isEditing.value
              ? _buildEditingContainer()
              : SizedBox()),
        ],
      ),
    );
  }

  Widget _buildEditingContainer() {
    return Positioned.fill(
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            width: 150,
            height: 200,
            color: Color.fromARGB(255, 92, 58, 58),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Conteneur d'édition"),
                ElevatedButton(
                  onPressed: () {
                    editController.isEditing.toggle();
                  },
                  child: Text("Sauvegarder"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
