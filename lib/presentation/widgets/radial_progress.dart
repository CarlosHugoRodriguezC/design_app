import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  const RadialProgress({
    super.key,
    required this.percentaje,
    this.colorFill = Colors.pink,
    this.colorStroke = Colors.grey,
  });
  final double percentaje;
  final Color colorFill;
  final Color colorStroke;

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late double percentajeOld;

  @override
  void initState() {
    percentajeOld = widget.percentaje;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward(from: 0.0);

    final difference = widget.percentaje - percentajeOld;
    percentajeOld = widget.percentaje;

    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: double.infinity,
              child: CustomPaint(
                painter: _MyRadialProgress(
                  colorFill: widget.colorFill,
                  colorStroke: widget.colorStroke,
                  percentaje: (widget.percentaje - difference) +
                      (difference * animationController.value),
                ),
              ));
        });
  }
}

class _MyRadialProgress extends CustomPainter {
  _MyRadialProgress({
    required this.percentaje,
    required this.colorFill,
    required this.colorStroke,
  });

  final double percentaje;
  final Color colorFill;
  final Color colorStroke;

  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = const LinearGradient(
      colors: <Color>[
        Colors.red,
        Colors.blue,
        Colors.pink,
      ],
    );

    final Rect gradientRect =
        Rect.fromCircle(center: Offset(0, 0), radius: 180);

    // Circle
    final paint = Paint()
      ..strokeWidth = 4
      ..color = colorStroke
      ..style = PaintingStyle.stroke;

    final c = Offset(size.width * 0.5, size.height / 2);

    final radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(c, radius, paint);

    // Arc

    // final paintArc = Paint()
    //   ..strokeWidth = 10
    //   ..color = colorFill
    //   ..strokeCap = StrokeCap.round
    //   ..style = PaintingStyle.stroke;

    final paintArc = Paint()
      ..strokeWidth = 10
      ..shader = gradient.createShader(gradientRect)
      ..strokeCap = StrokeCap.round
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
