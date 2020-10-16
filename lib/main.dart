import 'package:DevOps_Board/onBoarding.dart';
import 'package:DevOps_Board/services/auth.dart';
import 'package:DevOps_Board/services/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
//import 'onBoarding.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      //scaffoldBackgroundColor: Colors.white,
      //backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: OnBoarding(),
  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
        value: AuthService().user,
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}


