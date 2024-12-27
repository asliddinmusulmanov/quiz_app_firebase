import 'package:flutter/material.dart';
import 'package:app_quiz/app.dart';
import 'package:app_quiz/setup.dart';

void main() async {
  await setup();
  runApp(const App());
}
