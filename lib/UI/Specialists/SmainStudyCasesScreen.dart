import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Study%20Cases/AddClinical.dart';
import 'package:hanan/UI/Study%20Cases/AddFamilyInfo.dart';
import 'package:hanan/UI/Study%20Cases/AddStudentInfo.dart';
import 'package:hanan/UI/Study%20Cases/SpecialistFiles.dart';
import 'package:hanan/UI/Study%20Cases/StudentProfile.dart';
import 'package:hanan/UI/Study%20Cases/UpdateClinical.dart';
import 'package:hanan/UI/Study%20Cases/UpdateStudentInfo.dart';
import 'package:hanan/UI/Study%20Cases/TeacherFiles.dart';
import 'package:hanan/UI/Study%20Cases/UpdatseFamilyInfo.dart';
import '../Constance.dart';


class SpechalistStudyCaseScreen extends StatefulWidget {
  final String studentId;
  final String centerId;
  final String psychologySpecialistName;//نفسي
  final String psychologySpecialistId;
  final String communicationSpecialistName;//تخاطب
  final String communicationSpecialistId;
  final String occupationalSpecialistName; //,ظيفي
  final String occupationalSpecialistId;
  final String physiotherapySpecialistName;//علاج طبيعي
  final String physiotherapySpecialistId;
  final String teacherName;
  final String teacherId;


  SpechalistStudyCaseScreen ({this.teacherId,this.studentId,this.centerId,this.teacherName,
    this.communicationSpecialistId,this.communicationSpecialistName,
    this.physiotherapySpecialistId,this.physiotherapySpecialistName,
    this.psychologySpecialistId,this.psychologySpecialistName,
    this.occupationalSpecialistId,this.occupationalSpecialistName,});

  @override
  _SpechalistStudyCaseScreen  createState() => _SpechalistStudyCaseScreen ();
}

class _SpechalistStudyCaseScreen  extends State<SpechalistStudyCaseScreen > {
  Future<bool> hasData() {}
  @override
  Widget build(BuildContext context) {
    return Container(
        color: kBackgroundPageColor,
        child: Column(
          children: [

            Container(
              height: 85,
              width: 600,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            StudentProfile(
                              widget.studentId,
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: ReusableCard(
                      color: Color(0xffd6d6d6),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("  معلومات الطالبـ/ـة  ",
                            style:
                            kTextPageStyle.copyWith(fontSize: 18)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 85,
              width: 600,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SFiles(studentId: widget.studentId,centerId: widget.centerId,
                            communicationSpecialistName:widget.communicationSpecialistName,
                            communicationSpecialistId: widget.communicationSpecialistId,
                            physiotherapySpecialistId:widget.physiotherapySpecialistId,
                            physiotherapySpecialistName:widget.physiotherapySpecialistName ,
                            psychologySpecialistId:widget.psychologySpecialistId ,
                            psychologySpecialistName:widget.psychologySpecialistName ,
                            occupationalSpecialistId: widget.occupationalSpecialistId,
                            occupationalSpecialistName:widget.occupationalSpecialistName ,
                            teacherName: widget.teacherName,
                            teacherId: widget.teacherId,
                          )));},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: ReusableCard(
                      color: Color(0xffd6d6d6),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("  المرفقات ",
                            style:
                            kTextPageStyle.copyWith(fontSize: 18)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Students')
                        .doc(widget.studentId)
                        .collection('StudyCases')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: SpinKitFoldingCube(
                            color: kUnselectedItemColor,
                            size: 60,
                          ),
                        );
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
                          snapshot.data.docs.map<Widget>((
                              DocumentSnapshot doc) {
                            if (doc.id == widget.studentId + 'family' &&
                                doc
                                    .data()
                                    .isNotEmpty)
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateFamilyInfo(widget.studentId)),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ReusableCard(
                                    color: kCardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text("  معلومات أهل الطالبـ/ـة  ",
                                          style: kTextPageStyle.copyWith(
                                              fontSize: 18)),
                                    ),
                                  ),
                                ),
                              );
                            else if (doc.id == widget.studentId + 'family' &&
                                doc
                                    .data()
                                    .isEmpty) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FamilyInfo(widget.studentId)),
                                    );
                                  },
                                  child: ReusableCard(
                                    color: kCardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: <Widget>[
                                        Icon(Icons.person_add),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              " إضافة معلومات أهل الطالبـ/ـة  ",
                                              style: kTextPageStyle.copyWith(
                                                  fontSize: 18)),
                                        )
                                      ]),
                                    ),
                                  ));
                            }

                            if (doc.id == widget.studentId + 'clinical' &&
                                doc
                                    .data()
                                    .isNotEmpty)
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateClinical(widget.studentId)),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ReusableCard(
                                    color: kCardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(" التاريخ الطبي الطالبـ/ـة ",
                                          style: kTextPageStyle.copyWith(
                                              fontSize: 18)),
                                    ),
                                  ),
                                ),
                              );
                            else if (doc.id == widget.studentId + 'clinical' &&
                                doc
                                    .data()
                                    .isEmpty) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddClinical(widget.studentId)),
                                    );
                                  },
                                  child: ReusableCard(
                                    color: kCardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: <Widget>[
                                        Icon(Icons.person_add),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              " إضافة التاريخ الطبي الطالبـ/ـة ",
                                              style: kTextPageStyle.copyWith(
                                                  fontSize: 18)),
                                        )
                                      ]),
                                    ),
                                  ));
                            }
                            if (doc.id == widget.studentId + 'info' &&
                                doc
                                    .data()
                                    .isNotEmpty)
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateStudentInfo(
                                                widget.studentId)),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ReusableCard(
                                    color: kCardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text("  معلومات حالة الطالبـ/ـة  ",
                                          style: kTextPageStyle.copyWith(
                                              fontSize: 18)),
                                    ),
                                  ),
                                ),
                              );
                            else if (doc.id == widget.studentId + 'info' &&
                                doc
                                    .data()
                                    .isEmpty) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddStudentInfo(widget.studentId)),
                                    );
                                  },
                                  child: ReusableCard(
                                    color: kCardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: <Widget>[
                                        Icon(Icons.person_add),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              " إضافة معلومات حالة الطالبـ/ـة  ",
                                              style: kTextPageStyle.copyWith(
                                                  fontSize: 18)),
                                        )
                                      ]),
                                    ),
                                  ));
                            }
                            else{
                              return Text("",style: TextStyle(fontSize: 0),);
                            }
                          }).toList());
                      // if (_userData.exists) {
                    }),
              ),
            ),
          ],
        ));
  }
}






