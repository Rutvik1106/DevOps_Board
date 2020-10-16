import 'package:DevOps_Board/services/auth.dart';
import 'package:flutter/material.dart';
import 'helpers/ColorSys.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, password, name;
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ColorSys.Gray,
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (val) {
                    name = val;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[500]),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: ColorSys.gray,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (val) {
                    email = val;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[500]),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: ColorSys.gray,
                    ),
                  ),
                ),
                SizedBox(
                  //height: 20.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (val) {
                    password = val;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[500]),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: ColorSys.gray,
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 50.0,
                ),

                Container(
                  height: 60.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(35.0),
                    shadowColor: ColorSys.secoundry,
                    color: Colors.purple[600],
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        _auth.registerWithEmailAndPassword(email, password);

                    

                         Navigator.pop(context);
                      },

                GestureDetector(
                  onTap: () {
                    print("tapped");
                    _auth.registerWithEmailAndPassword(email, password, name);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 60.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(35.0),
                      shadowColor: ColorSys.secoundry,
                      color: Colors.purple[600],
                      elevation: 7.0,

                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 60.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Text('Go Back',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
