import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveThemeToBox(bool isDarkMode)=> _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}

// import 'class_theme.dart';
//
//
// class ThemeProvider with ChangeNotifier{
//   ThemeData _themeData = lightMode;
//   ThemeData get themeData => _themeData;
//
//   set themeData(ThemeData themeData){
//     _themeData = themeData;
//     notifyListeners();
//   }
//   void toggleTheme(){
//     if(_themeData==lightMode){
//       themeData = darkMode;
//     }else{
//       themeData = lightMode;
//     }
//   }
// }
