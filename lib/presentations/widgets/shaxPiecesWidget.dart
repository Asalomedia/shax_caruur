import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/widgets.dart';
import 'package:shax_caruur/models/position.dart';
import 'package:shax_caruur/state_management/home_cubit.dart';
import 'package:shax_caruur/state_management/home_states.dart' show HomeStates;
import 'package:shax_caruur/utils.dart' as utils;

class ShaxPiecesPaint extends StatelessWidget {
  final HomeStates state;
  final Size totalSize;
  final double margin;
  final HomeCubit homeCubit;
  const ShaxPiecesPaint({
    super.key,
    required this.state,
    required this.homeCubit,
    required this.totalSize,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final minside = m.min(totalSize.width, totalSize.height);
    final double boardSide = (minside - 2 * margin);
    final Size boardSize = Size.square(boardSide); //size of board
    final double jointsRadius = boardSize.width / 30;
    final double pieceRadius = totalSize.width / 15;

    return GestureDetector(
      onPanStart: (details) {
        final Offset whereIHit = details.localPosition;
        final Piece? piece = homeCubit.findPieceIHit(
          whereIHit,
          pieceRadius,
          state.currentPlayer,
        );
        if (piece != null) {
          log(piece.player.toString());
        }
      },
      onPanUpdate: (details) {
        final Offset whereIsNow = details.localPosition;
        if (homeCubit.theOneWefound != null) {
          homeCubit.updatePieceLocation(whereIsNow);
        }
      },
      onPanEnd: (details) {
        ///// how to cancel pan or drag lke person released
        if (homeCubit.theOneWefound != null) {
          final Offset whereDragEnds = details.localPosition;
          homeCubit.dragEnds(whereDragEnds, pieceRadius, jointsRadius);
        }
      },

      child: CustomPaint(
        painter: ShaxPiecesPainter(
          homeCubit,
          state: state,
          pieceRadius: pieceRadius,
        ),
        size: totalSize,
      ),
    );
  }
}

class ShaxPiecesPainter extends CustomPainter {
  final HomeCubit homeCubit;
  final HomeStates state;
  final double pieceRadius;
  ShaxPiecesPainter(
    this.homeCubit, {
    required this.state,
    required this.pieceRadius,
  });
  @override
  void paint(Canvas canvas, Size totalSize) {
    final double aspecrationsimp = totalSize.width / totalSize.height;
    if (aspecrationsimp < 0.65) {
      utils.drawPockets(
        canvas,
        totalSize,
        homeCubit: homeCubit,
        state: state,
        radius: pieceRadius,
      );
    } else {
      log("not phone");
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
