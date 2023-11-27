import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0.0;
  Color _activeDotColor = Colors.blue;
  Color _inactiveDotColor = Colors.grey;
  double _dotSize = 12.0;

  double get currentPage => _currentPage;

  set currentPage(double currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  Color get activeDotColor => _activeDotColor;

  set activeDotColor(Color activeDotColor) {
    _activeDotColor = activeDotColor;
    // notifyListeners();
  }

  Color get inactiveDotColor => _inactiveDotColor;

  set inactiveDotColor(Color inactiveDotColor) {
    _inactiveDotColor = inactiveDotColor;
    // notifyListeners();
  }

  double get dotSize => _dotSize;

  set dotSize(double dotSize) {
    _dotSize = dotSize;
    // notifyListeners();
  }
}

class Slideshow extends StatelessWidget {
  const Slideshow({
    super.key,
    required this.slides,
    this.dotsTop = false,
    this.activeDotColor = Colors.blue,
    this.inactiveDotColor = Colors.grey,
  });

  final List<Widget> slides;
  final bool dotsTop;
  final Color activeDotColor;
  final Color inactiveDotColor;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext contextb) {
              Provider.of<_SlideshowModel>(contextb).activeDotColor =
                  activeDotColor;
              // Provider.of<_SlideshowModel>(context).inactiveDotColor =
              //     inactiveDotColor;

              return _CreateStructureSlideshow(
                dotsTop: dotsTop,
                slides: slides,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CreateStructureSlideshow extends StatelessWidget {
  const _CreateStructureSlideshow({
    super.key,
    required this.dotsTop,
    required this.slides,
  });

  final bool dotsTop;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (dotsTop) _Dots(slides.length),
        Expanded(child: _Slides(slides: slides)),
        if (!dotsTop) _Dots(slides.length),
      ],
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({super.key, required this.slides});
  final List<Widget> slides;
  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      // update provider instance
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
          pageController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: widget.slides.map((slide) => _Slide(slide: slide)).toList(),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({
    required this.slide,
  });

  final Widget slide;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: slide,
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots(this.totalSlides);

  final int totalSlides;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalSlides,
          (index) => _Dot(index),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(
    this.index,
  );

  final int index;

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideshowModel>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: ssModel.dotSize,
      height: ssModel.dotSize,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (ssModel.currentPage >= index - 0.5 &&
                ssModel.currentPage < index + 0.5)
            ? ssModel.activeDotColor
            : ssModel.inactiveDotColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
