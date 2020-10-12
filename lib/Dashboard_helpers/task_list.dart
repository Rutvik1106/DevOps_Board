import 'package:DevOps_Board/Dashboard_helpers/calendar_page.dart';
import 'package:DevOps_Board/Dashboard_helpers/create_new_task_page.dart';
import 'package:DevOps_Board/Dashboard_helpers/todo.dart';
import 'package:DevOps_Board/Widgets/task_column.dart';
import 'package:DevOps_Board/helpers/ColorSys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  //TaskList({Key key}) : super(key: key);
  String uid;
  String id;
  TaskList({this.uid, this.id});
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSys.Gray,
        title: Text("Today's Task"),
        centerTitle: true,
      ),
      // bottomNavigationBar: NavigationBar(),
      backgroundColor: ColorSys.Gray,
      body: StreamBuilder(
          stream: Firestore.instance
              .collection(widget.uid)
              .document(widget.id)
              .collection('list')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              int total = snapshot.data.documents.length;
              int run, done;
              run = 0;
              done = 0;
              for (var doc in snapshot.data.documents) {
                if (doc['done'] == 'yes') {
                  done++;
                }
                if (doc['show'] == 'yes') {
                  run++;
                }
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        subheading('My Tasks'),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CalendarPage(
                                        uid: widget.uid,
                                        id: widget.id,
                                      )),
                            );
                          },
                          child: calendarIcon(),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    TaskColumn(
                      icon: Icons.alarm,
                      iconBackgroundColor: ColorSys.Blue,
                      title: 'To Do',
                      subtitle: '$total tasks now',
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TaskColumn(
                      icon: Icons.blur_circular,
                      iconBackgroundColor: ColorSys.Blue,
                      title: 'In Progress',
                      subtitle: '$run tasks started',
                    ),
                    SizedBox(height: 15.0),
                    TaskColumn(
                      icon: Icons.check_circle_outline,
                      iconBackgroundColor: ColorSys.Blue,
                      title: 'Done',
                      subtitle: '$done task finished',
                    ),
                    SizedBox(height: 15.0),
                    RaisedButton(
                      color: ColorSys.Blue,
                      child: Text(
                        'view',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Todo(uid: widget.uid, id: widget.id)),
                        );
                      },
                    ),
                    SizedBox(height: 15.0),
                    RaisedButton(
                      color: ColorSys.Blue,
                      child: Text(
                        'add',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateNewTaskPage(
                                  uid: widget.uid, id: widget.id)),
                        );
                      },
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
