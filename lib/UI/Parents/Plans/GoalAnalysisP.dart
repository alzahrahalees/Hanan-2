import 'package:flutter/material.dart';
import 'package:hanan/UI/Teachers/Plans/EvaluationAndNotes.dart';
import '../../Constance.dart';
import 'AnalysisP.dart';


class GoalAnalysisMainP extends StatefulWidget {
  final String studentId;
  final String planId;
  final String goalId;

  GoalAnalysisMainP({this.studentId,this.planId,this.goalId});
  @override
  _GoalAnalysisMainPState createState() => _GoalAnalysisMainPState();
}

class _GoalAnalysisMainPState extends State<GoalAnalysisMainP>  with TickerProviderStateMixin{

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
    return DefaultTabController(
      length: 2,
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                backgroundColor: kAppBarColor,
                toolbarHeight: 75,
                bottom: TabBar(
                  indicatorWeight: 2,
                  isScrollable: true,
                  labelColor: kSelectedItemColor,
                  indicatorColor: kSelectedItemColor,
                  unselectedLabelColor: kUnselectedItemColor,
                  tabs:
                  [
                    Tab(text: 'تحليل الهدف'),
                    Tab(text: 'التقييم والملاحظات'),
                  ],
                ),
              ),
              body:TabBarView(
                  children: [
                    AnalysisDetailsP(studentId: widget.studentId,planId: widget.planId,goalId: widget.goalId,),
                    NotesAndEvaluation(studentId: widget.studentId,planId: widget.planId,goalId: widget.goalId,type: 'Parent',),
                  ]) )),
    );}}