import 'package:flutter/material.dart';
import '../Constance.dart';
import 'SpecialistStudentMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';


const kCardColor=Color(0xffededed);



class SpecialistStudentList extends StatefulWidget {
  @override
  _SpecialistStudentListState createState() => _SpecialistStudentListState();
}

class _SpecialistStudentListState extends State<SpecialistStudentList> {
  @override
  Widget build(BuildContext context) {



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
      var gender= document.data()['gender'];
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
                child: Icon(Icons.star,
                    color:gender=='ذكر'?Color(0xff7e91cc):Color(0xfff45eff)),
              ),
              onTap: (){Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>
                      SpecialistStudentMain(index: 0,centerId:centerId,name:studentName ,)));},
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

