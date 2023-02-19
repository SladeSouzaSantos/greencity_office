import 'package:flutter/material.dart';
import 'package:greencity_sustentavel_office/domain/entities/account_entity.dart';
import 'package:greencity_sustentavel_office/domain/usecases/authentication.dart';
import 'package:greencity_sustentavel_office/infra/repositories/repositories.dart';
import 'config.dart';



void main() async{
  await initConfiguration();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greencity Office',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: Theme.of(context).primaryColor,
        child: GestureDetector(
          onTap: () async{
          },
        ),
      ),
    );
  }
}