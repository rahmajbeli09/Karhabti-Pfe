import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/home/horizontalcontainer.dart';
import 'package:karhabti_pfe/view/widget/home/nomet%20prenomcontainer.dart';
import 'package:karhabti_pfe/view/widget/home/verticalcontainer.dart';
import '../../../../controller/client/homepagecontroller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageControllerImp controller = Get.put(HomePageControllerImp());
    return Scaffold(
      body: ListView(
        children: [
          Column(children: [
             NomEtPrenomContainer(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                 InkWell(child:HorizontalContainer(image: "assets/images/mecanicien.png", text: "cherchez-vous\nun mecanicien?")),
                InkWell(child: HorizontalContainer(image: "assets/images/elect.png", text: "cherchez-vous\nun electricien?")),
                 InkWell(child:HorizontalContainer(image: "assets/images/tolier.png", text: "cherchez-vous \nun tolier?")),
                 InkWell(child:HorizontalContainer(image: "assets/images/pneu.png", text: "cherchez-vous \nun technicien\nen pneumatique?")),
                 InkWell(child:HorizontalContainer(image: "assets/images/vitrage.png", text: "cherchez-vous \nun technicen \nen vitrage?")),
                 InkWell(child:HorizontalContainer(image: "assets/images/climatisation.png", text: "cherchez-vous\nun technicien\nen climatisation?")),
                InkWell(child: HorizontalContainer(image: "assets/images/lavage.png", text: "cherchez-vous\nun lavage?")),

                ],),
              ),
            InkWell(child: VerticalContainer(image: "assets/images/panne.png", text: "Votre Voiture est-il en panne?"),onTap: (){controller.goToPanne();},),
            InkWell(child: VerticalContainer(image: "assets/images/venach.png", text: "Cherchez-vous des pièces de rechange ? \n Avez-vous des pièces de rechange à vendre?"),onTap: (){controller.goToVenteAchat();}),
          ]),
        ]
      ),
    );
  }
} 
