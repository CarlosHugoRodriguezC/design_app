import 'package:design_app/presentation/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class GraficasCircularesScreen extends StatefulWidget {
  const GraficasCircularesScreen({super.key});

  @override
  State<GraficasCircularesScreen> createState() =>
      _GraficasCircularesScreenState();
}

class _GraficasCircularesScreenState extends State<GraficasCircularesScreen> {
  double percentaje = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          percentaje += 10;
          if (percentaje > 100) {
            percentaje = 0;
          }
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(
                percentaje: percentaje,
                colorFill: Colors.red,
              ),
              CustomRadialProgress(
                percentaje: percentaje,
                colorFill: Colors.blue,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(
                percentaje: percentaje,
                colorFill: Colors.pink,
              ),
              CustomRadialProgress(
                percentaje: percentaje,
                colorFill: Colors.purple,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  const CustomRadialProgress({
    super.key,
    required this.percentaje,
    required this.colorFill,
  });

  final double percentaje;
  final Color colorFill;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      child: RadialProgress(
        percentaje: percentaje,
        colorFill: colorFill,
        // colorStroke: Colors.black,
      ),
    );
  }
}
