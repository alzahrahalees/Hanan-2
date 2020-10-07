
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanan/user.dart';
import 'database.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void authStat(){
    _auth.authStateChanges().listen((User user) {
      if (user== null){
        print('user now is signed ou');
      }
      else{
        print('user now is signed in');
      }
    });
  }

  // create user obj based on firebase user
  AUser _userFromFirebaseUser(User user){//,bool isTeacher,  bool isSpecialist,  bool isParent,  bool isAdmin) {
    return user != null ? AUser(uid: user.uid) : null;
  }

  Future deleteUser(String email, String password, dynamic uid) async {
    try{
     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
     User user=userCredential.user;
      AuthCredential credentials =
      EmailAuthProvider.credential(email: email, password: password);
      print(user);
      var result = await user.reauthenticateWithCredential(credentials); // called from database class
      await result.user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  // auth change user stream
  // Stream<User> get user {
  //   return _auth.onAuthStateChanged
  //   //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  //       .map(_userFromFirebaseUser);
  // }


  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
 /* Future registerWithEmailAndPassword({String email, String password})async{ //, bool isTeacher,  bool isSpecialist,  bool isParent,  bool isAdmin}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // create a new document for the user with the uid
      // await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      return user; //isTeacher,isSpecialist,isParent,isAdmin);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }*/

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}