import 'package:flutter/material.dart';

// ShapeBorder 用于设置形状和轮廓，比如圆形，矩形，圆角矩形等。常用于 Container 中。
class BorderSamplePage extends StatelessWidget {
  const BorderSamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        AppBar(
          title: const Text('Border Sample'),
        ),
        ListView(
          scrollDirection: Axis.vertical,
          children: [
            _beveledRectangleBorder(),
            _borderDirectional(),
            _borderDirectionalHorizon(),
            _circleBorder1(),
            _continuousRectangleBorder(),
          ],
        ),
      ],
    ));
  }
}

// BeveledRectangleBorder 斜面圆角矩形
Widget _beveledRectangleBorder() {
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
  return Center(
    child: Container(
      width: 240,
      height: 120,
      margin: const EdgeInsets.all(16),
      decoration: const ShapeDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/diamond.png'),
        ),
        shape: BorderDirectional(
          start: BorderSide(color: Color.fromARGB(255, 12, 46, 98), width: 15),
          end: BorderSide(color: Colors.red, width: 15),
        ),
      ),
    ),
  );
}

// 圓形
Widget _circleBorder1() {
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
              width: 2.0, color: Colors.yellow, style: BorderStyle.solid),
        ),
      ),
    ),
  );
}

Widget _continuousRectangleBorder() {
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
          borderRadius: BorderRadius.circular(40),
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
