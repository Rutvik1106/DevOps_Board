import 'package:DevOps_Board/dashboard.dart';
import 'package:DevOps_Board/services/GoogleAuth.dart';
import 'package:DevOps_Board/services/auth.dart';
import 'package:DevOps_Board/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'helpers/ColorSys.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  String email, password;
  bool _obsecure = true;
  TextEditingController etEmail = new TextEditingController();
  TextEditingController etPassword = new TextEditingController();
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSys.Gray,
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'Hello',
                      style: TextStyle(
                        fontSize: 80.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                    child: Text(
                      'There',
                      style: TextStyle(
                        fontSize: 80.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: etEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter Email Adderss';
                      } else {
                        setState(() {
                          email = etEmail.text;
                        });
                      }
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
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: etPassword,
                    style: TextStyle(color: Colors.white),
                    onChanged: (val) {
                      password = val;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obsecure = !_obsecure;
                          });
                        },
                      ),
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
                    obscureText: _obsecure,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter Password';
                      } else {
                        password = etPassword.text;
                      }
                    },
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        await _auth.signInWithEmailAndPassword(email, password);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 60.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(35.0),
                        // shadowColor: ColorSys.secoundry,
                        color: Colors.purple[600],
                        elevation: 0.0,
                        child: Center(
                          child: Text(
                            'LOGIN',
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
                    child: GestureDetector(
                      onTap: () {
                        googleSignIn();
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1.0),
                          // color: Colors.transparent,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: ImageIcon(
                                  AssetImage('assets/icons/google.png')),
                            ),
                            SizedBox(width: 10.0),
                            Center(
                              child: Text(
                                'Login With Google',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New To app ?',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUp();
                  }));
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.purple[600],
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
