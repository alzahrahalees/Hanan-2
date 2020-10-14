import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminStudent/StudentDetails.dart';

import '../../Constance.dart';

class SpecialistStudents extends StatelessWidget {
  @override
  String uid;
  SpecialistStudents  (String uid) {this.uid=uid;}
  String  Studentname="";

  Widget build(BuildContext context) {
    User userAdmin =  FirebaseAuth.instance.currentUser;
    CollectionReference Specialists =
    FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Admin =
    FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Specialists =
    Admin.doc(userAdmin.email.toLowerCase()).collection('Specialists');
    CollectionReference Admin_Students=Admin.doc(userAdmin.email.toLowerCase()).collection('Students');
    CollectionReference Students = FirebaseFirestore.instance.collection('Students');


    return Scaffold(
        appBar: AppBar(
          title: Text("الطلاب", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body:
        SafeArea(
            child:  StreamBuilder(
                stream:
                Admin_Specialists.doc(uid).collection('Students').snapshots(),
                builder:  (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        alignment: Alignment.topRight,
                        child: ListView(
                            children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                              return Card (
                                  borderOnForeground: true,

                                  child:ListTile(
                                    onTap: (){
                             Navigator.push(
                               context,
                                 MaterialPageRoute(
                                   builder: (context) =>
                                     StudentInfo(document.data()['uid'])));},
                                    title: Text(document.data()['name'],style: kTextPageStyle),

                                  )
                              );
                            }).toList()
                        )
                    ); }
                  else{return Text("no");}
                })) );
  }
}
//     Admin_Teachers.doc(uid).collection("Students").get().then((value) {
//           value.docs.forEach((element) {
//           Admin_Students.doc(element.data()['uid']).snapshots()
//           });
//           }),

// Admin_Students.doc(document.data()['uid']).get().then((value) {
//                       Studentname=value.data()['name'];
//
//                   } );