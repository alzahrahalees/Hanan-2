import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Constance.dart';
import 'Plans/SpecialMajorsPageP.dart';



class ParentPlans extends StatefulWidget {

  @override
  _ParentPlansState createState() => _ParentPlansState();
}

class _ParentPlansState extends State<ParentPlans> {



  @override
  Widget build(BuildContext context) {


    User _userParent = FirebaseAuth.instance.currentUser;
    CollectionReference studentsPlans = FirebaseFirestore.instance.collection('Students').doc(_userParent.email).collection('Plans');
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:   StreamBuilder(
            stream: studentsPlans.orderBy('createdAt',descending: true).snapshots(),
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
                                  onTap:() async{
                                    Navigator.push(context, MaterialPageRoute(builder:
                                        (context)=> SpecialMajorsPageP(planId: document.data()['planId'],)));
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


//                                 trailing: IconButton(icon: Icon(Icons.delete) ,color: Colors.grey.shade300,onPressed: () {
//                                   Timer timer= Timer(Duration(seconds: 10), () {
//                                     studentsPlans.doc(document.data()['planId']).collection('Goals').get().then((value) =>
//                                         value.docs.forEach((element) {studentsPlans.doc(document.data()['planId']).collection('Goals').doc(element.id).delete();}));
//                                     teachersPlans.doc(document.data()['planId']).collection('Goals').get().then((value) =>
//                                         value.docs.forEach((element) {teachersPlans.doc(document.data()['planId']).collection('Goals').doc(element.id).delete();}));
//                                     specialists.get().then((value) => value.docs.forEach((element) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).delete();
//                                     specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).collection('Goals').get().then((value) => value.docs.forEach((plans) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).collection('Goals').doc(plans.id).delete();}));}));
//                                     specialists.get().then((value) => value.docs.forEach((element) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).delete();}));
//                                     studentsPlans.doc(document.data()['planId']).delete();
//                                     teachersPlans.doc(document.data()['planId']).delete();
//                                   });
//                                   Scaffold.of(context).showSnackBar(SnackBar(
//                                     content: Row(
//                                       children: [
//                                         Icon(Icons.auto_delete_outlined, color: Colors.deepPurple.shade200,),
//                                         Text("      سيتم الحذف بعد عشرة ثواني", style: TextStyle(color: Colors.deepPurple, fontSize: 12)),
//                                         SizedBox(
//                                           width: 70,
//                                           child: FlatButton(onPressed: () {
//                                             studentsPlans.doc(document.data()['planId']).collection('Goals').get().then((value) =>
//                                                 value.docs.forEach((element) {studentsPlans.doc(document.data()['planId']).collection('Goals').doc(element.id).delete();}));
//                                             teachersPlans.doc(document.data()['planId']).collection('Goals').get().then((value) =>
//                                                 value.docs.forEach((element) {teachersPlans.doc(document.data()['planId']).collection('Goals').doc(element.id).delete();}));
//                                             specialists.get().then((value) => value.docs.forEach((element) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).delete();
//                                             specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).collection('Goals').get().then((value) => value.docs.forEach((plans) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).collection('Goals').doc(plans.id).delete();}));}));
// specialists.get().then((value) => value.docs.forEach((element) {specialists.doc(element.id).collection('Students').doc(widget._studentId).collection('Plans').doc(document.data()['planId']).delete();}));
//                                             studentsPlans.doc(document.data()['planId']).delete();
//                                             teachersPlans.doc(document.data()['planId']).delete();
//
//                                             Scaffold.of(context).hideCurrentSnackBar();},
//                                             child: Text(" تأكيد ", style: TextStyle(color: Colors.deepPurple, fontSize: 12)),),),
//                                         SizedBox(
//                                           child: FlatButton(onPressed: () {
//                                             timer.cancel();
//                                             Scaffold.of(context).hideCurrentSnackBar();
//                                           },
//                                             child: Text("تراجع", style: TextStyle(color: Colors.deepPurple, fontSize: 12)),),
//                                           width: 70,
//                                         ),
//                                       ],
//                                     ),
//                                     backgroundColor: Colors.white70,
//                                     duration: Duration(seconds: 10),
//                                   ));
//                                 }
//                                   ),