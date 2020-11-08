import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Constance.dart';

class GoalNotes extends StatefulWidget {
  final String studentId;
  final String planId;
  final String goalId;
  GoalNotes ({this.studentId,this.planId,this.goalId});
  @override
  _AnalysisState createState() => _AnalysisState();
}


class _AnalysisState extends State<GoalNotes> {
  @override
  Widget build(BuildContext context) {
    User _userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference studentsPlansGoal = FirebaseFirestore.instance.collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");
    CollectionReference teachersPlansGoal =FirebaseFirestore.instance.collection('Teachers').doc(_userTeacher.email).collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");
    CollectionReference specialists = FirebaseFirestore.instance.collection('Specialists');

    return
      SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream:studentsPlansGoal.where("goalId",isEqualTo: widget.goalId).snapshots(),
              builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData){
                  return  Center(child: SpinKitFoldingCube(
                    color: kUnselectedItemColor,
                    size: 60,
                  ));}
                else{return Container(
                    color: Colors.white70,
                    child:ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder:(context,index){
                          DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
                          return Column(
                              children:[
                                Text("ok"),
                              ]);}));}}));

  }
  }

