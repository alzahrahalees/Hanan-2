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

  String _achievementValue = 'أتقن';

  onChangedValue (value){
    setState(() {
      _achievementValue=value;
    });
  }


  @override
  Widget build(BuildContext context) {

    TextEditingController helper= TextEditingController();
    String goalName;
    User _userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference studentsPlansGoal = FirebaseFirestore.instance.collection('Students')
        .doc(widget.studentId).collection('Plans')
        .doc(widget.planId).collection("Goals");
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
                        itemBuilder:(context,index) {
                          DocumentSnapshot documentSnapshot =snapshot.data.docs[index];
                          goalName=documentSnapshot.data()['goalTitle'];

                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
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
                                  children:[

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('هل أتقن الطالب الهدف ( $goalName) ؟ '),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Radio(
                                            toggleable: true,
                                            activeColor:  kSelectedItemColor,
                                            value: 'أتقن' ,
                                            groupValue: _achievementValue,
                                            onChanged: (value){
                                              onChangedValue(value);
                                            },
                                          ),
                                          Text('أتقن'),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Radio(
                                            activeColor:  kSelectedItemColor,
                                            value: 'أتقن بمساعدة',
                                            groupValue: _achievementValue,
                                            onChanged: (value){
                                              onChangedValue(value);
                                            },
                                          ),
                                          Text('أتقن بمساعدة'),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 10),
                                      child: TextFormField(
                                        controller: helper,

                                      )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Radio(
                                            toggleable: true,
                                            activeColor:  kSelectedItemColor,
                                            value: 'مازال يحتاج إلى تدريب',
                                            groupValue: _achievementValue,
                                            onChanged: (value){
                                              onChangedValue(value);
                                            },
                                          ),
                                          Text('يحتاج إلى تدريب أكثر'),
                                        ],
                                      ),
                                    ),

                                  ]),
                            ),
                          )
                          ;}
                          )
                );
                }
              }
              )
      );

  }
  }

