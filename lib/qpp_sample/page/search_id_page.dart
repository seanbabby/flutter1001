import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_mdfk/qpp_sample/page/commodity_info_page.dart';

class SearchCommodityIDPage extends StatelessWidget {
  const SearchCommodityIDPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inputTextController = TextEditingController();

    var _id = 0;

    inputTextController.addListener(() {
      // inputText = inputTextController.text;
      // inputListener(inputTextController.text);
      RegExp reg = RegExp(r'\d{6}');

      if (reg.hasMatch(inputTextController.text)) {
        _id = int.parse(inputTextController.text);
      }
    });

    return Expanded(
      child: Scaffold(
        body: Column(children: [
          const SizedBox(
            height: 15,
          ),
          // 文字輸入框
          Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: TextField(
              // 監聽用
              controller: inputTextController,
              keyboardType: TextInputType.number,
              // password 打開
              obscureText: false,
              // InputDecoration 外觀設定
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5.0, color: Colors.white),
                ),
                // filled 是否以淺色填滿背景
                filled: true,
                // labelText focus 時會往上移動懸浮, 不會消失
                labelText: '輸入要查詢的物品ID',
                // hint 提示
                hintText: 'Type search commodity id here!',
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () => {
                    // todo 跳頁開始查詢
                    Navigator.push(
                        context, CommodityInfoPage(_id) as Route<Object?>)
                  },
              child: const Text('Search')),
        ]),
      ),
    );
  }

  @override
  Route createRoute(BuildContext context) {
    // TODO: implement createRoute
    throw UnimplementedError();
  }
}
