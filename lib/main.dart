import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/routes.dart';
import 'package:karhabti_pfe/view/screen/auth/login.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/panne/localisation.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/panne/panne.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/panne/profilelistech.dart';
import 'package:karhabti_pfe/view/screen/pageone.dart';
import 'package:karhabti_pfe/view/screen/technicien/home/buttombar/messagetech.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
import 'view/screen/auth/resetpassword.dart';
import 'view/screen/client/homepage/panne/liste.dart';
import 'view/screen/client/homepage/panne/messagepanne.dart';

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
      home:  ResetPassword(),
      getPages: routes
    ); 
  }
}

