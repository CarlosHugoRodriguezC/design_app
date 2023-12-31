import 'package:design_app/presentation/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlideshowScreen extends StatelessWidget {
  const SlideshowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.purpleAccent,
        body: Slideshow(
          slides: [
            SvgPicture.asset('assets/svgs/slide-1.svg'),
            SvgPicture.asset('assets/svgs/slide-2.svg'),
            SvgPicture.asset('assets/svgs/slide-3.svg'),
            SvgPicture.asset('assets/svgs/slide-4.svg'),
            SvgPicture.asset('assets/svgs/slide-5.svg'),
          ],
          dotsTop: true,
          activeDotColor: Colors.purple,
          inactiveDotColor: Colors.white,
          
        ));
  }
}
