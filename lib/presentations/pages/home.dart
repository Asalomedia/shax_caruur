import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shax_caruur/presentations/widgets/shaxBoardWidget.dart';
import 'package:shax_caruur/state_management/home_cubit.dart';
import 'package:shax_caruur/state_management/home_states.dart';

class Home extends StatefulWidget {
  const new({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeCubit homeCubit;
  @override
  void initState() {
    super.initState();
    homeCubit = BlocProvider.of<HomeCubit>(context);
  }

  @override
  void dispose() {
    homeCubit.dispose();
    super.dispose();
  }

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
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
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
    return LayoutBuilder(
      builder: (context, constraint) {
        return UnconstrainedBox(
          alignment: Alignment.center,
          child: Shaxboardwidget(
            constraint: constraint,
            homeCubit: homeCubit,
            state: state,
          ),
        );
      },
    );
  }
}
