import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:karhabti_pfe/view/widget/home/nomet%20prenomcontainer.dart';
import 'package:karhabti_pfe/view/widget/home/profilcontainer.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              NomEtPrenomContainer(),
              SizedBox(height: 50,),
              ProfilContainer(
                icon: Icons.face, 
                Titre: "  Information Personnelle", 
                text: "Modifier vos informations personnelles et verfifer votre compte.",
                onTap: (){
                  Get.toNamed(AppRoute.edit);
                },
                ),
                ProfilContainer(
                icon: Icons.calendar_month, 
                Titre: "  Mes rendez-vous", 
                text: "Organisez votre emploi du temps en consultant vos rendez-vous prévus.",
                ),
                ProfilContainer(
                icon: Icons.campaign, 
                Titre: "  Mes annonces", 
                text: "Gérer, modifier et booster vos annonce.",
                ),

                Row(children: [
                  Text("Déconnexion") , 
                  IconButton(onPressed: (){}, icon: Icon(Icons.logout_outlined)),
                ],),
            ],
          ),
        ],
      ),
    
    );
  }
}