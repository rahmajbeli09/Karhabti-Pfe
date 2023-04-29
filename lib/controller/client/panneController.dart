import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class PanneController extends GetxController{
  goToLoc();
}
 class PanneControllerImp extends PanneController{
  @override
  goToLoc() {
    Get.toNamed(AppRoute.loc);
  }

 }