import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karhabti_pfe/core/constant/color.dart';

class ThemeService{
  final lightTheme = ThemeData.light().copyWith(
    backgroundColor: ColorApp.backgrounddark,
    primaryColor: ColorApp.white,
    dividerColor: ColorApp.grey,
    );

    
  
  final darkTheme= ThemeData.dark().copyWith(
backgroundColor: Color.fromARGB(255, 135, 117, 200),
    primaryColor: Color.fromARGB(255, 93, 71, 71),
    dividerColor: Color.fromARGB(255, 209, 168, 168),
    );





  final _getStorage = GetStorage() ;
  final _darkThemeKey = ('isDarkTheme') ;

  void saveThemeData(bool isDarkMode){
    _getStorage.write(_darkThemeKey , isDarkMode);
  }

bool isSavedDarkMode(){
  return _getStorage.read(_darkThemeKey) ?? false;
}
 ThemeMode getThemeMode(){
  return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
 }

 void chageTheme(){
   Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
   saveThemeData(!isSavedDarkMode());
 } 
}