import 'package:DevOps_Board/Dashboard_helpers/dates_list.dart';
import 'package:DevOps_Board/Widgets/back_button.dart';
import 'package:DevOps_Board/Widgets/calendar_dates.dart';
import 'package:DevOps_Board/Widgets/task_container.dart';
import 'package:DevOps_Board/helpers/ColorSys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'create_new_task_page.dart';

class CalendarPage extends StatelessWidget {
  String uid;
  CalendarPage({this.uid});
  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style: TextStyle(
            fontSize: 20.0, color: Colors.grey[400], letterSpacing: 5),
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
      backgroundColor: ColorSys.Gray,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection(uid)
                .document('todo')
                .collection('list')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot task = snapshot.data.documents[index];
                    print('TIIIIITLEEE' + task['title']);
                    if (task['start'] ==
                            DateTime.now().toString().substring(0, 10) ||
                        task['show'] == 'yes' ||
                        task['end'] ==
                            DateTime.now().toString().substring(0, 10)) {
                      if (task['start'] ==
                          DateTime.now().toString().substring(0, 10)) {
                        CollectionReference taskCollection = Firestore.instance
                            .collection(uid)
                            .document('todo')
                            .collection('list');
                        taskCollection.document(task.documentID).setData({
                          'title': task['title'],
                          'start': task['start'],
                          'end': task['end'],
                          'description': task['description'],
                          'show': 'yes'
                        });
                      }
                      if (task['end'] ==
                          DateTime.now().toString().substring(0, 10)) {
                        CollectionReference taskCollection = Firestore.instance
                            .collection(uid)
                            .document('todo')
                            .collection('list');
                        taskCollection.document(task.documentID).setData({
                          'title': task['title'],
                          'start': task['start'],
                          'end': task['end'],
                          'description': task['description'],
                          'show': 'no'
                        });
                      }
                      return Card(
                        child: ListTile(
                          leading: FlutterLogo(),
                          title: Text(task['title']),
                          subtitle: Text(task['description']),
                        ),
                      );
                    }
                  },
                );
              }
            }),
      ),
    );
  }
}
