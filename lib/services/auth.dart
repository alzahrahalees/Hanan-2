
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanan/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  AUser _userFromFirebaseUser(User user){//,bool isTeacher,  bool isSpecialist,  bool isParent,  bool isAdmin) {
    return user != null ? AUser(uid: user.uid) : null;
  }

  // auth change user stream
  // Stream<User> get user {
  //   return _auth.onAuthStateChanged
  //   //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  //       .map(_userFromFirebaseUser);
  // }

  // sign in anon
  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
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
  Future registerWithEmailAndPassword({String email, String password})async{ //, bool isTeacher,  bool isSpecialist,  bool isParent,  bool isAdmin}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // create a new document for the user with the uid
      // await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      return _userFromFirebaseUser(user);//,isTeacher,isSpecialist,isParent,isAdmin);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

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