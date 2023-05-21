import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';
import 'buttombar/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class NotificationsServices{
 final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
   const AndroidInitializationSettings('@mipmap/logo');

   void initialiseNotifications() async{
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
   }
 
  void initInfo() async {
     var androidInitialize = const AndroidInitializationSettings('@mipmap/logo');
    var initializationSettings = InitializationSettings(android: androidInitialize);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
      try {
        if (payload != null && payload.isNotEmpty) {
        //  Get.to(() => Notifications(info: payload));
         Get.to(() => Notifications(info: payload));
        } else {
          Get.to(() => Notifications(info: '',));
        }
      } catch (e) {
        return;
      }
    });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print(".............onMessage...............");
    print("onMessage: ${message.notification?.title}/${message.notification?.body}}");

    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title.toString(),
      htmlFormatContentTitle: true,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'karhabti',
      'karhabti',
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
    );

    NotificationDetails PlatformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(0, message.notification?.title, message.notification?.body, PlatformChannelSpecifics, payload: message.data['body']);
  });
} //it's not working 

  void sendNotification(String title, String body, String payload) async {
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'karhabti',
    'karhabti',
    importance: Importance.high,
    priority: Priority.high,
  );
  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );
  await _flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
    payload: payload,
  );
}

void scheduleNotification(String title, String body, DateTime notificationDate) async {
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'karhabti',
    'karhabti',
    importance: Importance.high,
    priority: Priority.high,
  );
  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  DateTime scheduledDate = notificationDate.subtract(const Duration(days: 3));

  // If the scheduled date is in the past, use the current date and time instead
  if (scheduledDate.isBefore(DateTime.now())) {
    scheduledDate = DateTime.now();
  }

  tz.initializeTimeZones(); // Initialize the time zone database

  _flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    tz.TZDateTime.from(scheduledDate, tz.local),
    notificationDetails,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

}
 //  void sendNotification(String title, String body) async {
  //   AndroidNotificationDetails androidNotificationDetails =AndroidNotificationDetails(
  //   'karhabti',
  //   'karhabti',
  //     importance: Importance.high,
  //     priority: Priority.high);
  //   NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //    title,
  //     body,
  //      notificationDetails);
  //  }

// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:karhabti_pfe/view/screen/client/homepage/notif_service.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:karhabti_pfe/view/widget/boutton.dart';
// import 'package:karhabti_pfe/view/widget/home/fraistextformfiled.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import '../../../../controller/auth/authcontroller.dart';
// import '../../../../controller/client/fraiscontroller.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:intl/intl.dart'; // For formatting the selected date
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http ;

// import 'buttombar/notification.dart';

// class Frais extends StatefulWidget {
//   Frais({Key? key}) : super(key: key);

//   @override
//   _FraisState createState() => _FraisState();
// }

// class _FraisState extends State<Frais> {
//  // final authController = Get.find<AuthController>;
//     late DateTime assuranceDate;
//   late DateTime vignetteDate;
//   late DateTime visiteDate;
//   FraisControllerImp controller = Get.put(FraisControllerImp());
//   final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
//       TextEditingController assuranceController = TextEditingController();
//     TextEditingController vignetteController = TextEditingController();
//     TextEditingController visiteController = TextEditingController();
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// String? mtoken = " ";
// NotificationsServices notificationsServices = NotificationsServices();
//   @override

//   void initState() {
//     super.initState();
//     requestPermissions();
//     getToken();
//     notificationsServices.initialiseNotifications();
//     //initInfo();
//     // fetchFraisData();
//   }
// //  void fetchFraisData() async {
// //     DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("frais").doc("your_document_id").get();
// //     if (snapshot.exists) {
// //       Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
// //       if (data != null) {
// //         assuranceDate = dateFormat.parse(data['assurance']);
// //         vignetteDate = dateFormat.parse(data['vignette']);
// //         visiteDate = dateFormat.parse(data['visite']);
// //         assuranceController.text = dateFormat.format(assuranceDate);
// //         vignetteController.text = dateFormat.format(vignetteDate);
// //         visiteController.text = dateFormat.format(visiteDate);
// //       }
// //     }
// //   }
// // initInfo() async {
// //   var androidInitialize = const AndroidInitializationSettings('@mipmap/logo');
// //   var initializationSettings = InitializationSettings(android: androidInitialize);
// //   await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
// //     try {
// //       if (payload != null && payload.isNotEmpty) {
// //         Get.to(() => Notifications(info: payload.toString()));
// //       } else {
// //         // Handle notification tap logic when no payload is available
// //       }
// //     } catch (e) {
// //       return;
// //     }
// //   });

// //   // Listening to Firebase messages
// //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
// //     print(".............onMessage...............");
// //     print("onMessage: ${message.notification?.title}/${message.notification?.body}}");

// //     // Show the received notification
// //     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
// //       message.notification!.body.toString(),
// //       htmlFormatBigText: true,
// //       contentTitle: message.notification!.title.toString(),
// //       htmlFormatContentTitle: true,
// //     );
// //     AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
// //       'karhabti',
// //       'karhabti',
// //       importance: Importance.high,
// //       styleInformation: bigTextStyleInformation,
// //       priority: Priority.high,
// //       playSound: true,
// //     );
// //     NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
// //     await flutterLocalNotificationsPlugin.show(0, message.notification?.title, message.notification?.body, platformChannelSpecifics, payload: message.data['body']);

// //     // Schedule notifications if the message indicates a reminder
// //     String? reminderType = message.data['reminderType'];
// //     if (reminderType != null && reminderType.isNotEmpty) {
// //       DateTime targetDate = DateTime.parse(message.data['targetDate']);
// //       DateTime notificationDate = targetDate.subtract(const Duration(days: 3));

// //       if (reminderType == 'Assurance') {
// //         scheduleNotification('Assurance Reminder', 'Your automobile insurance is expiring in 3 days!', notificationDate);
// //       } else if (reminderType == 'Vignette') {
// //         scheduleNotification('Vignette Reminder', 'Your vignette is expiring in 3 days!', notificationDate);
// //       } else if (reminderType == 'VisiteTechnique') {
// //         scheduleNotification('Visite Technique Reminder', 'Your vehicle needs a technical inspection in 3 days!', notificationDate);
// //       }
// //     }
// //   });
// // }

// //    initInfo() async {
// //     var androidInitialize = const AndroidInitializationSettings('@mipmap/logo');
// //     // var iOSInitialize = const notifications.IOSInitializationSettings();

// //     var initializationSettings = InitializationSettings(android: androidInitialize);//, iOS: iOSInitialize
// //     await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
// //       try {
// //         if (payload != null && payload.isNotEmpty) {
// //            Get.to(() => Notifications(info: payload.toString()));
// //         } else {
// //         }
// //       } catch (e) {
// //         return;
// //       }
// //     });
// //     //listening to firebase messages
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) async{ 
// //       print(".............onMessage...............");

// // print("onMessage: ${message.notification?.title}/${message.notification?.body}}");
// // //this code is responsible for showing the notification on the phone
// // BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(

// // message.notification!.body.toString(), htmlFormatBigText: true, 
// // contentTitle: message.notification!.title.toString(), htmlFormatContentTitle: true,

// // );
// // AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(

// // 'karhabti', 'karhabti', importance: Importance.high,

// // styleInformation: bigTextStyleInformation, priority: Priority.high, playSound: true, 
// // // sound: RowResourceAndroidNotificationSound('notification'),
// // );
// // NotificationDetails PlatformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
// // await flutterLocalNotificationsPlugin.show(0, message.notification?.title, message.notification?.body, 
// // PlatformChannelSpecifics,
// // payload: message.data['body']);
// // });
// //   }
  

// void getToken() async{
//   await FirebaseMessaging.instance.getToken().then(
//     (token) {
//     setState((){
//     mtoken = token;
//     print("My token is $mtoken");
//     saveToken(mtoken!); 
//     });
//   });
// }
// void saveToken(String token) async {
//   Map<String, dynamic> data = {
//     "token": token,
//     "timestamp": DateTime.now().toUtc().toString()
//   };

//   await FirebaseFirestore.instance
//       .collection("frais")
//       .doc()
//       .set(data)
//       .then((value) => print("Token saved successfully"))
//       .catchError((error) => print("Failed to save token: $error"));
// }
//   void requestPermissions() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
// // void sendPushMessage(String token, String titleText, String titleBody) async {
// //   print('Token of sendPushMsg is $token');

// //   // Check if the target date is before the provided dates
// //   //if (targetDate.isBefore(assuranceDate) || targetDate.isBefore(visiteDate) || targetDate.isBefore(vignetteDate)) {
// //     try {
// //       await http.post(
// //         Uri.parse('https://fcm.googleapis.com/fcm/send'),
// //         headers: <String, String>{
// //           'Content-Type': 'application/json',
// //           'Authorization': 'key=AAAA-P0m5jk:APA91bFT9_YpOCitidmT2azS7_f4Cxy0ILzVAzAu__iuw_asPrO93PdpGqDrWEEHuYJRiQxuPDZ_ydfSA6HXgM7a7uPUGMrQx8v4-wGT3y8FIoyrxZZNOnvHADXfnM07NlWT9hJ34FVh',
// //         },
// //         body: jsonEncode(
// //           <String, dynamic>{
// //             'priority': 'high',
// //             'data': <String, dynamic>{
// //               'click_action': 'FLUTTER_NOTIFICATION_CLICK',
// //               'status': 'done',
// //               'body': titleBody,
// //               'title': titleText,
// //             },
// //             "notification": <String, dynamic>{
// //               "body": titleBody,
// //               "title": titleText,
// //               "android_channel_id": "karhabti"
// //             },
// //             "to": token,
// //           },
// //         ),
// //       );
// //     } catch (e) {
// //       if (kDebugMode) {
// //         print("Error sending push notification: $e");
// //       }
// //     }
  
// // }

// // void scheduleNotification(
// //     String title, String body, DateTime notificationDate) async {
// //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
// //       AndroidNotificationDetails(
// //     'karhabti',
// //     'karhabti',
// //     channelDescription: 'Channel for karhabti notifications',
// //     importance: Importance.high,
// //     priority: Priority.high,
// //     playSound: true,
// //   );

// //   final NotificationDetails platformChannelSpecifics =
// //       NotificationDetails(android: androidPlatformChannelSpecifics);

// //   DateTime scheduledDate;

// //   if (notificationDate.isBefore(DateTime(2023, 5, 25))) {
// //     // Send notification immediately
// //     scheduledDate = DateTime.now();
// //   } else {
// //     // Send notification three days before the provided date
// //     scheduledDate = notificationDate.subtract(const Duration(days: 3));
// //   }

// //   await flutterLocalNotificationsPlugin.zonedSchedule(
// //     0,
// //     title,
// //     body,
// //     tz.TZDateTime.from(scheduledDate, tz.local),
// //     platformChannelSpecifics,
// //     androidAllowWhileIdle: true,
// //     uiLocalNotificationDateInterpretation:
// //         UILocalNotificationDateInterpretation.absoluteTime,
// //     matchDateTimeComponents: DateTimeComponents.time,
// //   );
// // }


// // void scheduleNotifications(String token, String titleText, String bodyText) async {
// //   if (token ==
// //       "cAGExdaeSxO8zdz2wb66xM:APA91bF3zBTxOvxoxbop5tBPxung0GCo6KkLsSme3hYIT-IMx9x2jcyD6TnMR2_DsP3EzE_-Ee0CkjqaOiQhRB5nyvx9vs842_O0cM3bIJ4DXcToszyKhKR8sf0cZfoyi446LU0tZQ_X") {
// //     print("schedule notification accessed to the token ");
// //   }

// //   final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
// //       .collection('frais')
// //       .where('userId', isEqualTo: '5ACMr01rdCLoyzUB4V6J')
// //       .limit(1)
// //       .get();

// //   if (querySnapshot.size > 0) {
// //     final DocumentSnapshot fraisDocument = querySnapshot.docs.first;

// //     final DateTime assuranceDate =
// //         (fraisDocument.data() as Map<String, dynamic>)['assurance'].toDate();
// //     final DateTime vignetteDate =
// //         (fraisDocument.data() as Map<String, dynamic>)['vignette'].toDate();
// //     final DateTime visiteDate =
// //         (fraisDocument.data() as Map<String, dynamic>)['visite'].toDate();

// //     print("Assurance Date: $assuranceDate");
// //     print("Vignette Date: $vignetteDate");
// //     print("Visite Date: $visiteDate");

// //     final DateTime currentDate = DateTime.now();
// //     final DateTime assuranceNotificationDate =
// //         assuranceDate.subtract(const Duration(days: 3));
// //     final DateTime vignetteNotificationDate =
// //         vignetteDate.subtract(const Duration(days: 3));
// //     final DateTime visiteNotificationDate =
// //         visiteDate.subtract(const Duration(days: 3));

// //     if (assuranceNotificationDate.isAtSameMomentAs(currentDate)) {
// //       scheduleNotification(
// //         'Assurance Reminder',
// //         'Your automobile insurance is expiring today!',
// //         assuranceNotificationDate,
// //       );
// //       sendPushMessage(
// //           token, 'Assurance Reminder', 'Your automobile insurance is expiring today!');
// //     }

// //     if (vignetteNotificationDate.isAtSameMomentAs(currentDate)) {
// //       scheduleNotification(
// //         'Vignette Reminder',
// //         'Your vignette is expiring today!',
// //         vignetteNotificationDate,
// //       );
// //       sendPushMessage(token, 'Vignette Reminder', 'Your vignette is expiring today!');
// //     }

// //     if (visiteNotificationDate.isAtSameMomentAs(currentDate)) {
// //       scheduleNotification(
// //         'Visite Technique Reminder',
// //         'Your vehicle needs a technical inspection today!',
// //         visiteNotificationDate,
// //       );
// //       sendPushMessage(
// //           token, 'Visite Technique Reminder', 'Your vehicle needs a technical inspection today!');
// //     }
// //   } else {
// //     print('No matching frais documents found');
// //   }
// // }


// // Call the scheduleNotifications method to trigger the scheduling of notifications




//   @override
//   Widget build(BuildContext context) {
    
    
//     TextEditingController assuranceController = TextEditingController();
//     TextEditingController vignetteController = TextEditingController();
//     TextEditingController visiteController = TextEditingController();
    
// // Function to retrieve document from the 'frais' collection based on userId
// Future<DocumentSnapshot?> getFraisDocument(String userId) async {
//   final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//     .collection('frais')
//     .where('userId', isEqualTo: userId)
//     .limit(1)
//     .get();

//   if (querySnapshot.docs.isNotEmpty) {
//     return querySnapshot.docs.first;
//   } else {
//     return null; // Return null if document not found
//   }
// }

//     void showSnackbar() {
//       final snackBar = SnackBar(
//         content: Text('Frais data saved successfully! We will notify you when you need to renew your papers'),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }

//     void saveFormData() {
//       final DateTime assuranceValue = dateFormat.parse(assuranceController.text);
//       final DateTime vignetteValue = dateFormat.parse(vignetteController.text);
//       final DateTime visiteValue = dateFormat.parse(visiteController.text);

//       controller.saveFraisData(assuranceValue, vignetteValue, visiteValue);
//     }

//     Future<void> showDatePickerDialog(TextEditingController controller) async {
//       final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(DateTime.now().year),
//         lastDate: DateTime(DateTime.now().year + 10),
//       );

//       if (pickedDate != null) {
//         String formattedDate = dateFormat.format(pickedDate);
//         controller.text = formattedDate;
//       }
//     }


//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         centerTitle: true,
//         title: Text(
//           "Suivre l'échéance de papiers",
//           style: TextStyle(
//             color: Colors.black,
//             fontFamily: "Comfortaa",
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white.withAlpha(0),
//       ),
//       body: Container(
//         margin: EdgeInsets.symmetric(horizontal: 15),
//         child: Form(
//           child: ListView(
//             children: [
//               Image.asset(
//                 "assets/images/frais2.png",
//                 height: 200,
//               ),
//               Text(
//                 "Suivez vos paiements en temps réel et recevez des notifications instantanées pour ne jamais manquer une facture",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15,
//                   fontFamily: "Comfortaa",
//                 ),
//               ),
//               SizedBox(height: 40),
//               FraisTextFormFiled(
//                 controller: assuranceController,
//                 text: "Date d'échéance de l'assurance automobile",
//                 onTap: () {
//                   showDatePickerDialog(assuranceController);
//                 },
//               ),
//               FraisTextFormFiled(
//                 controller: vignetteController,
//                 text: "Date d'expiration de la vignette",
//                 onTap: () {
//                   showDatePickerDialog(vignetteController);
//                 },
//               ),
//               FraisTextFormFiled(
//                 controller: visiteController,
//                 text: "Date de la prochaine visite technique",
//                 onTap: () {
//                   showDatePickerDialog(visiteController);
//                 },
//               ),

// Boutton(
//   text: "Sauvegarder",
//   color: Color.fromARGB(255, 255, 203, 30),
//   onPressed: () async {
//        String userId = '5ACMr01rdCLoyzUB4V6J';
//     String titleText = "Vous devez renouveler vos papiers de voitures";
//      String bodyText = "Selon les dates que vous avez fournies, l'un de vos papiers doit être renouvelé";
//  // Retrieve the document using the getFraisDocument function
//     final DocumentSnapshot<Object?>? fraisDocument = await getFraisDocument(userId);
//     // final CollectionReference fraisCollection = FirebaseFirestore.instance.collection('frais');
//     // final DocumentSnapshot documentSnapshot = await fraisCollection.doc().get();
// String token = 'cAGExdaeSxO8zdz2wb66xM:APA91bF3zBTxOvxoxbop5tBPxung0GCo6KkLsSme3hYIT-IMx9x2jcyD6TnMR2_DsP3EzE_-Ee0CkjqaOiQhRB5nyvx9vs842_O0cM3bIJ4DXcToszyKhKR8sf0cZfoyi446LU0tZQ_X';

//    if (fraisDocument != null) {
//       String token = fraisDocument['token'];
//       print("Token: $token");
//      //sendPushMessage(mtoken!, titleText, bodyText);
//   // scheduleNotifications('cAGExdaeSxO8zdz2wb66xM:APA91bF3zBTxOvxoxbop5tBPxung0GCo6KkLsSme3hYIT-IMx9x2jcyD6TnMR2_DsP3EzE_-Ee0CkjqaOiQhRB5nyvx9vs842_O0cM3bIJ4DXcToszyKhKR8sf0cZfoyi446LU0tZQ_X', 'Notification Title', 'Notification Body');
//       //scheduleNotifications(token, titleText, bodyText);
//       //notificationsServices.sendNotification("testing","body test");
//      // notificationsServices.scheduleNotification("scheduled notification","body test");
//     } else {
//       print("Document does not exist btn");
//     }
      
//       saveFormData();
//       showSnackbar();

//   },
// ),


//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }