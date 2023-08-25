import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hello_mdfk/smallcard.dart';
import 'package:hello_mdfk/state/appthemestate.dart';
import 'package:hello_mdfk/state/myappstate.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    String inputText = 'init';
    final inputTextController = TextEditingController();

    inputTextController.addListener(() {
      inputText = inputTextController.text;
      inputListener(inputTextController.text);
    });

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      // Column 為垂直擺放
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 自訂元件
          BigCard(pair: pair),
          const SizedBox(height: 10),
          // 抽出另外寫
          SmallCard(pair: pair),
          const SizedBox(height: 10),
          // Row 為水平擺放
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ElevatedButton.icon 帶 icon 生成有背景按鈕
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: const Text('Like'),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              // ElevatedButton 有背景按鈕
              ElevatedButton(
                // onPressed 處理
                onPressed: () {
                  appState.getNext();
                },
                child: const Text('Next'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            // 監聽用
            controller: inputTextController,
            // password 打開
            obscureText: false,
            // InputDecoration 外觀設定
            decoration: const InputDecoration(
              // filled 是否以淺色填滿背景, 應該是吃 theme?
              filled: true,
              // labelText focus 時會往上移動懸浮, 不會消失
              labelText: 'This line will show on top when focus',
              // hint 提示
              hintText: 'Type new word here!',
            ),
          ),
          // SizedBox 做間隔用
          const SizedBox(height: 10),
          // 水平排列
          OverflowBar(children: [
            // TextButton 文字按鈕
            TextButton(
                onPressed: () {
                  onPressed(appState, inputTextController.text);
                },
                child: const Text('Add to Favorite')),
            ElevatedButton(
                onPressed: () {
                  // 換紅色主題
                  Provider.of<ThemeState>(context, listen: false)
                      .setTheme('red');
                  // 清除
                  inputTextController.clear();
                  // 有 navigator 的話可用
                  // Navigator.pop(context);
                },
                child: const Text('clear')),
          ]),
          // SizedBox 做間隔用
          const SizedBox(height: 10),
          Consumer<MyAppState>(builder: (_, appState, child) {
            return Text(inputText);
          }),
          Text(inputText),
        ],
      ),
    );
  }

  // onPressed 拆出來寫
  void onPressed(MyAppState state, String txt) {
    // todo add to favorite handler
    state.addFavorite(txt);
  }

  void inputListener(String txt) {
    dev.log(txt);
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(
          color: _myAppTheme.primaryColorDark,
          // theme.colorScheme.onPrimary,
        )
        .apply(
          fontFamily: 'Rubik',
        );

    return Card(
      elevation: 8,
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

// 自定義主題樣式
final ThemeData _myAppTheme = _testTheme;

final ThemeData _testTheme = ThemeData(
  primaryColorLight: const Color(0xFF00296B),
  primaryColorDark: const Color(0xFFB1CFF5),
);
