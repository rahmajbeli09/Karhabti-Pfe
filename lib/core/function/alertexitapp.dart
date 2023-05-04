import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp(){
   Get.defaultDialog(
    title: "attention",
    middleText: "est-ce-que vous voulez quitter",
    actions: [
      ElevatedButton(onPressed: (){
        exit(0);
      }, child: Text("Oui")),
      ElevatedButton(onPressed: (){
        Get.back();
      }, child: Text("Non")),
    ]
  );
  return Future.value(true);
}