import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  PinterestButton({
    required this.onPressed,
    required this.icon,
  });

  final void Function()? onPressed;
  final IconData icon;
}

class PinterestMenu extends StatelessWidget {
  PinterestMenu({
    super.key,
    this.show = true,
    this.backgroundColor = Colors.white,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.blueGrey,
  });

  final bool show;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  final List<PinterestButton> items = [
    PinterestButton(
      onPressed: () {
        print('Icon pie_chart');
      },
      icon: Icons.pie_chart,
    ),
    PinterestButton(
      onPressed: () {
        print('Icon search');
      },
      icon: Icons.search,
    ),
    PinterestButton(
      onPressed: () {
        print('Icon notifications');
      },
      icon: Icons.notifications,
    ),
    PinterestButton(
      onPressed: () {
        print('Icon supervised_user_circle');
      },
      icon: Icons.supervised_user_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: Builder(builder: (context) {
        Provider.of<_MenuModel>(context).activeColor = activeColor;
        Provider.of<_MenuModel>(context).inactiveColor = inactiveColor;
        Provider.of<_MenuModel>(context).backgroundColor = backgroundColor;
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: show ? 1 : 0,
          child: _PinterestMenuBackground(
            child: _MenuItems(items: items),
          ),
        );
      }),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  const _PinterestMenuBackground({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: Provider.of<_MenuModel>(context).backgroundColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 0),
            blurRadius: 10,
            spreadRadius: -5,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  const _MenuItems({
    super.key,
    required this.items,
  });

  final List<PinterestButton> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(items.length,
          (index) => _PinterestMenuButton(index: index, item: items[index])),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  const _PinterestMenuButton({
    super.key,
    required this.index,
    required this.item,
  });

  final int index;
  final PinterestButton item;

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<_MenuModel>(context).currentIndex;
    // return IconButton(
    //   onPressed: item.onPressed,
    //   icon: Icon(
    //     item.icon,
    //     color: Colors.blueGrey,
    //     size: 25,
    //   ),
    // );
    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).currentIndex = index;
        item.onPressed?.call();
      },
      behavior: HitTestBehavior.translucent,
      child: Icon(
        item.icon,
        color: currentIndex == index
            ? Provider.of<_MenuModel>(context)._activeColor
            : Provider.of<_MenuModel>(context)._inactiveColor,
        size: currentIndex == index ? 35 : 25,
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _currentIndex = 0;
  Color _activeColor = Colors.black;
  Color _inactiveColor = Colors.blueGrey;
  Color _backgroundColor = Colors.white;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Color get activeColor => _activeColor;

  set activeColor(Color color) {
    _activeColor = color;
    // notifyListeners();
  }

  Color get inactiveColor => _inactiveColor;

  set inactiveColor(Color color) {
    _inactiveColor = color;
    // notifyListeners();
  }

  Color get backgroundColor => _backgroundColor;

  set backgroundColor(Color color) {
    _backgroundColor = color;
    // notifyListeners();
  }
}
