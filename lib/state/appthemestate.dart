import 'package:flutter/material.dart';

// 主題顏色管理
class ThemeState extends ChangeNotifier {
  // 預設藍色
  String _themeColor = 'blue';
  String get themeColor => _themeColor;

  setTheme(String themeColor) {
    _themeColor = themeColor;
    notifyListeners();
  }
}
