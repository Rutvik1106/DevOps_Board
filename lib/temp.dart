import 'package:DevOps_Board/Dashboard_helpers/calendar_page.dart';
import 'package:DevOps_Board/Dashboard_helpers/task_list.dart';
import 'package:DevOps_Board/Widgets/active_project_card.dart';
import 'package:DevOps_Board/helpers/NavigationBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'Widgets/task_column.dart';
import 'Widgets/top_container.dart';
import 'helpers/ColorSys.dart';

class Dashboard extends StatefulWidget {
  //Dashboard({Key key}) : super(key: key);
  String uid;
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
          if(snapshot.hasData)
          for (var doc in user.documents) {
            if (doc.data['uid'] == widget.uid) {
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Column(
                                    //children: <Widget>[
                                    // Row(
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: <Widget>[
                                    //     subheading('My Tasks'),
                                    //     GestureDetector(
                                    //       onTap: () {
                                    //         Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) => CalendarPage()),
                                    //         );
                                    //       },
                                    //       child: calendarIcon(),
                                    //     ),
                                    //   ],
                                    // ),
                                    //   SizedBox(height: 15.0),
                                    //   TaskColumn(
                                    //     icon: Icons.alarm,
                                    //     iconBackgroundColor: ColorSys.Blue,
                                    //     title: 'To Do',
                                    //     subtitle: '5 tasks now. 1 started',
                                    //   ),
                                    //   SizedBox(
                                    //     height: 15.0,
                                    //   ),
                                    //   TaskColumn(
                                    //     icon: Icons.blur_circular,
                                    //     iconBackgroundColor:  ColorSys.Blue,
                                    //     title: 'In Progress',
                                    //     subtitle: '1 tasks now. 1 started',
                                    //   ),
                                    //   SizedBox(height: 15.0),
                                    //   TaskColumn(
                                    //     icon: Icons.check_circle_outline,
                                    //     iconBackgroundColor: ColorSys.Blue,
                                    //     title: 'Done',
                                    //     subtitle: '18 tasks now. 13 started',
                                    //   ),
                                    // ],
                                    ),
                              ),
                              Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    subheading('Active Projects'),
                                    SizedBox(height: 5.0),
                                    GestureDetector(
                                      child: Row(
                                        children: <Widget>[
                                          ActiveProjectsCard(
                                            cardColor: ColorSys.Blue,
                                            loadingPercent: 0.25,
                                            title: 'Mad Project',
                                            subtitle: '9 hours progress',
                                          ),
                                          SizedBox(width: 20.0),
                                          ActiveProjectsCard(
                                            cardColor: ColorSys.Blue,
                                            loadingPercent: 0.6,
                                            title: 'Making History Notes',
                                            subtitle: '20 hours progress',
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return TaskList();
                                        }));
                                      },
                                    ),
                                    GestureDetector(
                                      child: Row(
                                        children: <Widget>[
                                          ActiveProjectsCard(
                                            cardColor: ColorSys.Blue,
                                            loadingPercent: 0.45,
                                            title: 'Sports App',
                                            subtitle: '5 hours progress',
                                          ),
                                          SizedBox(width: 20.0),
                                          ActiveProjectsCard(
                                            cardColor: ColorSys.Blue,
                                            loadingPercent: 0.9,
                                            title: 'Online Flutter Course',
                                            subtitle: '23 hours progress',
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return TaskList();
                                        }));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        });
  }
}
