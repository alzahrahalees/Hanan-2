import 'package:flutter/material.dart';
import '../Constance.dart';
import 'Diaries/TeacherDiaries.dart';
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

  String _searchString ='';

  @override
  Widget build(BuildContext context) {

    User user = FirebaseAuth.instance.currentUser;

    const kCardColor=Color(0xffededed);

    CollectionReference studentsInTeachrs = FirebaseFirestore.instance.collection('Students');


    return Container(
      color: kBackgroundPageColor,
      child: Column(
        children: [
          TextField(
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple,width: 2)),
                contentPadding: EdgeInsets.all(10),
                hintText: "أدخل اسم الطالب",
                prefixIcon: Icon(Icons.search,color: Colors.deepPurple,),
              ),
              onChanged: (string) {
                setState(() {
                  _searchString = string;
                });
              }),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
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
            return ListView.builder(
                physics: ScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  DocumentSnapshot document =snapshot.data.docs[index];
                  String name = document.data()['name'];

              var centerId= document.data()['center'];
               var uid=document.data()['uid'];
               var gender=document.data()['gender'];
               print(user.email);
              print(centerId);
                  if(name.toLowerCase().contains(_searchString) || name.toUpperCase().contains(_searchString.toUpperCase())){
              return Padding(
              padding: const EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 8),
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
                            TeacherStudentMain(
                              uid:document.data()['uid'],
                              centerId: document.data()['center'],
                              name: document.data()['name'],
                              index: 0,
                              teacherName: document.data()['teacherName'],
                              teacherId: document.data()['teacherId'],
                              communicationSpecialistName:document.data()['communicationSpecialistName'] ,
                              communicationSpecialistId: document.data()['communicationSpecialistId'],
                              physiotherapySpecialistId:document.data()['physiotherapySpecialistId'] ,
                              physiotherapySpecialistName:document.data()['physiotherapySpecialistName'] ,
                              psychologySpecialistId:document.data()['psychologySpecialistId'] ,
                              psychologySpecialistName:document.data()['psychologySpecialistName'] ,
                              occupationalSpecialistId: document.data()['occupationalSpecialistId'],
                              occupationalSpecialistName:document.data()['occupationalSpecialistName'] ,
                            ) ));},
            ),
                )
                );}
              else return SizedBox();
            }
            );


              }

              }
            ),
          ),
        ],
      ),
    );
      }
  }

