import 'dart:math';

import 'package:flutter/material.dart';

class AnimationsScreen extends StatelessWidget {
  const AnimationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RectangleAnimated(),
      ),
    );
  }
}

class RectangleAnimated extends StatefulWidget {
  const RectangleAnimated({
    super.key,
  });

  @override
  State<RectangleAnimated> createState() => _RectangleAnimatedState();
}

class _RectangleAnimatedState extends State<RectangleAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;
  late Animation<double> opacity;
  late Animation<double> opacityOut;
  late Animation<double> moveRight;
  late Animation<double> scale;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    rotation = Tween(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    opacity = Tween(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.25,
          curve: Curves.easeInOut,
        ),
      ),
    );

    opacityOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.75,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    moveRight = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    scale = Tween(begin: 0.1, end: 2.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    controller.addListener(() {
      // print('Opacity: ${controller.status}');
      if (controller.status == AnimationStatus.completed) {
        controller.reverse();
        // controller.reset();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Animation

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return AnimatedBuilder(
      animation: controller,
      child: _Rectangle(),
      builder: (BuildContext context, Widget? child) {
        // print('Opacity: ${opacity.status}');
        // print('Rotation: ${rotation.status}');
        return Transform.scale(
          scale: scale.value,
          child: Transform.translate(
            offset: Offset(moveRight.value, 0),
            child: Transform.rotate(
              angle: rotation.value,
              child: Opacity(
                opacity: opacity.value - opacityOut.value,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Rectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );
  }
}
