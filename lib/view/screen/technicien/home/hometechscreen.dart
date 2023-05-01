import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/technicien/homescreentechcontroller.dart';
import '../../../widget/home/custombuttombartech.dart';

class HomeTechScreen extends StatelessWidget {
  const HomeTechScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenTechControllerImp());
    return  GetBuilder<HomeScreenTechControllerImp>
    (builder: (controller) =>
    Scaffold(
      floatingActionButton:  FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 203, 30),
        onPressed:(){
          controller.changePage(4);
        } ,
        child: Icon(Icons.notifications ,) ,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar:CustomBottomBarTech(),
     body: controller.listPage.elementAt(controller.currentPage),),
     );
  }
}