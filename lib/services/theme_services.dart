
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeService{
  final _box = GetStorage();
  final _Key = 'isDarkMode';
  _saveThemeToBox(bool isDarkMode)=>_box.write(_Key, isDarkMode);
  bool _loadThemeFromBox()=>_box.read(_Key)??false;
  ThemeMode get theme=>_loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;
  void switchTheme(){
    Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.light:ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}