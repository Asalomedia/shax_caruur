import 'package:flutter_test/flutter_test.dart';
import 'package:shax_caruur/models/position.dart';
import 'package:shax_caruur/state_management/home_cubit.dart';
import 'package:shax_caruur/state_management/home_states.dart'
    show InitialState;

late HomeCubit homeCubit;
late List<Position> mockpositons;
void main() {
  setUp(() {
    homeCubit = HomeCubit();
    mockpositons = [
      Position(positionId: 23, coordinate: Offset(0, 0)),
      Position(positionId: 2, coordinate: Offset(0, 1)),
    ];
  });
  group("home cubit", () {
    test("home cubit state", () {
      expect(homeCubit.state, isA<InitialState>());
    });
    test("test if all required positions is gotten", () {
      homeCubit.registerImportantPositions(mockpositons);
      expect(homeCubit.positions.length, mockpositons.length);
    });
  });
}
