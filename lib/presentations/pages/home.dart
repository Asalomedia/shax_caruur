import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shax_caruur/presentations/widgets/board.dart';
import 'package:shax_caruur/state_management/home_cubit.dart';
import 'package:shax_caruur/state_management/home_states.dart';

class Home extends StatefulWidget {
  const new({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeCubit homeCubit;
  late Size size;
  @override
  void initState() {
    super.initState();
    homeCubit = BlocProvider.of<HomeCubit>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.sizeOf(context);
    homeCubit.setSize(size);
    homeCubit.registerPositionsAndPieces();
  }

  @override
  void dispose() {
    homeCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        alignment: Alignment(0, 0),
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: SweepGradient(
            center: Alignment.center,
            colors: [
              Color(0xFFFF007A), // Hot Pink
              Color(0xFF7928CA), // Deep Purple
              Color(0xFFB800FF), // Neon Violet
              Color(0xFFFF007A), // Seamless finish
            ],
            stops: [0.0, 0.35, 0.7, 1.0],
          ),
        ),
        child: BlocBuilder<HomeCubit, HomeStates>(
          builder: (context, state) {
            if (state.runtimeType == InitialState) {
              log("yeey it is initial");
              return stateWidget(state);
            } else if (state.runtimeType == DragingState) {
              log("state is draging");
              return stateWidget(state);
            } else if (state.runtimeType == DragEndState) {
              log("state is dragcancel");
              return stateWidget(state);
            } else {
              log("game ended,${state.currentPlayer} had won");
              state as EndgameState;
              return stateWidget(state);
            }
          },
        ),
      ),
    );
  }

  Widget stateWidget(HomeStates state) {
    return UnconstrainedBox(
      alignment: Alignment.center,
      child: Shaxboardwidget(
        totalSize: size,
        homeCubit: homeCubit,
        state: state,
      ),
    );
  }
}
