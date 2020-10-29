import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Teachers/readPostNotification.dart';
import '../Constance.dart';


class notifications extends StatefulWidget {
  @override
  _notificationsState createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  User userTeacher = FirebaseAuth.instance.currentUser;
  CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
  CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
  String PostId;
  String NotificationUid;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("التعليقات", style: kTextAppBarStyle),
         centerTitle: true,
         backgroundColor: Colors.white70,
       ),
        body: StreamBuilder<QuerySnapshot>(
      stream: Teachers.doc(userTeacher.email).collection('Notifications').orderBy('createdAt',descending: true).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData)
    return Center(child: SpinKitFoldingCube(
    color: kUnselectedItemColor,
    size: 60,
    ),
    );
    else {
    return ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    children: [
    Column(
    children: snapshot.data.docs
        .map((DocumentSnapshot document) {
          PostId=document.data()['postId'];
          NotificationUid=document.data()['NotificationUid'];
          String Writer=document.data()['writer'];
    return Column(
    children: [
    Container(
    decoration: BoxDecoration(
    color: document.data()['read']==true? Colors.grey.shade100:Colors.deepPurple.shade50,
      border: Border.all(width: 0,color: Colors.grey),),
      padding: EdgeInsets.all(20),
      child: ListTile(
      title: Text("$Writer أضاف تعليق ",style: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
          decorationStyle: TextDecorationStyle.dotted,
          fontWeight: FontWeight.bold)),
       trailing: Text(document.data()['hour'].toString() + ":" + document.data()['minute'].toString() + " " + document.data()['time'],
      style: TextStyle(fontSize: 9, color: Colors.grey)),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => OnePostNot(postId: document.data()['postId'],notificationId: document.data()['NotificationUid'],
          centerId: document.data()['centerId'], studentId: document.data()['uid'],teacherName: document.data()[''],)),);

          Teachers.doc(userTeacher.email).collection('Notifications').doc(document.data()['NotificationUid']).update({
             'read':true,
          });
          Admin.doc(document.data()['centerId']).collection('Teachers').doc(userTeacher.email).collection('Notifications').doc(document.data()['NotificationUid']).update({
            'read':true,
          });
        },
      ),
    ),
    ],
    );
    }).toList()),
    ]);
    }}),
    );
  }
}
