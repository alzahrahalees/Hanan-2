import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanan/UI/Teachers/Plans/AddNewSemesterPlan.dart';
import '../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Teachers/Plans/AddNewSemesterPlan.dart';
import 'Plans/SpecialMajorsPage.dart';
import 'Plans/GeneralMAjorsPage.dart';


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

    return Scaffold(
      floatingActionButton:
      Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(right: 60)),
            FloatingActionButton(
              mini: true
              ,
              onPressed: (){
              },
              child: Icon(Icons.add,size: 30,),
              elevation: 10,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              highlightElevation: 20,
              backgroundColor: Colors.deepPurple.shade200,
              foregroundColor: Colors.white60,
            ),
            Padding(padding: EdgeInsets.only(right: 20)),

            FloatingActionButton(
              mini:true,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> AddNewSemesterPlan(widget._studentId)
                ));

                },
              child: Icon(Icons.search,size: 23,),
              elevation: 10,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              highlightElevation: 20,
              backgroundColor: Colors.deepPurple.shade200,
              foregroundColor: Colors.white60,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
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
                        return ReusableCard(
                          color: Colors.black12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(document.data()['planTitle']),
                              subtitle: Text(document.data()['semester']=='first'? 'الفصل الأول': 'الفصل الثاني'),
                            ),
                          ),
                          onPress: (){
                            if(document.data()['major']== 'general'){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>
                                      GeneralMajorsPage(
                                        studentId: widget._studentId,
                                        tabs:document.data()['subjects'] ,)
                              ));
                            }
                            else{
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=> SpecialMajorsPage()
                              ));
                            }
                          },
                        );
                      }).toList()),
                    );

                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
