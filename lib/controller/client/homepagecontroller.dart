import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class HomePageController extends GetxController{
goToPanne();
goToVenteAchat();
goToFrais();

}
class  HomePageControllerImp extends  HomePageController {

  @override
  goToPanne() {
    Get.toNamed(AppRoute.panne);
  }
  
  @override
  goToVenteAchat() {
    Get.toNamed(AppRoute.venteachat);
  }
  
  @override
  goToFrais() {
    Get.toNamed(AppRoute.frais);
  }
  
  
  
 
  


}