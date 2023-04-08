
import 'package:flutter/cupertino.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:karhabti_pfe/view/screen/auth/login.dart';
import 'package:karhabti_pfe/view/screen/auth/logintech.dart';
import 'package:karhabti_pfe/view/screen/auth/signup.dart';
import 'package:karhabti_pfe/view/screen/home/homepage.dart';
import 'package:karhabti_pfe/view/screen/onboarding.dart';
import 'package:karhabti_pfe/view/screen/onboarding2.dart';
import 'package:karhabti_pfe/view/screen/signuporlogin2.dart';

import 'view/screen/auth/signuptech.dart';
import 'view/screen/home/hometechpage.dart';
import 'view/screen/signuporligin.dart';

Map<String, Widget Function(BuildContext)>routes = {
 AppRoute.login : (context) =>   Login(),
 AppRoute.logintech : (context) =>   LoginTech(),
 AppRoute.signup : (context) =>   SignUp(),
 AppRoute.signuptech : (context) =>   SignUpTech(),
 AppRoute.signuporlogin :(context) => SignUpOrLogin(),
 AppRoute.signuporlogin2 :(context) => SignUpOrLogin2(),
 AppRoute.home : (context) =>   HomePage(),
 AppRoute.hometech : (context) =>   HomeTechPage(),
 AppRoute.onBoarding : (context) =>   OnBoarding(),
 AppRoute.onBoarding2 : (context) =>   OnBoarding2(),
};