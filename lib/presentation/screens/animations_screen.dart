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

    controller.addListener(() {
      print('Status: ${controller.status}');
      if (controller.status == AnimationStatus.completed) {
        controller.reverse();
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
        return Transform.rotate(angle: rotation.value, child: child);
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
