import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// https://codelabs.developers.google.com/codelabs/flutter-adaptive-app?hl=zh-cn#3

class AdaptivePage extends StatelessWidget {
  const AdaptivePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 讀取媒體裝置數據 https://ithelp.ithome.com.tw/articles/10225698
    final mediaQuery = MediaQuery.of(context);
    // 運行平台
    final platform = Theme.of(context).platform;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Window properties',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 350,
              child: Table(
                textBaseline: TextBaseline.alphabetic,
                children: <TableRow>[
                  _fillTableRow(
                    context: context,
                    property: 'Orientation',
                    value: '${mediaQuery.orientation}  ',
                  ),
                  _fillTableRow(
                    context: context,
                    property: 'Window Size',
                    value: '${mediaQuery.size.width.toStringAsFixed(1)} x '
                        '${mediaQuery.size.height.toStringAsFixed(1)}',
                  ),
                  _fillTableRow(
                    context: context,
                    property: 'Device Pixel Ratio',
                    value: mediaQuery.devicePixelRatio.toStringAsFixed(2),
                  ),
                  _fillTableRow(
                    context: context,
                    property: 'Platform.isXXX',
                    value: platformDescription(),
                  ),
                  _fillTableRow(
                    context: context,
                    property: 'Theme.of(ctx).platform',
                    value: platform.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TableRow _fillTableRow(
    {required BuildContext context,
    required String property,
    required String value}) {
  return TableRow(
    children: [
      TableCell(
        // TableCellVerticalAlignment 表格组件
        // https://zhuanlan.zhihu.com/p/587061207
        verticalAlignment: TableCellVerticalAlignment.baseline,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(property),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.baseline,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ),
    ],
  );
}

String platformDescription() {
  if (kIsWeb) {
    return 'Web';
  } else if (Platform.isAndroid) {
    return 'Android';
  } else if (Platform.isIOS) {
    return 'iOS';
  } else if (Platform.isWindows) {
    return 'Windows';
  } else if (Platform.isMacOS) {
    return 'macOS';
  } else if (Platform.isLinux) {
    return 'Linux';
  } else if (Platform.isFuchsia) {
    return 'Fuchsia';
  } else {
    return 'Unknown';
  }
}
