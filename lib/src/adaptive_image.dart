import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// CORS https://aws.amazon.com/tw/what-is/cross-origin-resource-sharing/
// https://medium.com/swf-lab/網頁開發常見之-cors-錯誤原因與-express-解決辦法-bc5eeedea6dc
// https://www.shubo.io/what-is-cors/
class AdaptiveImage extends StatelessWidget {
  AdaptiveImage.network(String url, {super.key}) {
    if (kIsWeb) {
      _url = Uri.parse(url)
          .replace(host: 'localhost', port: 8080, scheme: 'http')
          .toString();
    } else {
      _url = url;
    }
  }

  late final String _url;

  @override
  Widget build(BuildContext context) {
    return Image.network(_url);
  }
}
