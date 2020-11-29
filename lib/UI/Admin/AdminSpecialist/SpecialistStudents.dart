import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminStudent/StudentDetails.dart';

import '../../Constance.dart';

class SpecialistStudents extends StatefulWidget {
  @override
  String uid;
  SpecialistStudents  (String uid) {this.uid=uid;}

  @override
  _SpecialistStudentsState createState() => _SpecialistStudentsState();
}

class _SpecialistStudentsState extends State<SpecialistStudents> {
  String  Studentname="";

  String specialistTypeId='communicationSpecialistId';
  void getType() async {
    await FirebaseFirestore.instance
        .collection('Specialists')
        .doc(widget.uid)
        .get()
        .then((data) {
      if (data.data()['typeOfSpechalist'] == 'أخصائي تخاطب') {
        setState(() {
          specialistTypeId = 'communicationSpecialistId';
        });
      }
      if (data.data()['typeOfSpechalist'] == "أخصائي نفسي") {
        setState(() {
          specialistTypeId = 'psychologySpecialistId';
        });
      }
      if (data.data()['typeOfSpechalist'] == "أخصائي علاج وظيفي") {
        setState(() {
          specialistTypeId = 'occupationalSpecialistId';
        });
      }
      if (data.data()['typeOfSpechalist'] == "أخصائي علاج طبيعي") {
        setState(() {
          specialistTypeId = 'physiotherapySpecialistId';
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getType();
  }
  
  
  

  Widget build(BuildContext context) {
    User userAdmin =  FirebaseAuth.instance.currentUser;
    CollectionReference students =
    FirebaseFirestore.instance.collection('Students');

    return Scaffold(
        appBar: AppBar(
          title: Text("الطلاب", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body:
        SafeArea(
            child:  StreamBuilder(
                stream:
                students.where(specialistTypeId,isEqualTo: widget.uid).snapshots(),
                builder:  (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        alignment: Alignment.topRight,
                        child: ListView(
                            children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                              return Card (
                                  borderOnForeground: true,

                                  child:ListTile(
                                    onTap: (){
                             Navigator.push(
                               context,
                                 MaterialPageRoute(
                                   builder: (context) =>
                                     StudentInfo(document.data()['uid'])));},
                                    title: Text(document.data()['name'],style: kTextPageStyle),

                                  )
                              );
                            }).toList()
                        )
                    ); }
                  else{return Text("no");}
                })) );
  }
}
