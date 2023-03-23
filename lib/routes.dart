
import 'package:flutter/cupertino.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:karhabti_pfe/view/screen/auth/login.dart';
import 'package:karhabti_pfe/view/screen/auth/signup.dart';
import 'package:karhabti_pfe/view/screen/home/homepage.dart';

import 'view/screen/signuporligin.dart';

Map<String, Widget Function(BuildContext)>routes = {
 AppRoute.login : (context) =>   Login(),
 AppRoute.signup : (context) =>   SignUp(),
 AppRoute.signuporlogin :(context) => SignUpOrLogin(),
 AppRoute.home : (context) =>   HomePage(),
};