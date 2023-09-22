import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_mdfk/colors.dart';

import 'package:hello_mdfk/page/homepagepage.dart';
import 'package:hello_mdfk/page/playlist_details.dart';
import 'package:hello_mdfk/qpp_sample/page/commodity_info_page.dart';
import 'package:hello_mdfk/qpp_sample/sample_app.dart';
import 'package:hello_mdfk/state/darkmodeprovider.dart';
import 'package:hello_mdfk/state/yt_play_list_state.dart';
import 'package:hello_mdfk/supplemental/cut_corners_border.dart';
import 'package:provider/provider.dart' as pv;
import 'state/appthemestate.dart';
import 'state/myappstate.dart';

// From https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw
const flutterDevAccountId = 'UCwXdFgeE9KYzlDdR7TG9cMw';

// Replace with your YouTube API Key
const youTubeApiKey = 'AIzaSyCH4gbwsktwSpJrESqNMGDnk7MOymMKY88';

void main() {
  runApp(const ProviderScope(child: Portal(child: MyApp())));
}

Map<String, Color> themeColorMap = {
  'gray': Colors.grey,
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'cyan': Colors.cyan,
  'deepPurple': Colors.purple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'deepOrange': Colors.orange,
  'green': Colors.green,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'red': Colors.red,
  'teal': Colors.teal,
  'black': Colors.black,
  'black_light': Colors.black.withAlpha(50),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return pv.MultiProvider(
        providers: [
          pv.ChangeNotifierProvider(create: (_) => DarkModeProvider()),
          pv.ChangeNotifierProvider(create: (_) => ThemeState()),
          pv.ChangeNotifierProvider(create: (_) => MyAppState()),
          pv.ChangeNotifierProvider(
              create: (_) => FlutterDevPlaylists(
                  flutterDevAccountId: flutterDevAccountId,
                  youTubeApiKey: youTubeApiKey)),
        ],
        child: pv.Consumer<DarkModeProvider>(
          builder: (_, darkmodeprovider, child) {
            return pv.Consumer<ThemeState>(
              builder: (context, themestate, child) {
                return MaterialApp.router(
                  title: 'Namer App',
                  theme: switch (darkmodeprovider.darkMode) {
                    // case 1
                    1 => _darkModeTheme(),
                    // default
                    _ => _selectColorTheme(themestate.themeColor),
                  },
                  darkTheme:
                      darkmodeprovider.darkMode == 2 ? _darkModeTheme() : null,
                  debugShowCheckedModeBanner: false,
                  // home: const MyHomePage(),
                  routerConfig: router,
                );
              },
            );
          },
        ));
  }
}

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        // return const MyHomePage();
        return const CommodityInfoPage(123);
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'playlist/:id',
          builder: (context, state) {
            final title = state.uri.queryParameters['title']!;
            final id = state.pathParameters['id']!;
            return Scaffold(
              body: PlaylistDetails(
                playlistId: id,
                playlistName: title,
              ),
            );
          },
        ),
      ],
    ),
  ],
);

// 可選擇顏色主題
ThemeData _selectColorTheme(String color) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: themeColorMap[color]!),
    // ColorScheme.fromSeed(seedColor: Colors.deepOrange),
  );
}

// 深色模式
ThemeData _darkModeTheme() {
  return ThemeData(
    // 深色模式
    colorScheme: ColorScheme.fromSeed(seedColor: themeColorMap['black_light']!),
  );
}

ThemeData _buildMyAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: BlueShade.blue100.color,
        onPrimary: kShrineBrown900,
        secondary: kShrineBrown900,
        error: kShrineErrorRed,
      ),
      // 用自定義 TextTheme 設定
      textTheme: _buildMyAppTextTheme(base.textTheme),
      textSelectionTheme:
          const TextSelectionThemeData(selectionColor: kShrinePink100),
      appBarTheme: const AppBarTheme(
        foregroundColor: kShrineBrown900,
        backgroundColor: kShrinePink100,
      ),
      inputDecorationTheme: const InputDecorationTheme(
          // flutter sample 提供的自訂義 border
          border: CutCornersBorder(),
          focusedBorder: CutCornersBorder(
            borderSide: BorderSide(width: 2.0, color: kShrineBrown900),
          ),
          floatingLabelStyle: TextStyle(
            color: kShrineBrown900,
          )));
}

// Material design text style guide: https://m3.material.io/styles/typography/type-scale-tokens#40fc37f8-3269-4aa3-9f28-c6113079ac5d
// 自定義字型樣式
TextTheme _buildMyAppTextTheme(TextTheme base) {
  return base
      .copyWith(
        // fontWeight 100-900, 越大越粗
        headlineLarge: base.headlineLarge!.copyWith(
          fontWeight: FontWeight.w100,
          fontSize: 100.0,
        ),
        // font size 差異, android對比web 1:0.0625, https://m3.material.io/styles/typography/type-scale-tokens#3f4488e7-3b74-45b0-a143-9d6afa4d62dc
        headlineMedium: base.headlineMedium!.copyWith(
          fontSize: 16.0,
        ),
        bodyMedium: base.bodyMedium!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyLarge: base.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: BlueShade.blue100.color,
        bodyColor: kShrineBrown900,
      );
}

enum BlueShade {
  blue100,
  blue200,
  blue300,
  blue400,
  blue500,
  blue600,
  blue700,
}

extension BlueShadeExtension on BlueShade {
  Color get color {
    switch (this) {
      case BlueShade.blue100:
        return const Color(0xFFE3F2FD);
      case BlueShade.blue200:
        return const Color(0xFFBBDEFB);
      case BlueShade.blue300:
        return const Color(0xFF90CAF9);
      case BlueShade.blue400:
        return const Color(0xFF64B5F6);
      case BlueShade.blue500:
        return const Color(0xFF42A5F5);
      case BlueShade.blue600:
        return const Color(0xFF2196F3);
      case BlueShade.blue700:
        return const Color(0xFF1E88E5);
      default:
        return Colors.blue;
    }
  }

  int get value {
    switch (this) {
      case BlueShade.blue100:
        return 100;
      case BlueShade.blue200:
        return 200;
      case BlueShade.blue300:
        return 300;
      case BlueShade.blue400:
        return 400;
      case BlueShade.blue500:
        return 500;
      case BlueShade.blue600:
        return 600;
      case BlueShade.blue700:
        return 700;
      default:
        return 500;
    }
  }
}
