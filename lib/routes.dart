
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:karhabti_pfe/view/screen/auth/login.dart';
import 'package:karhabti_pfe/view/screen/auth/logintech.dart';
import 'package:karhabti_pfe/view/screen/auth/signup.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/buttombar/profil/editprofil.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/homepage.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/homescreen.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/localisation.dart';
import 'package:karhabti_pfe/view/screen/client/onboarding.dart';
import 'package:karhabti_pfe/view/screen/client/homepage/panne.dart';
import 'package:karhabti_pfe/view/screen/technicien/onboarding2.dart';
import 'package:karhabti_pfe/view/screen/technicien/signuporlogin2.dart';
import 'package:karhabti_pfe/view/screen/technicien/venteachat.dart';
import 'view/screen/auth/signuptech.dart';
import 'view/screen/client/homepage/postulation.dart';
import 'view/screen/technicien/hometechpage.dart';
import 'view/screen/client/signuporligin.dart';
List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.login, page: ()=>Login()),
  GetPage(name: AppRoute.logintech, page: ()=>LoginTech()),
  GetPage(name: AppRoute.signup, page: ()=>SignUp()),
  GetPage(name: AppRoute.signuptech, page: ()=>SignUpTech()),
  GetPage(name: AppRoute.signuporlogin, page: ()=>SignUpOrLogin()),
  GetPage(name: AppRoute.signuporlogin2, page: ()=>SignUpOrLogin2()),
  GetPage(name: AppRoute.home, page: ()=>HomePage()),
  GetPage(name: AppRoute.homescreen, page: ()=>HomeScreen()),
  GetPage(name: AppRoute.hometech, page: ()=>HomeTechPage()),
  GetPage(name: AppRoute.onBoarding, page: ()=>OnBoarding()),
  GetPage(name: AppRoute.onBoarding2, page: ()=>OnBoarding2()),
  GetPage(name: AppRoute.panne, page: ()=>Panne()),
  GetPage(name: AppRoute.venteachat, page: ()=>VenteAchat()),
  GetPage(name: AppRoute.loc, page: ()=>Localisezvous()),
  GetPage(name: AppRoute.post, page: ()=>Postulation()),
  GetPage(name: AppRoute.edit, page: ()=>EditProfil()),
 


];
