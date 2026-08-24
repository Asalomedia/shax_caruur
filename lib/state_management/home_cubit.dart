import 'package:flutter/material.dart' show Offset;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shax_caruur/models/position.dart';

import 'package:shax_caruur/state_management/home_states.dart'
    show HomeStates, InitialState;

class HomeCubit extends Cubit<HomeStates> {
  final Set<Position> positions = {};
  final Set<Piece> pieces = {};
  HomeCubit() : super(InitialState());

  void registerImportantPositions(List<Position> actualpos) {
    positions.addAll(actualpos);
  }

  void registerPieces(List<Piece> orginalpiecel) {
    pieces.addAll(orginalpiecel);
  }

  void updatePieceLocation(Piece p, Offset newLocation) {}
  void spanPieceLocation(Piece p, Position position) {}
}
