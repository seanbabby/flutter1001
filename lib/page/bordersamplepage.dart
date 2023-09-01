import 'package:flutter/material.dart';
// 參考來源
// https://cloud.tencent.com/developer/article/1942482 Flutter | 滚动组件，ListView，GridVIew等
// https://blog.wangruofeng007.com/posts/c5552f91/    Flutter ShapeBorder 使用手册

// ShapeBorder 用于设置形状和轮廓，比如圆形，矩形，圆角矩形等。常用于 Container 中。
class BorderSamplePage extends StatelessWidget {
  const BorderSamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('Border Sample'),
        ),
        // ListView 外面要包一個 Expanded, 否則不知道 ListView 高度會不顯示
        Expanded(
          child: _itemList(),
          //   ListView(
          // // ListView 少量時可以使用 children[], 項目較多時候請用 builder
          // children: [
          //   const Center(child: Text('一般型狀用 Border')),
          //   _beveledRectangleBorder(),
          //   _borderDirectional(),
          //   _borderDirectionalHorizon(),
          //   _circleBorder1(),
          //   _continuousRectangleBorder(),
          //   _roundedRectangleBorder(),
          //   _stadiumBorder(),
          //   const Center(child: Text('文字輸入用 Border')),
          //   _outlineInputBorder(),
          //   _underlineInputBorder()
          // ],
          // ),
        ),
      ],
    );
  }
}

// List builder sample
Widget _itemList() {
  // 有分隔元件的 builder
  return ListView.separated(
    // 一般 builder
    // return ListView.builder(
    // item 數量
    itemCount: 100,
    // 強制 item 高度
    //itemExtent: 0,
    // 物件是否緩存
    addAutomaticKeepAlives: true,
    // true 避免列表项不必要的重绘
    addRepaintBoundaries: true,
    itemBuilder: (context, index) {
      // return _outlineInputBorder();
      return _SampleItem();
    },
    separatorBuilder: (context, index) {
      return const Divider(
        // 這裡的高度是整個 Divider 的高度, 不是線的高度
        height: 50.0,
        // 線的高度
        thickness: 20.0,
        // 左邊縮排
        indent: 10.0,
        // 右邊縮排
        endIndent: 50.0,
        color: Colors.amber,
      );
    },
  );
}

// BeveledRectangleBorder 斜面圆角矩形
Widget _beveledRectangleBorder() {
  print('shape: 1');
  return Center(
    child: Container(
      width: 240,
      height: 120,
      margin: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/diamond.png'),
        ),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            width: 2,
            color: Colors.blue,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  );
}

// BorderDirectional 控制四邊的邊線
Widget _borderDirectional() {
  print('shape: 2');
  return Center(
    child: Container(
      width: 240,
      height: 120,
      margin: const EdgeInsets.all(16),
      decoration: const ShapeDecoration(
        image: DecorationImage(
          image: AssetImage('assets/diamond.png'),
        ),
        shape: BorderDirectional(
          start: BorderSide(color: Colors.black, width: 15),
          end: BorderSide(color: Colors.black, width: 15),
          top: BorderSide(
            color: Colors.black,
          ),
          bottom: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}

// BorderDirectional 只控制兩邊
Widget _borderDirectionalHorizon() {
  print('shape: 3');
  return Center(
    child: Container(
      width: 240,
      height: 120,
      margin: const EdgeInsets.all(16),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: BorderDirectional(
          start: BorderSide(color: Color.fromARGB(255, 12, 46, 98), width: 75),
          end: BorderSide(color: Colors.red, width: 75),
        ),
      ),
    ),
  );
}

// 圓形
Widget _circleBorder1() {
  print('shape: 4');
  return Center(
    child: Container(
      width: 120,
      height: 120,
      margin: const EdgeInsets.all(16),
      decoration: const ShapeDecoration(
        image: DecorationImage(
          image: AssetImage('assets/diamond.png'),
        ),
        shape: CircleBorder(
          side: BorderSide(
              width: 2.0, color: Colors.green, style: BorderStyle.solid),
        ),
      ),
    ),
  );
}

// 平滑圓角矩形
Widget _continuousRectangleBorder() {
  print('shape: 5');
  return Center(
    child: Container(
      width: 240,
      height: 120,
      margin: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/diamond.png'),
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(60),
          side: const BorderSide(
            width: 2,
            color: Colors.blue,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  );
}

// 平常我們在用的圓角矩形
Widget _roundedRectangleBorder() {
  print('shape: 6');
  return Center(
    child: Container(
      width: 240,
      height: 120,
      margin: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/diamond.png'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            width: 2,
            color: Colors.blue,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  );
}

// 體育場矩形, 兩邊為半圓
Widget _stadiumBorder() {
  print('shape: 7');
  return Center(
    child: Container(
      width: 240,
      height: 120,
      margin: const EdgeInsets.all(16),
      decoration: const ShapeDecoration(
        image: DecorationImage(
          image: AssetImage('assets/diamond.png'),
        ),
        shape: StadiumBorder(
          side: BorderSide(
            width: 2,
            color: Colors.blue,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
  );
}

// OutlineInputBorder
Widget _outlineInputBorder() {
  print('shape: 8');
  return Center(
    child: Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.orange,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: Colors.purple),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: const Text(
        "OutlineInputBorder",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  );
}

// 底線
Widget _underlineInputBorder() {
  print('shape: 9');
  return Center(
    child: Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.orange,
        shape: UnderlineInputBorder(
          borderSide: const BorderSide(width: 5.0, color: Colors.purple),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: const Text(
        "UnderlineInputBorder",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  );
}

class _SampleItem extends StatelessWidget {
  // final int index;

  // _SampleItem(BuildContext context, this.index) : super(key: ValueKey(index));

  @override
  Widget build(BuildContext context) {
    // print('index: $index');
    return Row(
      children: [_sampleCircle(), _sampleContent()],
    );
  }
}

// 圓形
Widget _sampleCircle() {
  return Center(
    child: Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.all(16),
      decoration: const ShapeDecoration(
        image: DecorationImage(
            image: AssetImage('assets/diamond.png'), fit: BoxFit.scaleDown),
        shape: CircleBorder(
          side: BorderSide(
              width: 2.0, color: Colors.blueGrey, style: BorderStyle.solid),
        ),
      ),
    ),
  );
}

Widget _sampleContent() {
  return Center(
    child: Container(
      // 沒定義寬高的話, 跟著內容變動
      // width: ,
      // height: ,
      margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            width: 1,
            color: Colors.grey,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: const Column(children: [
        Text('sample item name'),
        Text('sample user name'),
      ]),
    ),
  );
}
