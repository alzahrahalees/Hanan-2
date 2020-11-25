import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Constance.dart';
import 'dart:math';

class NotesAndEvaluation extends StatefulWidget {

  final String studentId;
  final String planId;
  final String goalId;
  NotesAndEvaluation ({this.studentId,this.planId,this.goalId});

  @override
  _NotesAndEvaluationState createState() => _NotesAndEvaluationState();
}

class _NotesAndEvaluationState extends State<NotesAndEvaluation> {
  @override
  Widget build(BuildContext context) {
    Random ran=Random();
    int num=ran.nextInt(100000000);
    String evalId= widget.studentId+'Evaluation'+num.toString();
    String noteId = widget.studentId+'Note'+num.toString();

    TextEditingController helper= TextEditingController();
    String goalName;
    User _userTeacher = FirebaseAuth.instance.currentUser;


    Future<String> getGoalName()async{
      String name;
      await FirebaseFirestore.instance.collection('Students')
          .doc(widget.studentId).collection('Plans')
          .doc(widget.planId).collection("Goals")
          .doc(widget.goalId).get().then((value) => name = value.data()['goalTitle']);
      return name;
    }

    CollectionReference studentsPlansGoal = FirebaseFirestore.instance.collection('Students')
        .doc(widget.studentId).collection('Plans')
        .doc(widget.planId).collection("Goals")
        .doc(widget.goalId).collection('evaluation');

    CollectionReference studentNotes = FirebaseFirestore.instance.collection('Students')
        .doc(widget.studentId).collection('Plans')
        .doc(widget.planId).collection("Goals")
        .doc(widget.goalId).collection('Notes');
    
    // CollectionReference teachersPlansGoal =FirebaseFirestore.instance.collection('Teachers').doc(_userTeacher.email).collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");
    // CollectionReference specialists = FirebaseFirestore.instance.collection('Specialists');

    return SafeArea(
        child: Column(
          children: [
            StreamBuilder(
              stream: studentsPlansGoal.snapshots(),
              builder: ( context,  snapshot){
                if(!snapshot.hasData){
                  return  SizedBox();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFoldingCube(
                      color: kUnselectedItemColor,
                      size: 60,
                    ),
                  );
                }
                return ListView(
                    children:
                    snapshot.data.docs.map<Widget>((DocumentSnapshot doc){

                      if(doc.exists){
                        return Container(
                            width:330,
                            decoration: BoxDecoration(
                                color:Colors.white,
                                border: Border.all(
                                    color: Colors.deepPurple.shade100,
                                    width: 3.0),   // set border width
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)), // set rounded corner radius
                                boxShadow: [BoxShadow(blurRadius: 5,color: Colors.grey,offset: Offset(1,3))]// make rounded corner of border
                            ),
                            child: Column(
                              children: [
                                Text(goalName),
                              ],
                            )
                        );
                      }
                      else {
                        return SizedBox(
                          width: 600,
                          height: 150,
                          child: GestureDetector(
                            onTap: (){},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: <Widget>[
                                Icon(Icons.add),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                      " إضافة تقييم نهائي للهدف ",
                                      style: kTextPageStyle.copyWith(
                                          fontSize: 18)),
                                )
                              ]),
                            ),
                          ),
                        );
                      }
                }
                ).toList());
              },
            ),


            //
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     width:330,
            //     decoration: BoxDecoration(
            //         color:Colors.white,
            //         border: Border.all(
            //             color: Colors.deepPurple.shade100,
            //             width: 3.0),   // set border width
            //         borderRadius: BorderRadius.all(
            //             Radius.circular(10.0)), // set rounded corner radius
            //         boxShadow: [BoxShadow(blurRadius: 5,color: Colors.grey,offset: Offset(1,3))]// make rounded corner of border
            //     ),
            //     child: StreamBuilder<QuerySnapshot>(
            //       stream: studentNotes.snapshots(),
            //       builder: (BuildContext context,  snapshot){
            //         if(!snapshot.hasData){
            //           return  Center(child: SpinKitFoldingCube(
            //             color: kUnselectedItemColor,
            //             size: 60,
            //           ));
            //         }
            //         else return Text('');
            //       },
            //     ),
            //   ),
            // ),
          ],
        )
    );
  }
}
