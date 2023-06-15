
import 'package:flutter/material.dart';
import 'package:karhabti_pfe/view/screen/admin/reclamation.dart';
import 'package:get/get.dart';

import '../../../controller/client/homepagecontroller.dart';
import '../../../controller/technicien/homepagetechcontroller.dart';
import '../../widget/home/nomet prenomcontainer.dart';
import '../../widget/home/verticalcontainer.dart';
import '../areyou.dart';
import 'edituser.dart';
class AdminHomePage extends StatelessWidget {
  HomePageTechControllerImp controller = Get.put(HomePageTechControllerImp());
  HomePageControllerImp controller2 = Get.put(HomePageControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NomEtPrenomContainer(),
            SizedBox(height: 100,),
            InkWell(
              child: VerticalContainer(image: "assets/images/rendez-vous.png", text: "Consulter les réclamations"),
              onTap: (){
                Get.to(Reclamation());
              },
            ),
            SizedBox(height: 20,),
            InkWell(
              child: VerticalContainer(image: "assets/images/venach.png", text: "Consulter les utilisateurs"),
              onTap: (){
                Get.to(EditUser());
              },
            ),
            SizedBox(height: 400,),
            IconButton(onPressed: (){Get.offAll(AreYou());}, icon: Icon(Icons.logout_outlined))
          ],
        ),
      ),
    );
  }
}


// class AdminHomePage extends StatelessWidget {
//   const AdminHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 100,),
//           InkWell(
//             child: Container(
//               height: 100,
//               width: double.infinity,
//               color: Colors.amber,
//               child: Center(child: Text("Consulter les reclamations" , style: TextStyle(fontFamily: "Comfortaa" , fontSize: 25),)),
//             ),
//             onTap: (){
//               Get.to(Reclamation());
//             },
//           ),
//           SizedBox(height: 20,),
//           InkWell(
//             child: Container(
//               height: 100,
//               width: double.infinity,
//               color: Colors.amber,
//               child: Center(child: Text("Consulter les utilisateurs", style: TextStyle(fontFamily: "Comfortaa" , fontSize: 25),)),
//             ),
//             onTap: (){
//               Get.to(EditUser());
//             },
//           ),
//           SizedBox(height: 400,),
//           IconButton(onPressed: (){Get.offAll(AreYou());}, icon: Icon(Icons.logout_outlined))
//         ],
//       ),
//     );
//   }
// }