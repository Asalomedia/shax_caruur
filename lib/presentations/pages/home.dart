import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:shax_caruur/presentations/widgets/shaxBoardWidget.dart';

class Home extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        alignment: Alignment(0, 0),
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: SweepGradient(
            center: Alignment(0.5, -0.5),
            startAngle: 0.0,
            endAngle: 3.14 * 2,
            colors: [
              Colors.red,
              Colors.blueAccent,
              Colors.deepPurple,
              Colors.orange,
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: SizedBox(
          width: size.width,
          height: size.width,
          child: LayoutBuilder(
            builder: (context, consttraint) {
              final width = consttraint.maxWidth;
              final height = consttraint.maxHeight;
              final boardsize = m.min(width, height);
              return UnconstrainedBox(
                alignment: Alignment.center,
                child: Shaxboardwidget(size: Size.square(boardsize)),
              );
            },
          ),
        ),
      ),
    );
  }
}
