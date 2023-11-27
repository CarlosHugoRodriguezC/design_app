import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressScreen extends StatefulWidget {
  const CircularProgressScreen({super.key});

  @override
  State<CircularProgressScreen> createState() => _CircularProgressScreenState();
}

class _CircularProgressScreenState extends State<CircularProgressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double percentaje = 0.0;
  double newPercentaje = 0.0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    controller.addListener(() {
      // print('valor controller: ${controller.value}');
      percentaje = lerpDouble(
            percentaje,
            newPercentaje,
            controller.value,
          ) ??
          0.0;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          percentaje = newPercentaje;
          newPercentaje += 10;
          if (newPercentaje > 100) {
            newPercentaje = 0;
            percentaje = 0;
          }

          controller.forward(from: 0.0);
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 300,
          height: 300,
          child: CustomPaint(
            painter: _MyRadialProgress(percentaje: percentaje),
          ),
        ),
      ),
    );
  }
}

class _MyRadialProgress extends CustomPainter {
  _MyRadialProgress({required this.percentaje});

  final double percentaje;

  @override
  void paint(Canvas canvas, Size size) {
    // Circle
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    final c = Offset(size.width * 0.5, size.height / 2);

    final radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(c, radius, paint);

    // Arc

    final paintArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;

    // part of fill

    double archAngle = 2 * pi * (percentaje / 100);

    canvas.drawArc(
      Rect.fromCircle(center: c, radius: radius),
      -pi / 2,
      archAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
