import 'package:DevOps_Board/helpers/ColorSys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Todo extends StatelessWidget {
  String uid, id;
  Todo({this.uid, this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSys.Gray,
        title: Text("Total task"),
        centerTitle: true,
      ),
      backgroundColor: ColorSys.Gray,
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: StreamBuilder(
            stream: Firestore.instance
                .collection(uid)
                .document(id)
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
                      color: Colors.grey[850],
                      child: ListTile(
                        title: Text(
                          task['title'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          task['description'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
