import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Plans/newSemesterPlan.dart';

class PlansTeacherFirstPage extends StatefulWidget {
  final String _studentId;

  PlansTeacherFirstPage(this._studentId);

  @override
  _PlansTeacherFirstPageState createState() => _PlansTeacherFirstPageState();
}

class _PlansTeacherFirstPageState extends State<PlansTeacherFirstPage> {
  @override
  Widget build(BuildContext context) {
    User _user = FirebaseAuth.instance.currentUser;
    CollectionReference _plans = FirebaseFirestore.instance
        .collection('Students')
        .doc(widget._studentId)
        .collection('Plans');

    return Expanded(
      child: ListView(
        children: [
          ReusableCard(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(' خطة الفصل الدراسي الأول " بطاقة مؤقته" '),
            ),
            onPress: (){
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context)=> PlanPage(widget._studentId) ));
              },
          ),
          SizedBox(
            height: 400, // this should be 525 but temperately 400
            child: StreamBuilder(
              stream: _plans.snapshots(),
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
                    return Container(
                      child: ListView(
                          children: snapshot.data.docs.map((DocumentSnapshot document) {
                        return Card(
                          color: Colors.white70,
                          child: Text('Tis semester Plan'),
                        );
                      }).toList()),
                    );
                }
              },
            ),
          ),
          Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: kButtonColor,
                      child: Text("إضافة خطة جديدة", style: kTextButtonStyle),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=> AddNewSemesterPlan(widget._studentId))
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: kButtonColor,
                      child: Text("البحث عن خطة قديمة", style: kTextButtonStyle),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      onPressed: () {},
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
