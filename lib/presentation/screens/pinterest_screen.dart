import 'package:design_app/presentation/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestScreen extends StatelessWidget {
  const PinterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: PinterestGrid(),
      body: ChangeNotifierProvider(
        create: (_) => MenuModel(),
        child: Stack(
          children: [
            PinterestGrid(),
            _PinterestMenuPositioned(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuPositioned extends StatelessWidget {
  const _PinterestMenuPositioned();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final show = Provider.of<MenuModel>(context).show;
    return Positioned(
      bottom: 30,
      width: width,
      child: Align(
        child: PinterestMenu(
          show: show,
          backgroundColor: Colors.blueAccent,
          activeColor: Colors.white,
          inactiveColor: Colors.white70,
        ),
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  PinterestGrid({super.key});

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  late ScrollController _scrollController;
  double prevScrollPosition = 0;
  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.offset > prevScrollPosition &&
          _scrollController.offset > 1) {
        Provider.of<MenuModel>(context, listen: false).show = false;
      }

      if (_scrollController.offset < prevScrollPosition) {
        Provider.of<MenuModel>(context, listen: false).show = true;
      }

      prevScrollPosition = _scrollController.offset;
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final List<int> _items = List.generate(200, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: _items.length,
      itemBuilder: (context, index) => PinterestItem(
        index: index + 1,
        extent: (index + 1).isEven ? 200 : 300,
      ),
    );
  }
}

class PinterestItem extends StatelessWidget {
  const PinterestItem({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor = Colors.blue,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}

class MenuModel with ChangeNotifier {
  bool _show = true;

  bool get show => _show;

  set show(bool value) {
    _show = value;
    notifyListeners();
  }
}
