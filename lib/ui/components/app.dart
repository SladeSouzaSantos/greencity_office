import 'package:flutter/material.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    const primaryColor = Color.fromRGBO(13, 76, 128, 1);
    const primaryColorDarkScheme = Color.fromRGBO(159, 202, 255, 1);
    const primaryColorLightScheme = Color.fromRGBO(8, 97, 164, 1);
    const backgroundColorLightScheme = Color.fromRGBO(255, 251, 255, 1);

    return MaterialApp(
      title: "Greencity Office",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        primaryColorLight: primaryColorLightScheme,
        primaryColorDark: primaryColorDarkScheme,
        backgroundColor: backgroundColorLightScheme,

        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryColorLightScheme
          ),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColorLightScheme)
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor)
          ),
          alignLabelWithHint: true
        ),

        buttonTheme: ButtonThemeData(
          colorScheme: const ColorScheme.light(primary: primaryColor),
          buttonColor: primaryColor,
          splashColor: primaryColorLightScheme,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
        ),

      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
