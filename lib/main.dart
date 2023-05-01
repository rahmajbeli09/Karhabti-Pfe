import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/routes.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/buttombar/profil/profil.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/homescreen.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/venteachat.dart';
import 'package:karhabti_pfe/view/screen/pageone.dart';
import 'package:karhabti_pfe/view/screen/technicien/home/buttombar/hometechpage.dart';
import 'package:karhabti_pfe/view/screen/technicien/home/hometechscreen.dart';
import 'package:karhabti_pfe/view/screen/technicien/signuporlogin2.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
import 'view/screen/client/homepage/localisation.dart';
import 'view/screen/technicien/home/buttombar/profil/profiltech.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations : MyTranslation(),
      debugShowCheckedModeBanner: false,
      locale: controller.language,
      home:  HomeTechScreen(),
      getPages: routes
    );
  }
}

