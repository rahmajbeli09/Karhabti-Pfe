import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/home/horizontalcontainer.dart';
import 'package:karhabti_pfe/view/widget/home/nomet%20prenomcontainer.dart';
import 'package:karhabti_pfe/view/widget/home/verticalcontainer.dart';
import '../../../../../controller/client/homepagecontroller.dart';
import '../../../../../controller/client/panneController.dart';
import '../panne/map.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageControllerImp controller = Get.put(HomePageControllerImp());
    PanneControllerImp controller1 = Get.put(PanneControllerImp());

    
    return Scaffold(
      body: ListView(
        children: [
          Column(children: [
             NomEtPrenomContainer(),
             SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                 InkWell(child:HorizontalContainer(image: "assets/images/mecanicien.png", text: "36".tr) , onTap: (){controller1.goToLoc();},),
                 InkWell(child: HorizontalContainer(image: "assets/images/elect.png", text: "37".tr),  onTap: (){controller1.goToLoc();}),
                 InkWell(child:HorizontalContainer(image: "assets/images/tolier.png", text: "38".tr), onTap: (){controller1.goToLoc();}),
                 InkWell(child:HorizontalContainer(image: "assets/images/pneu.png", text: "39".tr), onTap: (){controller1.goToLoc();}),
                 InkWell(child:HorizontalContainer(image: "assets/images/vitrage.png", text: "40".tr), onTap: (){controller1.goToLoc();}),
                 InkWell(child:HorizontalContainer(image: "assets/images/climatisation.png", text: "41".tr), onTap: (){controller1.goToLoc();}),
                 InkWell(child: HorizontalContainer(image: "assets/images/lavage.png", text: "42".tr), onTap: (){controller1.goToLoc();}),
                ],),
              ),
            InkWell(child: VerticalContainer(image: "assets/images/panne.png", text: "43".tr),onTap: (){controller.goToPanne();},),
            InkWell(child: VerticalContainer(image: "assets/images/frais.png", text: "44".tr),onTap: (){controller.goToFrais();}),            
            InkWell(child: VerticalContainer(image: "assets/images/venach.png", text: "45".tr),onTap: (){controller.goToVenteAchat();}),
          ]),
        ]
      ),
    );
  }
} 
