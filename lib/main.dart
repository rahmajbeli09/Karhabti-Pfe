import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/routes.dart';
import 'package:karhabti_pfe/view/screen/auth/login.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/panne/localisation.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/panne/panne.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/panne/profilelistech.dart';
import 'package:karhabti_pfe/view/screen/pageone.dart';
import 'package:karhabti_pfe/view/screen/technicien/home/buttombar/messagetech.dart';
import 'package:karhabti_pfe/controller/auth/authcontroller.dart';
import 'package:karhabti_pfe/view/screen/technicien/home/buttombar/hometechpage.dart';
import 'package:karhabti_pfe/view/screen/technicien/home/hometechscreen.dart';
import 'package:karhabti_pfe/view/screen/technicien/signuporlogin2.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'core/services/services.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/frais.dart';
import 'view/screen/auth/resetpassword.dart';
import 'view/screen/client/homepage/panne/liste.dart';
import 'view/screen/client/homepage/panne/messagepanne.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future <void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(AuthController()));
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await initialServices();
  // configureFirebaseMessaging(); // Configure Firebase Messaging
  // requestNotificationPermissions(); // Request notification permissions
  
  runApp(MyApp());
}


// void configureFirebaseMessaging() {
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print("Received message");
//     // Handle the received message
//   });
  
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     print('OnMessageOpenedApp: ${message.notification!.title}');
//     // Handle notification selection here
//     // You can navigate to a specific screen or perform any desired action
//   });
// }

// void requestNotificationPermissions() async {
//   NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   print('User granted permission: ${settings.authorizationStatus}');
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      locale: controller.language,
      home: PageOne(),
      getPages: routes,
    );
  }
}