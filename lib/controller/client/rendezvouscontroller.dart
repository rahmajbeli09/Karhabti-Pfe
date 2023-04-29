import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

abstract class RendezVousController extends GetxController{
  goToRendezVous();
  goToAnnonces();
}
class RendezVousControllerImp extends RendezVousController{
  @override
  goToRendezVous() {
    Get.toNamed(AppRoute.rendezvous);
  }
  
  @override
  goToAnnonces() {
    Get.toNamed(AppRoute.annonces);
  }

}