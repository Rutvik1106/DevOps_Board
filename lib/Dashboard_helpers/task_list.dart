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
  TaskList({this.uid});
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
      body: Padding(
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
                          builder: (context) => CalendarPage(uid: widget.uid)),
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
              subtitle: '5 tasks now. 1 started',
            ),
            SizedBox(
              height: 15.0,
            ),
            TaskColumn(
              icon: Icons.blur_circular,
              iconBackgroundColor: ColorSys.Blue,
              title: 'In Progress',
              subtitle: '1 tasks now. 1 started',
            ),
            SizedBox(height: 15.0),
            TaskColumn(
              icon: Icons.check_circle_outline,
              iconBackgroundColor: ColorSys.Blue,
              title: 'Done',
              subtitle: '18 tasks now. 13 started',
            ),
            SizedBox(height: 15.0),
            RaisedButton(
              child: Text('view'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Todo(uid: widget.uid)),
                );
              },
            ),
            SizedBox(height: 15.0),
            RaisedButton(
              child: Text('add'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateNewTaskPage(
                            uid: widget.uid,
                          )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
