import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Teachers/Plans/Analysis.dart';
import 'package:hanan/UI/Teachers/Plans/Evaluation.dart';
import 'package:hanan/UI/Teachers/Plans/Notes.dart';
import '../../Constance.dart';


class GoalAnalysisMain extends StatefulWidget {
  final String studentId;
  final String planId;
  final String goalId;

  GoalAnalysisMain({this.studentId,this.planId,this.goalId});
  @override
  _GoalAnalysisMainState createState() => _GoalAnalysisMainState();
}

class _GoalAnalysisMainState extends State<GoalAnalysisMain>  with TickerProviderStateMixin{

  @override
  void dispose() {
    super.dispose();
  }
  TabController controller;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    User _userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference studentsPlansGoal = FirebaseFirestore.instance.collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");
    CollectionReference teachersPlansGoal =FirebaseFirestore.instance.collection('Teachers').doc(_userTeacher.email).collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");
    CollectionReference specialists = FirebaseFirestore.instance.collection('Specialists');

    if(controller == null) {
      controller=new TabController(length: 3, vsync: this);
    }
    return SafeArea(
        child: Scaffold(
    appBar: AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: kAppBarColor,
    toolbarHeight: 75,
    bottom: TabBar(
    indicatorWeight: 2,
    isScrollable: true,
    controller:controller,
    labelColor: kSelectedItemColor,
    indicatorColor: kSelectedItemColor,
    unselectedLabelColor: kUnselectedItemColor,
    tabs:
    [
    Tab(text: 'تحليل الهدف'),
      Tab(text: 'الملاحظات'),
    Tab(text:'التقييم'),
    ],
    ),
    ),
    body:TabBarView(
    controller: controller,
    children: [
     AnalysisDetails(studentId: widget.studentId,planId: widget.planId,goalId: widget.goalId,),
     GoalNotes(studentId: widget.studentId,planId: widget.planId,goalId: widget.goalId,),
      GoalEvaluation(studentId: widget.studentId,planId: widget.planId,goalId: widget.goalId,),
    ]) ));}}