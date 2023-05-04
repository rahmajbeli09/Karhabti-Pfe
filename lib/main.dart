import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/auth/authcontroller.dart';
import 'package:karhabti_pfe/core/services/themeservice.dart';
import 'package:karhabti_pfe/firebase_options.dart';
import 'package:karhabti_pfe/routes.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/buttombar/profil/profil.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/homepage.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/homescreen.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/localisation.dart';
import 'package:karhabti_pfe/view/screen/pageone.dart';
import 'package:provider/provider.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'view/screen/client/homepage/map.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(AuthController()));

   await initialServices();
  runApp( MyApp());
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
      theme:ThemeService().lightTheme,
      darkTheme: ThemeService().darkTheme, 
      themeMode: ThemeService().getThemeMode(),
      home:  PageOne(),
      getPages: routes
    );
  }
}

