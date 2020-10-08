import 'package:DevOps_Board/helpers/ColorSys.dart';
import 'package:DevOps_Board/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  //UserProfile({Key key}) : super(key: key);
  String uid;
  UserProfile({this.uid});
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final user = snapshot.data;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            for (var doc in user.documents) {
              if (doc.data['uid'] == widget.uid) {
                return Scaffold(
                  backgroundColor: ColorSys.Gray,
                  body: Container(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(
                          height: 250,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              topBar(250),
                              Positioned(
                                top: 200,
                                child: Container(
                                  width: width * 0.9,
                                  margin:
                                      EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 25,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  25.0, 25.0, 50.0, 25.0),
                                              child: Image(
                                                  height: 55,
                                                  width: 55,
                                                  image: AssetImage(
                                                      'assets/images/avatar.png')),
                                            ),
                                            SizedBox(
                                              width: 100.0,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  100.0, 37.0, 25.0, 25.0),
                                              child: Text(
                                                doc.data['name'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              height: height * 0.3,
                              child: Card(
                                elevation: 25,
                                borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                margin:
                                    EdgeInsets.fromLTRB(25.0, 100.0, 25.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          //color: Colors.white,
                                          height: 70,
                                          margin: EdgeInsets.fromLTRB(
                                              10.0, 10.0, 10.0, 0.0),
                                          child: ListTile(
                                            leading: Icon(Icons.email),
                                            title: Text(
                                                doc.data['email'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Montserrat',
                                                )),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 80),
                                            height: 40.0,
                                            width: 160,
                                            alignment: Alignment.center,
                                            color: Colors.transparent,
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      style: BorderStyle.solid,
                                                      width: 1.0),
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              child: InkWell(
                                                onTap: () {
                                                  AuthService().logout();
                                                },
                                                child: Center(
                                                  child: Text(
                                                    'Logout',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            }
          }
        });
  }

  Container topBar(double height) {
    return Container(
      height: height,
      width: double.infinity,
      color: ColorSys.Gray,
      child: Center(
        child: Text(
          'Profile',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              fontSize: 25,
              letterSpacing: 1),
        ),
      ),
    );
  }
}
