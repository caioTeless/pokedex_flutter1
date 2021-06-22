import 'package:flutter/material.dart';
import 'package:pokedex/core/app_const.dart';
import 'package:pokedex/core/app_theme.dart';
import 'package:pokedex/pages/home_page.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      home: _buildPokeSplash(),
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
    );

    //return MaterialApp(
    //  title: kAppTitle,
    //  theme: kAppTheme,
    //  home: HomePage(),
    //  debugShowCheckedModeBanner: false,
    //);
  }

  _buildPokeSplash() {
    return SplashScreenView(
      navigateRoute: HomePage(),
      duration: 5000,
      text: 'Pokedex',
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
        fontFamily: 'Pokemon',
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );
  }
}
