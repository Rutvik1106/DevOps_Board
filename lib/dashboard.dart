import 'package:DevOps_Board/Dashboard_helpers/task_list.dart';
import 'package:DevOps_Board/Widgets/active_project_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  int totaltask, complete, remain;
  double per;
  @override
  void initState() {
    getdata();
  }

  updatecomplete() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      complete++;
      per = complete / totaltask;
      pref.setInt('complete', complete);
      print("complete::: $complete perrrrr $per");
    });
  }

  getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      totaltask = pref.getInt('totaltask');
      complete = pref.getInt('complete');
      remain = pref.getInt('remain');
      if (totaltask == null) {
        totaltask = 0;
        pref.setInt('totaltask', 0);
      }
      if (complete == null) {
        complete = 0;
        print("complete::: $complete");
        pref.setInt('complete', 0);
      }
      if (remain == null) {
        remain = 0;
        pref.setInt('remain', 0);
      }
      if (totaltask == 0) {
        per = 0;
      } else {
        per = complete / totaltask;
      }
    });
  }

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
              print('nnnnaaaaammm' +
                  doc.data['name'] +
                  ' ' +
                  widget.uid +
                  ' totaltask $totaltask  complete $complete');
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
                                        percent: per,
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
                                                color: Colors.black,
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
                                                color: Colors.black,
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
                                                    String setstate =
                                                        task['setstate'];
                                                    int days = int.parse(
                                                        task['totaldays']
                                                            .toString());
                                                    if (task['date'] !=
                                                            DateTime.now()
                                                                .toString()
                                                                .substring(
                                                                    0, 10) &&
                                                        task['setstate'].contains('yes')
                                                            ) {
                                                      print("dayssss" +
                                                          days.toString());
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
                                                        'totaldays': days + 1,
                                                        'setstate': setstate
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
                                                    if (taskcomplated >= 1) {
                                                      taskcomplated = 1;
                                                      if (task['setstate'] ==
                                                          'yes') {
                                                        Firestore.instance
                                                            .collection(
                                                                widget.uid)
                                                            .document(
                                                                task.documentID)
                                                            .setData({
                                                          'title':
                                                              task['title'],
                                                          'days': task['days'],
                                                          'description': task[
                                                              'description'],
                                                          'date': DateTime.now()
                                                              .toString()
                                                              .substring(0, 10),
                                                          'totaldays':
                                                              task['totaldays'],
                                                          'setstate': 'No'
                                                        });
                                                        updatecomplete();
                                                      }
                                                    }
                                                    return Container(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          TaskList(
                                                                            uid:
                                                                                widget.uid,
                                                                            id: task.documentID,
                                                                            setstate:
                                                                                task['setstate'],
                                                                            date:
                                                                                task['date'],
                                                                            days:
                                                                                task['days'].toString(),
                                                                            description:
                                                                                task['description'],
                                                                            title:
                                                                                task['title'],
                                                                            totaldays:
                                                                                task['totaldays'].toString(),
                                                                          )));
                                                        },
                                                        child:
                                                            ActiveProjectsCard(
                                                          cardColor:
                                                              Colors.grey[850],
                                                          loadingPercent:
                                                              taskcomplated,
                                                          title: task['title'],
                                                          subtitle: task[
                                                              'description'],
                                                        ),
                                                      ),
                                                    );
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
