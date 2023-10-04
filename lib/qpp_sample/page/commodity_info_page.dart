import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_mdfk/qpp_sample/qpp_country.dart';

class CommodityInfoPage extends ConsumerWidget {
  final int _commodidyId;

  const CommodityInfoPage(this._commodidyId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(128, 15, 31, 99),
      // 是否延伸body至底部
      extendBody: true,
      // 是否延伸body至顶部
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(128, 9, 17, 54).withOpacity(0.6),
        toolbarHeight: 100,
        elevation: 0,
        title: _largeAppBar(),
      ),
      //使用 container 做 body 容器
      body: Container(
        // body 容器 bg
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('https://imgur.com/YC7kYZk.png'),
                // https://imgur.com/YC7kYZk.png
                fit: BoxFit.cover)),
        child: ListView(children: [
          // 上方資料卡片容器
          Card(
            // 切子元件超出範圍
            clipBehavior: Clip.hardEdge,
            semanticContainer: false,
            margin: const EdgeInsets.fromLTRB(50, 50, 50, 400),
            color: const Color.fromARGB(255, 7, 18, 67),
            shape: RoundedRectangleBorder(
              // 圓角參數
              borderRadius: BorderRadius.circular(8),
            ),
            // Card 陰影
            elevation: 0,
            child: Column(
              children: [
                Container(
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: Column(children: [
                    // 資料區 上半部
                    Container(
                      padding: const EdgeInsets.only(top: 80, bottom: 30),
                      width: double.infinity,
                      // 上半部 bg
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://qpptec.com/img/defaultBg.png'),
                              fit: BoxFit.cover)),
                      child: Column(children: [
                        // 物品 icon
                        ClipOval(
                          child: Image.network(
                            'https://storage.googleapis.com/qpp_blockchain/Item/9E56D46E4848CD1BBF82A8ADA053FF68806193A204F47058B2FB87AB0C32288C_109555_Image1.png?v=1683259489078672',
                            width: 100,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        // 物品名稱
                        const Text(
                          'item item item',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ]),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

Widget _largeAppBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // 左邊的圖片
      IconButton(
        iconSize: 160,
        icon: Image.network(
          'https://qpptec.com/img/logo.png',
          filterQuality: FilterQuality.high,
          fit: BoxFit.fill,
        ),
        onPressed: () => {print('Click QPP HomePage')},
      ),
      // 擠右邊的東西用
      const Expanded(child: Text('')),
      TextButton(
          onPressed: () => {print('Click 產品介紹')},
          child: const Text(
            '產品介紹',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          )),
      const SizedBox(
        width: 30,
      ),
      TextButton(
          onPressed: () => {print('Click 產品特色')},
          child: const Text(
            '產品特色',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          )),
      const SizedBox(
        width: 30,
      ),
      TextButton(
          onPressed: () => {print('Click 使用說明')},
          child: const Text(
            '使用說明',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          )),
      const SizedBox(
        width: 30,
      ),
      TextButton(
          onPressed: () => {print('Click 聯繫我們')},
          child: const Text(
            '聯繫我們',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          )),
      const SizedBox(
        width: 30,
      ),
      _ExtendCountryBox(),
    ],
  );
}

List<Widget> _buttonItems() {
  return QppCountry.values
      .map((country) => Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final LanguageListStateNotifier notifier =
                  ref.read(languageListProvider.notifier);
              return ListTile(
                  title: Text(
                    country.buttonTitle,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  onTap: () {
                    notifier.onClick();
                    onCountryClick(country.index);
                  });
            },
          ))
      .toList();
}

class LanguageListStateNotifier extends StateNotifier<bool> {
  LanguageListStateNotifier() : super(false);

  void openList() {
    state = true;
  }

  void closeList() {
    state = false;
  }

  void onClick() {
    state = !state;
  }
}

final languageListProvider =
    StateNotifierProvider<LanguageListStateNotifier, bool>((ref) {
  return LanguageListStateNotifier();
});

void onCountryClick(int value) {
  print('Click Country $value');
}

class _ExtendCountryBox extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LanguageListStateNotifier notifier =
        ref.read(languageListProvider.notifier);

    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        notifier.openList();
      },
      onExit: (PointerExitEvent event) {
        notifier.closeList();
      },
      child: _ModalEntry(
        visible: ref.watch(languageListProvider),
        onClose: () {
          notifier.onClick();
        },
        popup: _Popup(
          children: _buttonItems(),
        ),
        child: IconButton(
          icon:
              Image.asset('assets/mobile-icon-actionbar-language-normal.webp'),
          onPressed: () {
            notifier.onClick();
          },
        ),
      ),
    );
  }
}

class _Popup extends StatelessWidget {
  const _Popup({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          bottom: 0,
        ),
        child: Consumer(builder: (context, ref, _) {
          final LanguageListStateNotifier notifier =
              ref.read(languageListProvider.notifier);
          return MouseRegion(
              onEnter: (event) => notifier.openList(),
              onExit: (event) => notifier.closeList(),
              child: ref.watch(languageListProvider)
                  ? Card(
                      color:
                          const Color.fromARGB(128, 9, 17, 54).withOpacity(0.6),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IntrinsicWidth(
                        child: ListView(
                          shrinkWrap: true,
                          children: children,
                        ),
                      ),
                    )
                  : null);
        }));
  }
}

class _ModalEntry extends StatelessWidget {
  const _ModalEntry({
    Key? key,
    required this.onClose,
    required this.visible,
    required this.popup,
    required this.child,
  }) : super(key: key);

  final VoidCallback onClose;
  final bool visible;
  final Widget popup;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: visible ? onClose : null,
      child: PortalTarget(
        visible: visible,
        portalFollower: popup,
        // todo: implement anchor that sizes the follower based on the available space within the portal at the calculated offset.
        anchor: const Aligned(
          follower: Alignment.topRight,
          target: Alignment.bottomRight,
          widthFactor: 4,
        ),
        child: IgnorePointer(
          ignoring: visible,
          child: child,
        ),
      ),
    );
  }
}
