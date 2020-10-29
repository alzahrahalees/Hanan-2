import 'package:flutter/material.dart';
import '../Constance.dart';
import 'TeacherDiaries.dart';
import 'TeacherStudentMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dart:math';



class TeacherStudentList extends StatefulWidget {
  @override
  _TeacherStudentListState createState() => _TeacherStudentListState();
}

class _TeacherStudentListState extends State<TeacherStudentList> {
  @override
  Widget build(BuildContext context) {

    User user = FirebaseAuth.instance.currentUser;

    const kCardColor=Color(0xffededed);

    CollectionReference studentsInTeachrs = FirebaseFirestore.instance.collection('Students');


    return StreamBuilder<QuerySnapshot>(
      stream: studentsInTeachrs.where('teacherId',isEqualTo: user.email).snapshots(),
        builder: ( context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: SpinKitFoldingCube(
                color: kUnselectedItemColor,
                size: 60,
              ),
            );
          switch (snapshot.connectionState) {
    case ConnectionState.waiting:
    return Center(child: SpinKitFoldingCube(
    color: kUnselectedItemColor,
    size: 60,
    )
    ,);
    default:
    return ListView(
    children: snapshot.data.docs.map((DocumentSnapshot document) {

      var centerId= document.data()['center'];
       var uid=document.data()['uid'];
       var gender=document.data()['gender'];
       print(user.email);
      print(centerId);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 8),
        child: Card(
          color: kCardColor,
            borderOnForeground: true,
            child: ListTile(
              title: Text(document.data()['name'],style: kTextPageStyle),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.star,

                    color:gender=='ذكر'?Color(0xff7e91cc):Color(0xfff45eff)),),
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>
                      TeacherStudentMain(uid:document.data()['uid'],centerId: document.data()['center'],name: document.data()['name'],index: 0,teacherName: document.data()['teacherName'],teacherId: document.data()['teacherId'],) ));},
    ),


          )
          ),
        );

    }
    ).toList()

      )
      ;}

      }
    );
      }
  }

