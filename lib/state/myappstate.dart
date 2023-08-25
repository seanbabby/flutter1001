import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';

// 喜愛狀態字串管理
class MyAppState extends ChangeNotifier {
  // WordPair 測試數據用, 隨機生成兩個單字組成的pair
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void addFavorite(String str) {
    var type = WordPair(str, 'type');
    if (!favorites.contains(type)) {
      favorites.add(type);
    }
    notifyListeners();
  }
}
