import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shax_caruur/state_management/home_cubit.dart';

class ScoreShower extends StatelessWidget {
  final double pos;
  const ScoreShower({super.key, required this.pos});

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    return Positioned(
      left: pos,
      top: 0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          '''${homeCubit.score.score.keys.first} ${homeCubit.score.score.values.first}: ${homeCubit.score.score.values.last} ${homeCubit.score.score.keys.last} 
        ''',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
