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
    return Expanded(
      child: Scaffold(
        // 是否延伸body至底部
        extendBody: true,
        // 是否延伸body至顶部
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0x800f1f63).withOpacity(0.5),
          toolbarHeight: 100,
          elevation: 0,
          title: _largeAppBar(),
        ),
        body: const Placeholder(),
      ),
    );
  }
}

Widget _largeAppBar() {
  // Stack 重疊元件
  return Stack(
    // 對齊位置
    alignment: const Alignment(0, 0),
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 左邊的圖片
          IconButton(
            iconSize: 160,
            icon: Image.network(
              'https://qpptec.com/img/logo.png',
              fit: BoxFit.fill,
            ),
            onPressed: () => {},
          ),
          // 擠右邊的東西用
          const Expanded(child: Text('')),
          _ExtendCountryBox(),
        ],
      ),
      const Expanded(
        child: Center(
            child: Text(
          '',
          style: TextStyle(fontSize: 45),
        )),
      )
    ],
  );
}

// List<PopupMenuItem> _buttonItems() {
// return [
//   PopupMenuItem(
//     child: Text(QppCountry.traditionalChinese.buttonTitle),
//     onTap: () => onCountryClick(0),
//   ),
//   PopupMenuItem(
//       value: 1, child: Text(QppCountry.simplifiedChinese.buttonTitle)),
//   PopupMenuItem(value: 2, child: Text(QppCountry.english.buttonTitle)),
//   PopupMenuItem(value: 3, child: Text(QppCountry.japanese.buttonTitle)),
//   PopupMenuItem(value: 4, child: Text(QppCountry.korean.buttonTitle)),
//   PopupMenuItem(value: 5, child: Text(QppCountry.vietnam.buttonTitle)),
//   PopupMenuItem(value: 6, child: Text(QppCountry.thailand.buttonTitle)),
//   PopupMenuItem(value: 7, child: Text(QppCountry.indonesia.buttonTitle)),
// ];
// }

List<ListTile> _buttonItems() {
  return [
    ListTile(
      title: Text(QppCountry.traditionalChinese.buttonTitle),
      onTap: () => onCountryClick(0),
    ),
    ListTile(title: Text(QppCountry.simplifiedChinese.buttonTitle)),
    ListTile(title: Text(QppCountry.english.buttonTitle)),
    ListTile(title: Text(QppCountry.japanese.buttonTitle)),
    ListTile(title: Text(QppCountry.korean.buttonTitle)),
    ListTile(title: Text(QppCountry.vietnam.buttonTitle)),
    ListTile(title: Text(QppCountry.thailand.buttonTitle)),
    ListTile(title: Text(QppCountry.indonesia.buttonTitle)),
  ];
}

void onCountryClick(int value) {
  print('Click Country $value');
}

StateProvider<bool> onCountryShowProvider = StateProvider((ref) {
  return false;
});

class _ExtendCountryBox extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var onCountryShow = ref.watch(onCountryShowProvider);
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        ref.read(onCountryShowProvider.notifier).state = true;
      },
      onExit: (PointerExitEvent event) {
        ref.read(onCountryShowProvider.notifier).state = false;
      },
      child: _ModalEntry(
        visible: onCountryShow,
        onClose: () {},
        popup: _Popup(
          children: _buttonItems(),
          //  _buttonItems(),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextButton.icon(
            onPressed: () {
              ref.read(onCountryShowProvider.notifier).state = !onCountryShow;
            },
            label: const Text(
              'Languages',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: 35,
              color: Colors.white,
            ),
          ),
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
          bottom: 16,
        ),
        child: Consumer(builder: (context, ref, _) {
          var onCountryShow = ref.watch(onCountryShowProvider);
          return MouseRegion(
              onEnter: (event) =>
                  ref.read(onCountryShowProvider.notifier).state = true,
              onExit: (event) =>
                  ref.read(onCountryShowProvider.notifier).state = false,
              child: onCountryShow
                  ? Card(
                      elevation: 8,
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
          follower: Alignment.topLeft,
          target: Alignment.bottomLeft,
          widthFactor: 1,
        ),
        child: IgnorePointer(
          ignoring: visible,
          child: child,
        ),
      ),
    );
  }
}
