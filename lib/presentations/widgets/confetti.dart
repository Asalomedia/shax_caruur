import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiApp extends StatefulWidget {
  const ConfettiApp({super.key});

  @override
  State<ConfettiApp> createState() => _ConfettiAppState();
}

class _ConfettiAppState extends State<ConfettiApp> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    _controllerCenter.play();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();

    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degrees to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      );
      path.lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _controllerCenter,
      blastDirectionality: BlastDirectionality
          .explosive, // don't specify a direction, blast randomly
      shouldLoop: true, // start again as soon as the animation is finished
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple,
      ], // manually specify the colors to be used
      createParticlePath: drawStar, // define a custom shape/path.
    );
  }
}
