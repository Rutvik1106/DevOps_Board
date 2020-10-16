import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  String uid, id;
  DatabaseService({this.uid, this.id});
  //user collection ref
  CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String name, String email) async {
    return await userCollection
        .document(uid)
        .setData({'name': name, 'uid': uid, 'email': email});
  }

  //task collection ref

  Future updateTask(String title, String days, String description) async {
    String startingdate = DateTime.now().toString().substring(0, 10);
    CollectionReference taskCollection = Firestore.instance.collection(uid);
    return await taskCollection.add({
      'title': title,
      'days': days,
      'description': description,
      'date': startingdate,
      'totaldays': 0,
      'setstate': 'yes'
    });
  }

  Future update(String title, String days, String description, String date,
      String totaldays, String setstate) async {
    String startingdate = DateTime.now().toString().substring(0, 10);
    CollectionReference taskCollection = Firestore.instance.collection(uid);
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (setstate == 'No') {
      pref.setInt('complete', pref.getInt('complete') - 1);
      setstate = 'yes';
    }
    return await taskCollection.document(id).setData({
      'title': title,
      'days': days,
      'description': description,
      'date': startingdate,
      'totaldays': totaldays,
      'setstate': setstate
    });
  }

  Future updateTodo(
      String title, String start, String end, String description) async {
    CollectionReference taskCollection =
        Firestore.instance.collection(uid).document(id).collection('list');
    return await taskCollection.add({
      'title': title,
      'start': start,
      'end': end,
      'description': description,
      'show': 'no',
      'done': 'no'
    });
  }

  Future deleteTask() {
    CollectionReference taskCollection = Firestore.instance.collection(uid);
    return taskCollection.document(id).delete();
  }
}
