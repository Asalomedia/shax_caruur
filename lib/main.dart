import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shax_caruur/presentations/pages/home.dart' show Home;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shax_caruur/state_management/home_cubit.dart';

void main() {
  log("Bismillah");
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => HomeCubit())],
      child: ShaxApp(),
    ),
  );
}

class ShaxApp extends StatelessWidget {
  const ShaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}
