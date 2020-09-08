import 'package:DevOps_Board/Dashboard_helpers/calendar_page.dart';
import 'package:DevOps_Board/Widgets/task_column.dart';
import 'package:DevOps_Board/helpers/ColorSys.dart';
import 'package:DevOps_Board/helpers/NavigationBar.dart';
import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  TaskList({Key key}) : super(key: key);

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
      // bottomNavigationBar: NavigationBar(),
      backgroundColor: ColorSys.Gray,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
        child: SafeArea(
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
                        MaterialPageRoute(builder: (context) => CalendarPage()),
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
            ],
          ),
        ),
      ),
    );
  }
}
