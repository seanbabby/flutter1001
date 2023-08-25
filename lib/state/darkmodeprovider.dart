import 'package:flutter/material.dart';

// 深色模式監聽
class DarkModeProvider with ChangeNotifier {
  // 0:關閉, 1:開啟, 2:系統設定
  int _darkMode = 2;

  int get darkMode => _darkMode;

  void setDarkMode(int darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}
