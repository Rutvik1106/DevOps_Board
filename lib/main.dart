import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'onBoarding.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      //scaffoldBackgroundColor: Colors.white,
      //backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: OnBoardingPage(),
  ));
}
