import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// https://codelabs.developers.google.com/codelabs/flutter-adaptive-app?hl=zh-cn#3
// 顯示裝置內容 page
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
                    // 裝置的擺放方向
                    value: '${mediaQuery.orientation}  ',
                  ),
                  _fillTableRow(
                    context: context,
                    property: 'Window Size',
                    // window的尺寸
                    value: '${mediaQuery.size.width.toStringAsFixed(1)} x '
                        '${mediaQuery.size.height.toStringAsFixed(1)}',
                  ),
                  _fillTableRow(
                    context: context,
                    property: 'Device Pixel Ratio',
                    // 裝置的像素比率PixelRatio，例如iPhone 8像素比率是2.0，Nexus 6是3.5
                    value: mediaQuery.devicePixelRatio.toStringAsFixed(2),
                  ),
                  _fillTableRow(
                    context: context,
                    property: 'Platform.isXXX',
                    // 啟動平台
                    value: platformDescription(),
                  ),
                  _fillTableRow(
                    context: context,
                    property: 'Theme.of(ctx).platform',
                    // 裝置平台
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
