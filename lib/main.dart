import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shax_caruur/home.dart' show Home;

void main() {
  log("Bismillah");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}
