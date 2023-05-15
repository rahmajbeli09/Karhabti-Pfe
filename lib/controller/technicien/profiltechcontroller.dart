import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';

import '../../repository/user_repository/tech_repository.dart';
import '../../services/tech_model.dart';
import '../auth/authcontroller.dart';

abstract class ProfilTechController extends GetxController{
  gotoEditTechProfil();
  goToAnnonces();
  goToAddress();
}
class ProfilTechControllerImp extends ProfilTechController{
   static ProfilTechController get instance => Get.find();
  final _authController = Get.put(AuthController());
  final techRepo = Get.put(TechRepository());
//Step3 : Get user email and pass to user repository to fetch user record
 getUserData() async {
    final email = _authController.firebaseUser.value?.email;
    if (email != null) {
      return await techRepo.getUserDetails(email);
    } else {
      Get.snackbar("error","Login to continue");
    
    
    }
    
  }


updateRecord(String id, TechModel user) async {
   print('Saving changes for user: $user');
  await techRepo.updateUserRecord(id, user);
}
  @override
  gotoEditTechProfil() {
    Get.toNamed(AppRoute.edittechprofil);
  }
  
  @override
  goToAnnonces() {
    Get.toNamed(AppRoute.annonces);
  }
  
  @override
  goToAddress() {
    Get.toNamed(AppRoute.adresse);
  }



}