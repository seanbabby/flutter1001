import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/photoslibrary/v1.dart';
import 'package:hello_mdfk/qpp_sample/page/commodity_info_page.dart';
import 'package:http/http.dart' as http;

Provider<String> commodityInfoUrlProvider = Provider((ref) {
  return 'https://qpptec.com/app/commodity_info?commodityID=109555&sharer=SUV5G42V&lang=zh_TW&openExternalBrowser=1&action=stay';
});

class SearchCommodityIDPage extends StatelessWidget {
  const SearchCommodityIDPage({super.key});

  void _getItem() async {
    // Flutter Web 项目网络请求报 XMLHttpRequest error 解决方案 https://www.jianshu.com/p/70713858fdb3
    try {
      final response = await http.post(
        Uri.parse('https://dev2-api.qpptec.com/client/ItemSelect'),
        body: json.encode({
          'itemIds': [
            109555,
          ]
        }),
        // Send authorization headers to the backend.
        headers: {
          HttpHeaders.acceptHeader: '*/*',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Object a = jsonDecode(response.body);
        print(response.statusCode.toString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputTextController = TextEditingController();

    var _id = 0;

    inputTextController.addListener(() {
      // inputText = inputTextController.text;
      // inputListener(inputTextController.text);
      // RegExp reg = RegExp(r'\d{6}');

      // if (reg.hasMatch(inputTextController.text)) {
      //   _id = int.parse(inputTextController.text);
      // }
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
                    _getItem()
                    // todo 跳頁開始查詢
                    // Navigator.push(
                    //     context, CommodityInfoPage(_id) as Route<Object?>)
                  },
              child: const Text('Search')),
          const SizedBox(
            height: 15,
          ),
          PrintInput(),
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

class PrintInput extends ConsumerWidget {
  const PrintInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String text = ref.watch(commodityInfoUrlProvider);

    return Text(text);
  }
}
