import 'package:flutter/material.dart';
import '../Constance.dart';
import 'TeacherStudentMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';


const kCardColor=Color(0xffededed);



class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {

    List<Color> colors=[Color(0xff7e91cc),Color(0xffe8dc04),
    Color(0xffe89004),Color(0xfff45eff)];

    User user = FirebaseAuth.instance.currentUser;
    CollectionReference studentsInTeachrs = FirebaseFirestore.instance.collection('Teachers')
    .doc(user.email).collection('Students');

    return StreamBuilder<QuerySnapshot>(
      stream: studentsInTeachrs.snapshots(),
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
      var studentName= document.data()['name'];
      Random ran= Random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 8),
        child: Card(
          color: kCardColor,
            borderOnForeground: true,
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.star,color: colors[ran.nextInt(4)]),
              ),
              onTap: (){Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>
                      TeacherStudentMain(index: 0,centerId:centerId,name:studentName ,)));},
              title: Text(document.data()['name'], style: kTextPageStyle),

        )
        ),
      ),
    )
    ;}
    ).toList()
    );
    }} );
      }
  }

