import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hello_mdfk/model/product.dart';
import 'package:hello_mdfk/model/products_repository.dart';
import 'package:intl/intl.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: theme.textTheme.headlineLarge,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // List<Card> _buildGridCards(int count) {
  //   List<Card> cards = List.generate(
  //       // 生成的數量
  //       count,
  //       // 生成的函式
  //       (int index) {
  //     return Card(
  //       // 裁剪 Widget 的模式
  //       // none：无模式
  //       // hardEdge：裁剪速度稍快，但容易失真，有锯齿
  //       // antiAlias：裁剪边缘抗锯齿，使得裁剪更平滑，这种模式裁剪速度比antiAliasWithSaveLayer快，但是比hardEdge慢，该模式常用于圆形和弧形之类的形状裁剪
  //       // antiAliasWithSaveLayer：裁剪后具有抗锯齿特性并分配屏幕缓冲区，所有后续操作在缓冲区进行，然后再进行裁剪和合成
  //       clipBehavior: Clip.antiAlias,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // 約束寬高比的元件
  //           AspectRatio(
  //             // 寬高比 18:11, 可直接設置 float
  //             aspectRatio: 18.0 / 11.0,
  //             // 本地 assets 要去 pubspec.yaml 定義
  //             child: Image.asset('assets/diamond.png'),
  //           ),
  //           const Padding(
  //             padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text('title'),
  //                 SizedBox(height: 8),
  //                 Text('second text'),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  //   return cards;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 基本的上方 bar
      appBar: AppBar(
        // 修改 title text style 為預設的 head line large
        titleTextStyle: Theme.of(context).textTheme.headlineLarge,
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        title: const Text('Shop Now!'),
        // 是否置中, 若不設定, 每個平台預設值不同
        centerTitle: true,
        // 左邊的按鈕
        leading: IconButton(
          // btn icon
          icon: const Icon(
            Icons.menu,
            // semanticLabel 无障碍功能信息
            semanticLabel: 'menu',
          ),
          // 點擊事件
          onPressed: () {
            log('click bar menu btn');
          },
        ),
        // 右邊的按鈕
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              // semanticLabel 无障碍功能信息
              semanticLabel: 'search',
            ),
            onPressed: () {
              log('click bar search btn');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.tune,
              // semanticLabel 无障碍功能信息
              semanticLabel: 'filter',
            ),
            onPressed: () {
              log('click bar filter btn');
            },
          ),
        ],
      ),
      body: GridView.count(
          // crossAxisCount: 指定横向显示项数
          crossAxisCount: 2,
          // 字段为 GridView 的 4 邊设置内边距
          padding: const EdgeInsets.all(16.0),
          // 字段会根据宽高比（宽度与高度的比）确定项目的大小
          childAspectRatio: 8.0 / 9.0,
          children: _buildGridCards(context)
          // [
          // Card(
          //   clipBehavior: Clip.antiAlias,
          //   child: Column(
          //     // todo 介紹這邊對齊
          //     // CrossAxisAlignment.start 与前缘对齐
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // 无论提供何种类型的图片，AspectRatio 微件都会决定图片所采用的形状
          //       AspectRatio(
          //         aspectRatio: 18.0 / 11.0,
          //         // assets 要去 pubspec.yaml 定義
          //         child: Image.asset('assets/diamond.png'),
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
          //         child: Column(
          //           // todo 介紹這邊對齊
          //           // CrossAxisAlignment.start 字串對齊左邊
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             Text('title'),
          //             SizedBox(height: 8.0),
          //             Text('second title'),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // )
          // ],
          ),
    );
  }
}
