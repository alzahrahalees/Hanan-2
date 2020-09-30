import 'package:firebase_auth/firebase_auth.dart';

class AUser{

  String uid;
  bool isTeacher=false;
  bool isSpecialist=false;
  bool isParent=false;
  bool isAdmin=false;

  AUser({this.uid,this.isAdmin,this.isParent,this.isSpecialist,this.isTeacher});

}