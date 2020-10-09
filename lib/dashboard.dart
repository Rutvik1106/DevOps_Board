import 'package:DevOps_Board/Widgets/active_project_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'Widgets/top_container.dart';
import 'helpers/ColorSys.dart';

class Dashboard extends StatefulWidget {
  String uid;
  //Dashboard({Key key}) : super(key: key);
  Dashboard({this.uid});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: ColorSys.Blue,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final user = snapshot.data;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            for (var doc in user.documents) {
              print('nnnnaaaaammm' + doc.data['name'] + ' ' + widget.uid);
              if (doc.data['uid'] == widget.uid) {
                print('nnnnaaaaammm' + doc.data['name']);
                return Scaffold(
                  //bottomNavigationBar: NavigationBar(),
                  backgroundColor: ColorSys.Gray,
                  body: SafeArea(
                    child: Column(
                      children: <Widget>[
                        TopContainer(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      CircularPercentIndicator(
                                        radius: 90.0,
                                        lineWidth: 5.0,
                                        animation: true,
                                        percent: 0.75,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SingleChildScrollView(
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.60,
                                      width:
                                          MediaQuery.of(context).size.width * 2,
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      child: StreamBuilder(
                                          stream: Firestore.instance
                                              .collection(widget.uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else {
                                              return GridView.builder(
                                                  gridDelegate:
                                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 0.70,
                                                    crossAxisSpacing: 35,
                                                    //mainAxisSpacing: 2
                                                  ),
                                                  itemCount: snapshot
                                                      .data.documents.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    DocumentSnapshot task =
                                                        snapshot.data
                                                            .documents[index];
                                                    print(task['title'] +
                                                        ' ' +
                                                        task.documentID);
                                                    int days = int.parse(
                                                        task['totaldays']
                                                            .toString());
                                                    if (task['date'] !=
                                                        DateTime.now()
                                                            .toString()
                                                            .substring(0, 10)) {
                                                      Firestore.instance
                                                          .collection(
                                                              widget.uid)
                                                          .document(
                                                              task.documentID)
                                                          .setData({
                                                        'title': task['title'],
                                                        'days': task['days'],
                                                        'description':
                                                            task['description'],
                                                        'date': DateTime.now()
                                                            .toString()
                                                            .substring(0, 10),
                                                        'totaldays': days + 1
                                                      });
                                                    }
                                                    double taskcomplated =
                                                        double.parse(
                                                            task['totaldays']
                                                                .toString());
                                                    double totaldays =
                                                        double.parse(
                                                            task['days']
                                                                .toString());
                                                    taskcomplated =
                                                        (taskcomplated /
                                                            totaldays);
                                                    if (taskcomplated <= 1) {
                                                      return ActiveProjectsCard(
                                                        cardColor:
                                                            ColorSys.Blue,
                                                        loadingPercent:
                                                            taskcomplated,
                                                        title: task['title'],
                                                        subtitle:
                                                            task['description'],
                                                      );
                                                    }
                                                  });
                                            }
                                          }))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          }
        });
  }
}
