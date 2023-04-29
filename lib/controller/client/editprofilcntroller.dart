import 'package:get/get.dart';

class EditController extends GetxController {
  RxBool isEditing = false.obs;
    // Ajouter ces champs
  RxString prevUserName = "".obs;
  RxString newUserName = "".obs;
  RxString prevAdresse = "".obs;
  RxString newAdresse = "".obs;
  RxString prevPassword = "".obs;
  RxString newPassword = "".obs;
  RxString prevTel = "".obs;
  RxString newTel = "".obs;
}
