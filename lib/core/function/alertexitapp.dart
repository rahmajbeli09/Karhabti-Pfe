import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/boutton.dart';

Future<bool> alertExitApp(){
   Get.defaultDialog(
    title: "attention",
    middleText: "est-ce-que vous voulez quitter" ,
    actions: [
      Boutton(text: "oui", color: Color.fromARGB(255, 255, 203, 30) , onPressed: (){exit(0);},),
     Boutton(text: "Non", color: Color.fromARGB(255, 255, 203, 30), onPressed: (){Get.back();},)
    ]
  );
  return Future.value(true);
}