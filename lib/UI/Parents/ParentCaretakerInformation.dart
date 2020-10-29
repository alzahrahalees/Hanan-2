import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Parents/TeacherInfo.dart';
import '../Constance.dart';
import 'SpecialistInfo.dart';

class ParentCaretakerInformation extends StatefulWidget {
  @override
  _ParentCaretakerInformationState createState() => _ParentCaretakerInformationState();
}

class _ParentCaretakerInformationState extends State<ParentCaretakerInformation> {
  @override
  Widget build(BuildContext context){

    final _formkey = GlobalKey<FormState>();
    User userStudent = FirebaseAuth.instance.currentUser;
    CollectionReference Students = FirebaseFirestore.instance.collection('Students');
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
        stream: Students.where('uid',isEqualTo: userStudent.email).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

      if (!snapshot.hasData)
        return Center(child: SpinKitFoldingCube(
          color: kUnselectedItemColor,
          size: 60,
        ),
        );
    else {
    return Container(
      color: Colors.grey.shade100,
    padding: EdgeInsets.all(20),
    constraints: BoxConstraints.expand(),
    child: Form(
    key: _formkey,
    child:ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    children: [
    Column(
    children: snapshot.data.docs
        .map((DocumentSnapshot document) {

         return Column(
           
           children: [
             Padding(padding: EdgeInsets.all(8),),
             Card(
               shape: BeveledRectangleBorder(
                 borderRadius: BorderRadius.circular(5),
               ),
               elevation: 3,
               child: ListTile(
                 title: Text(document.data()['teacherName']),
                subtitle:Text("المعلم"),
                 onTap: (){
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context)=>
                           teacherInfo(uid: document.data()['teacherId'],)));
                 },
               ),
             ),
           ],
         );
    }).toList()),
      
      Column(
          children: snapshot.data.docs
              .map((DocumentSnapshot document) {

   if (document.data()['physiotherapySpecialistName']!=null){
     return Column(
       children: [
         Padding(padding: EdgeInsets.all(8),),
         Card(
           shape: BeveledRectangleBorder(
             borderRadius: BorderRadius.circular(5),
           ),
            elevation: 3,
            child: ListTile(
    title: Text(document.data()['physiotherapySpecialistName']),
    subtitle:Text("أخصائي العلاج الطبيعي"),
    onTap: (){
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>
              specialistInfo(uid: document.data()['physiotherapySpecialistId'],)));

    },
    ),
          ),
       ],
     );}
   else {return Text("");}



    }).toList()),

      Column(
          children: snapshot.data.docs
              .map((DocumentSnapshot document) {

            if (document.data()['occupationalSpecialistName']!=null){
              return  Column(
                children: [
                  Padding(padding: EdgeInsets.all(8),),
                  Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 3,
                    child: ListTile(
                      title: Text(document.data()['occupationalSpecialistName']),
                      subtitle:Text("أخصائي العلاج الوظيفي"),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>
                                specialistInfo(uid: document.data()['occupationalSpecialistId'],)));
                      },
                    ),
                  ),
                ],
              );}
            else {return Text("");}
          }).toList()),

      Column(
          children: snapshot.data.docs
              .map((DocumentSnapshot document) {

            if (document.data()['psychologySpecialistName']!=null){
              return  Column(
                children: [
                  Padding(padding: EdgeInsets.all(8),),

                  Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 3,
                    child: ListTile(
                      title: Text(document.data()['psychologySpecialistName']),
                      subtitle:Text("أخصائي العلاج النفسي"),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>
                                specialistInfo(uid: document.data()['psychologySpecialistId'],)));
                      },
                    ),
                  ),
                ],
              );}
            else {return Text("");}
          }).toList()),

      Column(
          children: snapshot.data.docs
              .map((DocumentSnapshot document) {

            if (document.data()['communicationSpecialistName']!=null){
              return  Column(
                children: [
                  Padding(padding: EdgeInsets.all(8),),
                  Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 3,
                    child: ListTile(
                      title: Text(document.data()['communicationSpecialistName']),
                      subtitle:Text("أخصائي التواصل"),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>
                                specialistInfo(uid: document.data()['communicationSpecialistId'],)));
                      },
                    ),
                  ),
                ],
              );}
            else {return Text("");}
          }).toList()),

    ]),
    ));
    }})


      ),


    );


  }
}
