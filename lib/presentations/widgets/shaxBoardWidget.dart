import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shax_caruur/models/player.dart' show Player;
import 'package:shax_caruur/presentations/widgets/confetti.dart';
import 'package:shax_caruur/presentations/widgets/score_shower.dart';
import 'package:shax_caruur/presentations/widgets/shaxPiecesWidget.dart'
    show ShaxPiecesPaint;
import 'package:shax_caruur/state_management/home_cubit.dart';

import 'package:shax_caruur/state_management/home_states.dart';
import 'package:shax_caruur/utils.dart' as utils;

class Shaxboardwidget extends StatelessWidget {
  final BoxConstraints constraint;
  final HomeCubit homeCubit;
  final HomeStates state;
  const Shaxboardwidget({
    super.key,
    required this.constraint,
    required this.homeCubit,
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
          painter: ShaxBoardPainter(homeCubit, state: state, margin: margin),
          size: totalSize,
        ),
        ShaxPiecesPaint(
          state: state,
          totalSize: totalSize,
          margin: margin,
          homeCubit: homeCubit,
        ),
        ScoreShower(pos: totalSize.width / 5),
        if (state.currentPlayer == Player.rock)
          Positioned(
            top: totalSize.height / 20,
            right: 0,
            child: IconButton(
              onPressed: () {
                BlocProvider.of<HomeCubit>(context).restart();
              },
              icon: const Icon(
                Icons.radio_button_checked,
                color: Colors.redAccent,
                size: 50,
              ),
            ),
          ),
        if (state.currentPlayer == Player.coal)
          Positioned(
            top: totalSize.height - totalSize.height / 7.5,
            right: 0,
            child: IconButton(
              onPressed: () {
                BlocProvider.of<HomeCubit>(context).restart();
              },
              icon: const Icon(
                Icons.radio_button_checked,
                color: Colors.green,
                size: 50,
              ),
            ),
          ),
        if (state.runtimeType == EndgameState)
          Positioned(
            top: totalSize.width / 2,
            left: totalSize.height / 2,
            child: ConfettiApp(),
          ),
      ],
    );
  }
}

class ShaxBoardPainter extends CustomPainter {
  final HomeCubit homeCubit;
  final HomeStates state;
  final double margin;
  const ShaxBoardPainter(
    this.homeCubit, {
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
      homeCubit: homeCubit,
      state: state,
      radius: jointsRadius,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
