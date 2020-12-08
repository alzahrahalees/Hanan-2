import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'SpecialistStudentMain.dart';
import 'package:hanan/UI/Specialists/readStudents.dart';


const kCardColor=Color(0xfff4f4f4);

class SpecialistStudentList extends StatefulWidget {


  @override
  _SpecialistStudentListState createState() => _SpecialistStudentListState();
}

class _SpecialistStudentListState extends State<SpecialistStudentList> {

  @override
  Widget build(BuildContext context) {

    var _gender='';
    String _searchString='';
    User user = FirebaseAuth.instance.currentUser;

    return ReadStudents();

  }



}