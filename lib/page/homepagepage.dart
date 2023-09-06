import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:hello_mdfk/model/playlists.dart';
import 'package:hello_mdfk/page/adaptivepage.dart';
import 'package:hello_mdfk/page/bordersamplepage.dart';
import 'package:hello_mdfk/page/changethemepage.dart';
import 'package:hello_mdfk/page/shoppage.dart';
import 'favoritespage.dart';
import 'generatorpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 帶底線為 private
class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const GeneratorPage();
        break;
      case 1:
        page = const FavoritesPage();
        break;
      case 2:
        page = const ShopPage();
        break;
      case 3:
        page = const ChangeThemePage();
        break;
      case 4:
        page = const BorderSamplePage();
        break;
      case 5:
        page = const AdaptivePage();
        break;
      case 6:
        page = const Playlists();
        break;
      case 99:
        // Placeholder: 这是一个便捷易用的 widget，可以在其放置地方绘制一个交叉矩形，以便将界面的该部分标记为未完成
        page = const Placeholder();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    // LayoutBuilder 可以印出 constraints, 方便 debug
    return LayoutBuilder(builder: (context, constraints) {
      // 基於 Material Design 的 骨架 Widget
      return Scaffold(
        // 确保键盘的外观不会更改首页或其元件的大小
        resizeToAvoidBottomInset: false,
        body: Row(
          children: [
            SafeArea(
              // NavigationRail 導航欄
              child: NavigationRail(
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                // const Color.fromARGB(22, 210, 128, 222),
                // 是否可以展開
                extended: constraints.maxWidth >= 600,
                // 導航項目 items
                destinations: const [
                  NavigationRailDestination(
                    // 項目 icon
                    icon: Icon(Icons.home),
                    // 被選中後顯示 icon
                    selectedIcon: Icon(Icons.home_filled),
                    // 項目標題
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.shopify),
                    label: Text('Shop'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.qr_code_rounded),
                    label: Text('Theme'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.account_circle),
                    label: Text('Border'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.add_to_queue),
                    label: Text('Adaptive'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.list_rounded),
                    label: Text('PlayList'),
                  ),
                ],
                // 目前 index
                selectedIndex: selectedIndex,
                // index 選中處理
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            // 自適應填滿可用空間
            Expanded(
              // 權重
              flex: 1,
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
