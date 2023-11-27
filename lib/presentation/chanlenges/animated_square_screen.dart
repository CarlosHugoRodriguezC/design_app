import 'package:flutter/material.dart';

class AnimatedSquareScreen extends StatelessWidget {
  const AnimatedSquareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: _AnimatedSquare()),
    );
  }
}

class _AnimatedSquare extends StatefulWidget {
  const _AnimatedSquare({
    super.key,
  });

  @override
  State<_AnimatedSquare> createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<_AnimatedSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _moveRight;
  late Animation<double> _moveUp;
  late Animation<double> _moveLeft;
  late Animation<double> _moveDown;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4500));

    _moveRight = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.25, curve: Curves.bounceOut),
    ));

    _moveUp = Tween(begin: 0.0, end: -100.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.25, 0.5, curve: Curves.bounceOut),
    ));

    _moveLeft = Tween(begin: 0.0, end: -100.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 0.75, curve: Curves.bounceOut),
    ));

    _moveDown = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.75, 1.0, curve: Curves.bounceOut),
    ));

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          _moveRight.value + _moveLeft.value,
          _moveUp.value + _moveDown.value,
        ),
        child: _Rectangle(),
      ),
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
