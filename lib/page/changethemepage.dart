import 'package:flutter/material.dart';
import 'package:hello_mdfk/main.dart';
import 'package:hello_mdfk/state/appthemestate.dart';
import 'package:hello_mdfk/state/darkmodeprovider.dart';
import 'package:provider/provider.dart';

class ChangeThemePage extends StatefulWidget {
  const ChangeThemePage({super.key});

  @override
  State<ChangeThemePage> createState() => _ChangeThemePageState();
}

// 帶底線為 private
class _ChangeThemePageState extends State<ChangeThemePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ThemeState>();
    String colorKey = appState.themeColor;

    return Column(children: [
      Text(
        '深色模式',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 20),
      OverflowBar(
        children: [
          // 0:關閉, 1:開啟, 2:系統設定
          TextButton(
              onPressed: () => {
                    Provider.of<DarkModeProvider>(context, listen: false)
                        .setDarkMode(0)
                  },
              child: const Text('關閉')),
          TextButton(
              onPressed: () => {
                    Provider.of<DarkModeProvider>(context, listen: false)
                        .setDarkMode(1)
                  },
              child: const Text('開啟')),
          TextButton(
              onPressed: () => {
                    Provider.of<DarkModeProvider>(context, listen: false)
                        .setDarkMode(2)
                  },
              child: const Text('系統設定')),
        ],
      ),
      const SizedBox(height: 20),
      ExpansionTile(
        leading: const Icon(Icons.color_lens),
        title: const Text('主題顏色'),
        //
        initiallyExpanded: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: themeColorMap.keys.map((key) {
                Color? value = themeColorMap[key];
                return InkWell(
                  onTap: () {
                    setState(() {
                      colorKey = key;
                    });
                    Provider.of<ThemeState>(context, listen: false)
                        .setTheme(key);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    color: value,
                    child: colorKey == key
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    ]);
  }
}
