import 'package:DevOps_Board/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: deprecated_member_use
      FirebaseUser user = result.user;
      return user;
    } catch(e) {
      print(e);
    }
  }
  // register with email and password
  Future registerWithEmailAndPassword(String email, String password,String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(name, email);
      return user;
    } catch(e) {
      print(e);
    }
  }

  // sign out
  Future logout() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e);
    }
  }
  //stream
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }
}