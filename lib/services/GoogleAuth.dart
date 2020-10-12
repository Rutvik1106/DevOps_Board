import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();

Future<bool> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();
  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credentials = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    AuthResult result = await auth.signInWithCredential(credentials);

    FirebaseUser user = await auth.currentUser();
    print(user.uid);
    print(googleSignInAccount.email);
    print(googleSignInAccount.displayName);
    DatabaseService(uid: user.uid).updateUserData(user.displayName, user.email);
    return Future.value(true);
  }
}
