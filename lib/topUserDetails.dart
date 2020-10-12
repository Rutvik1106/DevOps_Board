import 'package:flutter/material.dart';
import 'Widgets/top_container.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:DevOps_Board/Widgets/active_project_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'helpers/ColorSys.dart';

class TopContainerUser extends StatefulWidget {
  String uid;
  TopContainerUser({this.uid});
  @override
  _TopContainerUserState createState() => _TopContainerUserState();
}

class _TopContainerUserState extends State<TopContainerUser> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: StreamBuilder(
          stream: Firestore.instance.collection('users').snapshots(),
          //initialData: initialData ,

          builder: (BuildContext context, AsyncSnapshot snapshot) {
            final user = snapshot.data;
            if (snapshot.hasData) {
              for (var doc in user.documents) {
                if (doc.data['uid'] == widget.uid) {
                  return TopContainer(
                    height: 200,
                    width: width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          //     Icon(Icons.menu, color: Colors.white, size: 30.0),
                          //     //Icon(Icons.search, color: Colors.white, size: 25.0),
                          //   ],
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                CircularPercentIndicator(
                                  radius: 90.0,
                                  lineWidth: 5.0,
                                  animation: true,
                                  percent: 0.75,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: Colors.white,
                                  backgroundColor: ColorSys.Blue,
                                  center: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 35.0,
                                    backgroundImage: AssetImage(
                                      'assets/images/avatar.png',
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 25,
                                      child: Text(
                                        doc.data['name'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      child: Text(
                                        'App Developer',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
                  );
                } else {
                  return Container();
                }
              }
            } else {
              return Container();
            }
          }),
    );
  }
}
