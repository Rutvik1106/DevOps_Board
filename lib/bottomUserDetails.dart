import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:DevOps_Board/Widgets/active_project_card.dart';
import 'helpers/ColorSys.dart';

class BottomDetails extends StatefulWidget {
  String uid;
  BottomDetails({this.uid});
  @override
  _BottomDetailsState createState() => _BottomDetailsState();
}

class _BottomDetailsState extends State<BottomDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 390,
        width: MediaQuery.of(context).size.width * 2,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: StreamBuilder(
            stream: Firestore.instance.collection(widget.uid).snapshots(),
            builder: (context, snapshot) {
              // for (int i = 0; i < snapshot.data.documents.length; i++) {
              //   count++;
              // }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70,
                      crossAxisSpacing: 35,
                      //mainAxisSpacing: 2
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot task = snapshot.data.documents[index];
                      print(task['title'] + ' ' + task.documentID);
                      return ActiveProjectsCard(
                        cardColor: ColorSys.Blue,
                        loadingPercent: 0.25,
                        title: task['title'],
                        subtitle: task['description'],
                      );
                    });
              }
            }),
      ),
    );
  }
}
