import 'package:DevOps_Board/onBoarding.dart';
import 'package:DevOps_Board/services/auth.dart';
import 'package:DevOps_Board/services/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
//import 'onBoarding.dart';
void main() => runApp(MyApp());

<<<<<<< HEAD
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
//gsggdgeggeeegeg;
=======
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
        value: AuthService().user,
        child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

>>>>>>> b1e38b819bcef9a9dfbc47e1303133ce511a1c7b
