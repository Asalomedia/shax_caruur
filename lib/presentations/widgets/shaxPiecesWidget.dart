import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/widgets.dart';
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
    return GestureDetector(
      onPanStart: (details) {
        final Offset whereIHit = details.localPosition;
        homeCubit.dragStart(whereIHit, state.currentPlayer);
      },
      onPanUpdate: (details) {
        final Offset whereIsNow = details.localPosition;

        if (homeCubit.gameController.getTheOneWefound != null) {
          homeCubit.updatePieceLocation(whereIsNow);
        }
      },
      onPanEnd: (details) {
        ///// how to cancel pan or drag lke person released
        if (homeCubit.gameController.getTheOneWefound != null) {
          final Offset whereDragEnds = details.localPosition;
          homeCubit.dragEnds(whereDragEnds);
        }
      },

      child: CustomPaint(
        painter: ShaxPiecesPainter(homeCubit, state: state),
        size: totalSize,
      ),
    );
  }
}

class ShaxPiecesPainter extends CustomPainter {
  final HomeCubit homeCubit;
  final HomeStates state;
  ShaxPiecesPainter(this.homeCubit, {required this.state});
  @override
  void paint(Canvas canvas, Size totalSize) {
    final double aspecrationsimp = totalSize.width / totalSize.height;
    if (aspecrationsimp < 0.65) {
      utils.drawPockets(canvas, totalSize, homeCubit: homeCubit, state: state);
    } else {
      log("not phone");
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
