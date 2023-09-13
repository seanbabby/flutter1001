import 'package:flutter/material.dart';
import 'package:hello_mdfk/qpp_sample/app-router.delegate.dart';

class SampleApp extends StatelessWidget {
  SampleApp({super.key});

  final AppRouterDelegate _delegate = AppRouterDelegate();
  final AppRouterParser _parser = AppRouterParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'sample',
      debugShowCheckedModeBanner: false,
      routerDelegate: _delegate,
      routeInformationParser: _parser,
    );
  }
}
