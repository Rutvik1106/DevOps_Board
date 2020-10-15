import 'package:DevOps_Board/Dashboard_helpers/calendar_page.dart';
import 'package:DevOps_Board/Dashboard_helpers/create_new_task_page.dart';
import 'package:DevOps_Board/Dashboard_helpers/todo.dart';
import 'package:DevOps_Board/Widgets/task_column.dart';
import 'package:DevOps_Board/helpers/ColorSys.dart';
import 'package:DevOps_Board/services/database.dart';
import 'package:DevOps_Board/updatetask.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskList extends StatefulWidget {
  //TaskList({Key key}) : super(key: key);
  String uid;
  String id;
  String setstate;
  String title, days, description, date, totaldays;
  TaskList(
      {this.uid,
      this.id,
      this.setstate,
      this.title,
      this.date,
      this.days,
      this.description,
      this.totaldays});
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => updateTask(
                                          uid: widget.uid,
                                          id: widget.id,
                                          title: widget.title,
                                          days: widget.days,
                                          description: widget.description,
                                          totaldays: widget.totaldays,
                                          setstate: widget.setstate,
                                          date: widget.date,
                                        )));
                          },
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: ColorSys.Blue,
                            child: Icon(
                              Icons.edit,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await DatabaseService(
                                    uid: widget.uid, id: widget.id)
                                .deleteTask();
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setInt(
                                'totaltask', pref.getInt('totaltask') - 1);
                            if (widget.setstate == 'No') {
                              pref.setInt(
                                  'complete', pref.getInt('complete') - 1);
                            }
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: ColorSys.Blue,
                            child: Icon(
                              Icons.delete,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ),
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
