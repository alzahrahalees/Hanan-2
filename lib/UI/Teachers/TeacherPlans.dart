import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanan/UI/Teachers/Plans/AddNewSemesterPlan.dart';
import '../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Plans/SpecialMajorsPage.dart';
import 'Plans/GeneralMAjorsPage.dart';

class PlansTeacherFirstPage extends StatefulWidget {
  final String _studentId;
  PlansTeacherFirstPage(this._studentId);

  @override
  _PlansTeacherFirstPageState createState() => _PlansTeacherFirstPageState();
}

class _PlansTeacherFirstPageState extends State<PlansTeacherFirstPage> {



  @override
  Widget build(BuildContext context) {
    User _userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference studentsPlans = FirebaseFirestore.instance.collection('Students').doc(widget._studentId).collection('Plans');
    CollectionReference teachersPlans =FirebaseFirestore.instance.collection('Teachers').doc(_userTeacher.email).collection('Students').doc(widget._studentId).collection('Plans');
    CollectionReference specialists = FirebaseFirestore.instance.collection('Specialists');

    return Scaffold(
      floatingActionButton:
          FloatingActionButton(
            heroTag: 'planB',
            mini: true,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> AddNewSemesterPlan(widget._studentId)
              ));
            },
            child: Icon(Icons.add,size: 30,),
            elevation: 10,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            highlightElevation: 20,
            backgroundColor: Colors.deepPurple.shade200,
            foregroundColor: Colors.white60,
          ),
      body: SafeArea(
        child: Container(
           child:   StreamBuilder(
                stream: teachersPlans.orderBy('createdAt',descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: SpinKitFoldingCube(
                        color: kUnselectedItemColor,
                        size: 60,
                      ),
                    );
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: SpinKitFoldingCube(
                          color: kUnselectedItemColor,
                          size: 60,
                        ),
                      );
                    default:
                         return ListView(
                           shrinkWrap: true,
                           children: [
                             Padding(padding: EdgeInsets.all(8)),
                             Column(
                                children: snapshot.data.docs.map((DocumentSnapshot document) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(document.data()['planTitle'],style:kTextPageStyle.copyWith(fontSize: 13)),
                                    subtitle: Text(document.data()['semester']=='first'? 'الفصل الدراسي الأول': 'الفصل الدراسي الثاني',style:kTextPageStyle.copyWith(fontSize: 10,color: Colors.grey)),
                                    trailing: IconButton(icon: Icon(Icons.delete) ,color: Colors.grey.shade300,onPressed: () {
                                      Timer timer= Timer(Duration(seconds: 10), () {
                                        studentsPlans.doc(document.data()['planId']).collection('Goals').get().then((value) =>
                                            value.docs.forEach((element) {studentsPlans.doc(document.data()['planId']).collection('Goals').doc(element.id).delete();}));
                                        teachersPlans.doc(document.data()['planId']).collection('Goals').get().then((value) =>
                                            value.docs.forEach((element) {teachersPlans.doc(document.data()['planId']).collection('Goals').doc(element.id).delete();}));
                                        specialists.get().then((value) => value.docs.forEach((element) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).delete();
                                        specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).collection('Goals').get().then((value) => value.docs.forEach((plans) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).collection('Goals').doc(plans.id).delete();}));}));
                                        specialists.get().then((value) => value.docs.forEach((element) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).delete();}));
                                        studentsPlans.doc(document.data()['planId']).delete();
                                        teachersPlans.doc(document.data()['planId']).delete();
                                      });
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Row(
                                          children: [
                                            Icon(Icons.auto_delete_outlined, color: Colors.deepPurple.shade200,),
                                            Text("      سيتم الحذف بعد عشرة ثواني", style: TextStyle(color: Colors.deepPurple, fontSize: 12)),
                                            SizedBox(
                                              width: 70,
                                              child: FlatButton(onPressed: () {
                                                studentsPlans.doc(document.data()['planId']).collection('Goals').get().then((value) =>
                                                    value.docs.forEach((element) {studentsPlans.doc(document.data()['planId']).collection('Goals').doc(element.id).delete();}));
                                                teachersPlans.doc(document.data()['planId']).collection('Goals').get().then((value) =>
                                                    value.docs.forEach((element) {teachersPlans.doc(document.data()['planId']).collection('Goals').doc(element.id).delete();}));
                                                specialists.get().then((value) => value.docs.forEach((element) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).delete();
                                                specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).collection('Goals').get().then((value) => value.docs.forEach((plans) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).collection('Goals').doc(plans.id).delete();}));}));
    specialists.get().then((value) => value.docs.forEach((element) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).delete();}));
                                                studentsPlans.doc(document.data()['planId']).delete();
                                                teachersPlans.doc(document.data()['planId']).delete();

                                                Scaffold.of(context).hideCurrentSnackBar();},
                                                child: Text(" تأكيد ", style: TextStyle(color: Colors.deepPurple, fontSize: 12)),),),
                                            SizedBox(
                                              child: FlatButton(onPressed: () {
                                                timer.cancel();
                                                Scaffold.of(context).hideCurrentSnackBar();
                                              },
                                                child: Text("تراجع", style: TextStyle(color: Colors.deepPurple, fontSize: 12)),),
                                              width: 70,
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.white70,
                                        duration: Duration(seconds: 10),
                                      ));
                                    }
                                      ),
                                    onTap:(){
                                  if(document.data()['major']== 'general'){
                                  Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>
                                  GeneralMajorsPage(
                                  studentId: widget._studentId,
                                  tabs:document.data()['subjects'] ,)
                                  ));
                                  }
                                  else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SpecialMajorsPage(studentId: widget._studentId,planId: document.data()['planId'],)));
                                  }
                                  },
                                    leading: Icon(Icons.event_note_rounded,color: Colors.deepPurple.shade200,size: 60,),
                                  ),
                                  Divider(thickness: 0.2,color: Colors.grey,)
                                ],
                              );
                        }).toList()),
                           ],
                         );
                      }},
              ),
        ),
      ),
    );
  }
}
