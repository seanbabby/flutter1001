import 'package:flutter/material.dart';

/// 基本共用 Body Widget
class BaseBody extends StatelessWidget {
  final Widget child;
  const BaseBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    //使用 container 做 body 容器
    return Container(
      // body 容器 bg
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/desktop-bg-kv.webp'),
              fit: BoxFit.cover)),
      child: child,
    );
  }
}
