import 'package:flutter/material.dart';
import '../Constance.dart';
import 'TeacherStudentMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class TeacherStudentList extends StatefulWidget {
  @override
  _TeacherStudentListState createState() => _TeacherStudentListState();
}

class _TeacherStudentListState extends State<TeacherStudentList> {
  @override
  Widget build(BuildContext context) {

    User user = FirebaseAuth.instance.currentUser;
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
      var gender= document.data()['gender'];
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
                    color:gender=='ذكر'?Color(0xff7e91cc):Color(0xffdb9bd2)),
              ),
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>
                      TeacherStudentMain(
                        index: 0,
                        centerId:document.data()['center'],
                        name:document.data()['name'],
                        studentId:document.id
                        ,)
                  )
              );
                print(document.id);
                },
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

