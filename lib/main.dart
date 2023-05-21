import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/routes.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/buttombar/profil/rendez-vous.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/homescreen.dart';
import 'package:karhabti_pfe/view/screen/pageone.dart';
import 'package:karhabti_pfe/view/screen/technicien/home/hometechscreen.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
import 'view/screen/client/homepage/buttombar/messages.dart';
import 'view/screen/client/homepage/buttombar/notification.dart';
import 'view/screen/venach/postulation.dart';

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
      home:  HomeScreen(),
      getPages: routes
    ); 
  }
}

