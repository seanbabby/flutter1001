import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello_mdfk/qpp_sample/qpp_country.dart';

class BaseAppBar extends StatelessWidget {
  const BaseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 左邊的圖片
        IconButton(
          iconSize: 160,
          icon: SvgPicture.asset(
            'desktop-pic-qpp-logo-01.svg',
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
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
        const SizedBox(
          width: 30,
        ),
        TextButton(
            onPressed: () => {print('Click 產品特色')},
            child: const Text(
              '產品特色',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
        const SizedBox(
          width: 30,
        ),
        TextButton(
            onPressed: () => {print('Click 使用說明')},
            child: const Text(
              '使用說明',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
        const SizedBox(
          width: 30,
        ),
        TextButton(
            onPressed: () => {print('Click 聯繫我們')},
            child: const Text(
              '聯繫我們',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
        const SizedBox(
          width: 30,
        ),
        _ExtendCountryBox(),
      ],
    );
  }
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
      onEnter: (event) {
        notifier.openList();
      },
      onExit: (event) {
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
          icon: SvgPicture.asset(
            'mobile-icon-actionbar-language-normal.svg',
          ),
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
