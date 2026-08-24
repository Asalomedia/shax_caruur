import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shax_caruur/presentations/widgets/shaxBoardWidget.dart';
import 'package:shax_caruur/state_management/home_cubit.dart';
import 'package:shax_caruur/state_management/home_states.dart';

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
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.runtimeType == InitialState) {
              log("yeey it is initial");
              state as InitialState;
              return init();
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget init() {
    return LayoutBuilder(
      builder: (context, constraint) {
        return UnconstrainedBox(
          alignment: Alignment.center,
          child: Shaxboardwidget(constraint: constraint),
        );
      },
    );
  }
}
