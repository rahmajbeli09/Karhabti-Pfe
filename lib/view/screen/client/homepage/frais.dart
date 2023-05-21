import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/notif_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/boutton.dart';
import 'package:karhabti_pfe/view/widget/home/fraistextformfiled.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../controller/auth/authcontroller.dart';
import '../../../../controller/client/fraiscontroller.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart'; // For formatting the selected date
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http ;

import '../../../../repository/user_repository/user_repository.dart';
import '../../../../services/user_model.dart';
import 'buttombar/notification.dart';

class Frais extends StatefulWidget {
  Frais({Key? key}) : super(key: key);

  @override
  _FraisState createState() => _FraisState();
}

class _FraisState extends State<Frais> {
 // final authController = Get.find<AuthController>;
    late DateTime assuranceDate;
  late DateTime vignetteDate;
  late DateTime visiteDate;
  FraisControllerImp controller = Get.put(FraisControllerImp());
  UserRepository userRepository = Get.put(UserRepository());
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    TextEditingController assuranceController = TextEditingController();
    TextEditingController vignetteController = TextEditingController();
    TextEditingController visiteController = TextEditingController();
 // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
String? mtoken = " ";
NotificationsServices notificationsServices = NotificationsServices();


  @override

  void initState() {
    super.initState();
    requestPermissions();
    getToken();
    notificationsServices.initialiseNotifications();
    notificationsServices.initInfo();
    //notificationsServices.initInfo();
    // fetchFraisData();
  }

  

void getToken() async{
  await FirebaseMessaging.instance.getToken().then(
    (token) {
    setState((){
    mtoken = token;
    print("My token is $mtoken");
    saveToken(mtoken!); 
    });
  });
}
void saveToken(String token) async {
  Map<String, dynamic> data = {
    "token": token,
    "timestamp": DateTime.now().toUtc().toString()
  };

  await FirebaseFirestore.instance
      .collection("frais")
      .doc()
      .set(data)
      .then((value) => print("Token saved successfully"))
      .catchError((error) => print("Failed to save token: $error"));
}
  void requestPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }


  @override
  Widget build(BuildContext context) {
    
    
    TextEditingController assuranceController = TextEditingController();
    TextEditingController vignetteController = TextEditingController();
    TextEditingController visiteController = TextEditingController();
    
// Function to retrieve document from the 'frais' collection based on userId
Future<DocumentSnapshot?> getFraisDocument(String userId) async {
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('frais')
    .where('userId', isEqualTo: userId)
    .limit(1)
    .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first;
  } else {
    return null; // Return null if document not found
  }
}

    void showSnackbar() {
      final snackBar = SnackBar(
        content: Text('Frais data saved successfully! We will notify you when you need to renew your papers'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

 void saveFormData() async {
  final UserRepository userRepository = Get.put(UserRepository());
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DateTime assuranceValue = dateFormat.parse(assuranceController.text);
  final DateTime vignetteValue = dateFormat.parse(vignetteController.text);
  final DateTime visiteValue = dateFormat.parse(visiteController.text);

  controller.saveFraisData(assuranceValue, vignetteValue, visiteValue);

  final NotificationsServices notificationsServices = NotificationsServices();
  notificationsServices.initialiseNotifications();

  final DateTime currentDate = DateTime.now();
  
  if (assuranceValue.difference(currentDate).inDays == 3) {
    final DateTime assuranceNotificationDate = assuranceValue.subtract(const Duration(days: 3));
    notificationsServices.sendNotification('Assurance Reminder', 'Your automobile insurance is expiring today!','assurance');
  }

  if (vignetteValue.difference(currentDate).inDays == 3) {
    final DateTime vignetteNotificationDate = vignetteValue.subtract(const Duration(days: 3));
    notificationsServices.sendNotification('Vignette Reminder', 'Your vignette is expiring today!','vignette');
  }

  if (visiteValue.difference(currentDate).inDays == 3) {
    final DateTime visiteNotificationDate = visiteValue.subtract(const Duration(days: 3));
    notificationsServices.sendNotification('Visite Technique Reminder', 'Your vehicle needs a technical inspection today!','visite');
   }
}



    Future<void> showDatePickerDialog(TextEditingController controller) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 10),
      );

      if (pickedDate != null) {
        String formattedDate = dateFormat.format(pickedDate);
        controller.text = formattedDate;
      }
    }


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          "Suivre l'échéance de papiers",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white.withAlpha(0),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          child: ListView(
            children: [
              Image.asset(
                "assets/images/frais2.png",
                height: 200,
              ),
              Text(
                "Suivez vos paiements en temps réel et recevez des notifications instantanées pour ne jamais manquer une facture",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  fontFamily: "Comfortaa",
                ),
              ),
              SizedBox(height: 40),
              FraisTextFormFiled(
                controller: assuranceController,
                text: "Date d'échéance de l'assurance automobile",
                onTap: () {
                  showDatePickerDialog(assuranceController);
                },
              ),
              FraisTextFormFiled(
                controller: vignetteController,
                text: "Date d'expiration de la vignette",
                onTap: () {
                  showDatePickerDialog(vignetteController);
                },
              ),
              FraisTextFormFiled(
                controller: visiteController,
                text: "Date de la prochaine visite technique",
                onTap: () {
                  showDatePickerDialog(visiteController);
                },
              ),

Boutton(
  text: "Sauvegarder",
  color: Color.fromARGB(255, 255, 203, 30),
  onPressed: () async {
    // Get the userId
    final User? currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      print('User not found!');
      return;
    }
    final String userEmail = currentUser.email!;

    final UserModel? user = await userRepository.getUserDetail(userEmail);
    if (user == null) {
      print('User not found!');
      return;
    }

    final String? userId = user.id;

    // Use the retrieved userId
    if (userId != null) {
      // Retrieve the document using the getFraisDocument function
      final DocumentSnapshot<Object?>? fraisDocument = await getFraisDocument(userId);

      if (fraisDocument != null) {
        String token = fraisDocument['token'];
        print("Token: $token");
      } else {
        print("Document does not exist for the token ");
      }

      saveFormData();
      showSnackbar();
    } else {
      print("User ID is null!");
    }
  },
),



            ],
          ),
        ),
      ),
    );
  }
}