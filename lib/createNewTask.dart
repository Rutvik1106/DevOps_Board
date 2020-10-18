import 'package:DevOps_Board/Widgets/back_button.dart';
import 'package:DevOps_Board/Widgets/my_text_field.dart';
import 'package:DevOps_Board/Widgets/top_container.dart';
import 'package:DevOps_Board/dashboard.dart';
import 'package:DevOps_Board/helpers/ColorSys.dart';
import 'package:DevOps_Board/services/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewTask extends StatefulWidget {
  //CreateNewTask({Key key}) : super(key: key);
  String uid;
  CreateNewTask({this.uid});

  @override
  _CreateNewTaskState createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: ColorSys.Gray,
      child: GestureDetector(
        child: Icon(
          Icons.calendar_today,
          size: 20.0,
          color: Colors.white,
        ),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String title, description, days;
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: ColorSys.Gray,
    );
    return Scaffold(
      backgroundColor: ColorSys.Gray,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create New Project',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                          style: TextStyle(color: Colors.black),
                          minLines: 1,
                          onChanged: (val) {
                            title = val;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "title",
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                                style: TextStyle(color: Colors.black),
                                minLines: 1,
                                maxLines: 1,
                                onChanged: (val) {
                                  days = val;
                                },
                                decoration: InputDecoration(
                                  labelText: "Days",
                                  labelStyle: TextStyle(color: Colors.black),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            SizedBox(height: 40),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextField(
                      onChanged: (val) {
                        description = val;
                      },
                      style: TextStyle(color: Colors.white),
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      )),
                  SizedBox(height: 30),
                ],
              ),
            )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      int totaltask;
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      totaltask = pref.getInt('totaltask');
                      if (totaltask == null)
                        totaltask = 0;
                      else {
                        print(totaltask);
                      }
                      totaltask++;
                      pref.setInt('totaltask', totaltask);
                      print('tapped');
                      await DatabaseService(uid: widget.uid)
                          .updateTask(title, days, description);
                      print('sucess');
                    },
                    child: Container(
                      child: Text(
                        'Create New Project',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Subway',
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width - 40,
                      decoration: BoxDecoration(
                        color: ColorSys.Blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
