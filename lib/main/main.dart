import 'package:flutter/material.dart';
import '../ui/components/components.dart';
import 'config.dart';

void main() async{
  await initConfiguration();

  runApp(const App());
}