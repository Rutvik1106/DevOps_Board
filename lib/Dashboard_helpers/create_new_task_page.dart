import 'package:DevOps_Board/Widgets/back_button.dart';
import 'package:DevOps_Board/Widgets/top_container.dart';
import 'package:DevOps_Board/helpers/ColorSys.dart';
import 'package:DevOps_Board/services/database.dart';
import 'package:flutter/material.dart';

class CreateNewTaskPage extends StatefulWidget {
  String uid, id;
  CreateNewTaskPage({this.uid, this.id});
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: ColorSys.Gray,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  _CreateNewTaskPageState createState() => _CreateNewTaskPageState();
}

class _CreateNewTaskPageState extends State<CreateNewTaskPage> {
  String title, description;
  DateTime start, end;

  @override
  void initState() {
    super.initState();
    end = start = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create Work Iteam',
                        style: TextStyle(
                            color: ColorSys.Gray,
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
                          onChanged: (val) {
                            title = val;
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Title',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: ListTile(
                        title: Text(
                          "start ${start.year}-${start.month}-${start.day}",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          DateTime time = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050));
                          if (time != null) {
                            setState(() {
                              start = time;
                            });
                          }
                        },
                      )),
                      SizedBox(width: 40),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "end ${end.year}-${end.month}-${end.day}",
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                          onTap: () async {
                            DateTime time = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050));
                            if (time != null) {
                              setState(() {
                                end = time;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                      //controller: TextEditingController(text: 'initial'),
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
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          //direction: Axis.vertical,
                          alignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          runSpacing: 0,
                          //textDirection: TextDirection.rtl,
                          spacing: 20.0,
                          children: <Widget>[
                            Chip(
                              label: Text("Features"),
                              backgroundColor: ColorSys.kRed,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            Chip(
                              label: Text("User Story"),
                            ),
                            Chip(
                              label: Text("Task"),
                            ),
                            Chip(
                              label: Text("Bug"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
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
                      print('tapped');
                      await DatabaseService(uid: widget.uid, id: widget.id)
                          .updateTodo(
                              title,
                              "${start.year}-${start.month}-${start.day}",
                              "${end.year}-${end.month}-${end.day}",
                              description);
                      print('sucess');
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Text(
                        'Create Work Iteam',
                        style: TextStyle(
                            color: Colors.white,
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
