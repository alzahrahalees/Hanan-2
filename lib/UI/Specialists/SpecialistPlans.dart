import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Constance.dart';
import 'Plans/SpecialMajorsPageS.dart';

class SpecialistPlans extends StatefulWidget {
  final String _studentId;
  SpecialistPlans(this._studentId);
  @override
  _SpecialistPlansState createState() => _SpecialistPlansState();
}


class _SpecialistPlansState extends State<SpecialistPlans> {

  String specialistTypeId='communicationSpecialistId';

  User userSpecialist = FirebaseAuth.instance.currentUser;
  void getType() async {
    await FirebaseFirestore.instance
        .collection('Specialists')
        .doc(userSpecialist.email)
        .get()
        .then((data) {
      if (data.data()['typeOfSpechalist'] == 'أخصائي تخاطب') {
        setState(() {specialistTypeId = 'communicationSpecialistId';});}
      if (data.data()['typeOfSpechalist'] == "أخصائي نفسي") {
        setState(() {
          specialistTypeId = 'psychologySpecialistId';});}
      if (data.data()['typeOfSpechalist'] == "أخصائي علاج وظيفي") {
        setState(() {specialistTypeId = 'occupationalSpecialistId';
        });}
      if (data.data()['typeOfSpechalist'] == "أخصائي علاج طبيعي") {
        setState(() {
          specialistTypeId = 'physiotherapySpecialistId';});}});
  }

  @override
  void initState() {
    super.initState();
    getType();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference studentsPlans = FirebaseFirestore.instance.collection('Students').doc(widget._studentId).collection('Plans');
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:   StreamBuilder(
            stream: studentsPlans.where(specialistTypeId,isEqualTo: userSpecialist.email).snapshots(),
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
                                          (context)=> SpecialMajorsPageS(studentId: widget._studentId,planId: document.data()['planId'],)));
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
