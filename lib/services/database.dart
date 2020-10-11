import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String uid;
  DatabaseService({this.uid});
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

  Future updateTodo(
      String title, String start, String end, String description) async {
    CollectionReference taskCollection =
        Firestore.instance.collection(uid).document('todo').collection('list');
    return await taskCollection.add({
      'title': title,
      'start': start,
      'end': end,
      'description': description,
      'show': 'no'
    });
  }
}
