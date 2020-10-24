import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ShowComments extends StatefulWidget {
  final String uid;
  final String centerId;
  final String name;
  final String postId;
  ShowComments ({this.uid,this.centerId,this.name,this.postId});
  @override
  _ShowComments createState() => _ShowComments(uid,centerId,name,postId);
}

class _ShowComments extends State<ShowComments> {
  void initState() {
    super.initState();
  }

  String uid;
  String centerId;
  String name;
  String postId;
  _ShowComments(String uid, String centerId ,String name, String postId) {
    this.uid=uid;
    this.centerId=centerId;
    this.name=name;
    this.postId=postId;
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference Students =
    FirebaseFirestore.instance.collection('Students');
    CollectionReference Teachers =
    FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Admin =
    FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Teachers =
    Admin.doc(centerId).collection('Teachers');
    CollectionReference Admin_Students =
    Admin.doc(centerId).collection('Students');
  return Scaffold(
    appBar: AppBar(
      title: Text("التعليقات"),
    ),

      body: StreamBuilder<QuerySnapshot>(
          stream: Admin_Students.doc(uid).collection('Posts').doc(postId).collection('Comments').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData){
              return ListView(
                  children:
                  snapshot.data.docs.map((DocumentSnapshot document) {
                    return
                      Card(
                          child: ListTile(
                            title: Text(document.data()['comment'],style: TextStyle(fontSize: 15,color: Colors.black),),
                          ));
                  }).toList()
              );}
            else{return Text("");}
          }
      ),
    );
  }
}