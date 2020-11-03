import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'StudyCases/ParentClinical.dart';
import 'StudyCases/ParentFiles.dart';
import 'StudyCases/parentInfo.dart';
import 'StudyCases/parenttFamily.dart';
import '../Constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ParentStudyCaseScreen extends StatefulWidget {


  @override
  _ParentStudyCaseScreenState createState() => _ParentStudyCaseScreenState();
}

class _ParentStudyCaseScreenState extends State<ParentStudyCaseScreen> {
  Future<bool> hasData() {}

  @override
  Widget build(BuildContext context) {
    var email = FirebaseAuth.instance.currentUser.email;
    return Container(
      color: kBackgroundPageColor,
        child:
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Students')
                .doc(email)
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
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 85,
                        width: 600,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PFiles()));},
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
                      Column(
                        children: snapshot.data.docs.map<Widget>((DocumentSnapshot doc) {
                          if (doc.id == email+ 'family' && doc.data().isNotEmpty)
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ParentFamilyStudy()),
                                );
                              },
                              child: ReusableCard(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text("  معلومات أهل الطالبـ/ـة  ",
                                      style: kTextPageStyle.copyWith(fontSize: 18)),
                                ),
                              ),
                            );
                          else if (doc.id == email+ 'family' && doc.data().isEmpty) {
                            return ReusableCard(
                              color: Colors.white70,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(" لم يتم إضافة معلومات أهل الطالبـ/ـة ",
                                    style: kTextPageStyle.copyWith(fontSize: 18)),
                              ),
                            );
                          }
                          if (doc.id == email + 'clinical' && doc.data().isNotEmpty)
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ParentClinicalStudy()),
                                );
                              },
                              child: ReusableCard(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(" التاريخ الطبي الطالبـ/ـة ",
                                      style: kTextPageStyle.copyWith(fontSize: 18)),
                                ),
                              ),
                            );
                          else if (doc.id == email + 'clinical' && doc.data().isEmpty) {
                            return ReusableCard(
                              color: Colors.white70,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text("لم يتم إضافة إضافة التاريخ الطبي للطالبـ/ـة ",
                                    style: kTextPageStyle.copyWith(fontSize: 18)),
                              ),
                            );
                          }
                          if (doc.id == email + 'info' && doc.data().isNotEmpty)
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ParentInfoStudy()),
                                );
                              },
                              child: ReusableCard(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text("  معلومات حالة الطالبـ/ـة  ",
                                      style: kTextPageStyle.copyWith(fontSize: 18)),
                                ),
                              ),
                            );
                          else if (doc.id == email + 'info' && doc.data().isEmpty) {
                            return ReusableCard(
                              color: Colors.white70,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text("لم يتم إضافة إضافة معلومات حالة الطالبـ/ـة  ",
                                    style: kTextPageStyle.copyWith(fontSize: 18)),
                              ),
                            );
                          }
                          else{return(Text("",style: TextStyle(fontSize: 0),));}
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              );
              // if (_userData.exists) {
            }
        ));
  }

}
