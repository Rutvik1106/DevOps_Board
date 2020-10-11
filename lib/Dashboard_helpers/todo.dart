import 'package:DevOps_Board/helpers/ColorSys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Todo extends StatelessWidget {
  String uid;
  Todo({this.uid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSys.Gray,
      body: Container(
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
                  return Card(
                    child: ListTile(
                      leading: FlutterLogo(),
                      title: Text(task['title']),
                      subtitle: Text(task['description']),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
