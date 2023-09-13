import 'package:flutter/material.dart';
import 'package:hello_mdfk/qpp_sample/page/commodity_info_page.dart';
import 'package:hello_mdfk/qpp_sample/page/search_id_page.dart';

class RoutePage extends RouteSettings {
  final Function? builder;

  final String? path;

  Widget get widget => builder!();

  const RoutePage({
    required String name,
    Object? arguments,
    this.builder,
    this.path,
  }) : super(name: name, arguments: arguments);

  RoutePage.widget(Widget widget) : this(name: 'widget', builder: () => widget);
}

RoutePage getRoutePage({required String name}) {
  debugPrint("[RoutePage] getRoutePage $name");
  switch (name) {
    case '/':
      return RoutePage(
          name: "Home",
          path: name,
          builder: () => const SearchCommodityIDPage());
    case '/items':
      return RoutePage(
          name: "Items", path: name, builder: () => const CommodityInfoPage(0));
    // case '/settings':
    //   return RoutePage(name: "Settings", path: name, builder: () => const SettingsPage());
    default:
      return RoutePage(
          name: 'Unknwon',
          path: '/404',
          builder: () => const SearchCommodityIDPage());
  }
}
