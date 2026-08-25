import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:shax_caruur/presentations/widgets/shaxPiecesWidget.dart'
    show ShaxPiecesPaint;

import 'package:shax_caruur/state_management/home_states.dart';
import 'package:shax_caruur/utils.dart' as utils;

class Shaxboardwidget extends StatelessWidget {
  final BoxConstraints constraint;
  final HomeStates state;
  const Shaxboardwidget({
    super.key,
    required this.constraint,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final width = constraint.maxWidth;
    final height = constraint.maxHeight;
    final Size totalSize = Size(width, height);
    final double margin = totalSize.width * 0.05;

    return Stack(
      children: [
        CustomPaint(
          painter: ShaxBoardPainter(context, state: state, margin: margin),
          size: totalSize,
        ),
        ShaxPiecesPaint(state: state, totalSize: totalSize, margin: margin),
      ],
    );
  }
}

class ShaxBoardPainter extends CustomPainter {
  final BuildContext context;
  final HomeStates state;
  final double margin;
  const ShaxBoardPainter(
    this.context, {
    required this.state,
    required this.margin,
  });
  @override
  void paint(Canvas canvas, Size totalSize) {
    double fromTop = margin;
    double fromLeft = margin;
    final minside = m.min(totalSize.width, totalSize.height);
    final double boardSide = (minside - 2 * margin);
    final maxside = m.max(totalSize.width, totalSize.height);
    final diff = maxside - boardSide;
    final half = diff / 2;
    if (totalSize.width < totalSize.height) fromTop += half;
    if (totalSize.width > totalSize.height) fromLeft += half;
    final Size boardSize = Size.square(boardSide); //size of board
    log(
      "width:${boardSize.width},height:${boardSize.height}",
    ); // widht and height must be same for square
    final double jointsRadius = boardSize.width / 30;
    utils.drawShax(
      canvas,
      boardSize,
      fromTop,
      fromLeft,
      context: context,
      state: state,
      radius: jointsRadius,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
