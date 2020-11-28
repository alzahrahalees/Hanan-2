import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Constance.dart';

class teacherInfo extends StatefulWidget {
  @override

  final String uid;
  teacherInfo ({this.uid});

  _teacherInfoState createState() => _teacherInfoState(uid: uid);
}

class _teacherInfoState extends State<teacherInfo> {
  final String uid;
  _teacherInfoState ({this.uid});
  @override
  Widget build(BuildContext context) {


    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');



    String name;
    String age;
    String phone;
    String email;

    final formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("معلومات المعلم ", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body: SafeArea(

            child: StreamBuilder<QuerySnapshot>(
                stream: Teachers.where('uid' ,isEqualTo:widget.uid ).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: SpinKitFoldingCube(
                      color: kUnselectedItemColor,
                      size: 60,
                    ),
                    );
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: SpinKitFoldingCube(
                        color: kUnselectedItemColor,
                        size: 60,
                      )
                        ,);
                    default:
                      return Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          alignment: Alignment.topRight,
                          child: Form(
                              key: formkey,
                              // here we add the snapshot from database
                              child: ListView(
                                  shrinkWrap: true,
                                  children:
                                  snapshot.data.docs.map((
                                      DocumentSnapshot document) {
                                    String tu=document.data()['uid'];
                                    name = document.data()['name'];
                                    age = document.data()['age'];
                                    phone = document.data()['phone'];
                                    email = document.data()['email'];
                                    String newName;
                                    String newAge;
                                    String newPhone;

                                    return Column(children: <Widget>[
                                      ProfileTileTwo(
                                        readOnly: true,
                                        color: kWolcomeBkg,
                                        title: document.data()['name'],
                                        hintTitle: "الإسم",
                                        icon: Icons.person,
                                        onChanged: (value) {
                                          newName = value;
                                        },
                                      ),

                                      Padding(padding: EdgeInsets.all(5)),

                                      ProfileTileTwo(
                                        readOnly: true,
                                        color: kWolcomeBkg,
                                        title: document.data()['age'],
                                        hintTitle: "العمر",
                                        icon: Icons.assistant_outlined,
                                        onChanged: (value) {
                                          newAge = value;
                                        },
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      ProfileTileTwo(
                                        readOnly: true,
                                        color: kWolcomeBkg,
                                        title: document.data()['email'],
                                        hintTitle: "البريد الإلكتروني",
                                        icon: Icons.alternate_email_outlined,
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      ProfileTileTwo(
                                        readOnly: true,
                                        color: kWolcomeBkg,
                                        title: document.data()['phone'],
                                        hintTitle: "رقم الهاتف",
                                        icon: Icons.phone,
                                        onChanged: (value) {
                                          newPhone = value;
                                        },
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      ProfileTileTwo(
                                        readOnly: true,
                                        color: kWolcomeBkg,
                                        title: document.data()['gender'],
                                        hintTitle: "الجنس",
                                        icon: Icons.accessibility,
                                        onChanged: (value) {
                                          newPhone = value;
                                        },
                                      ),

                                      Padding(padding: EdgeInsets.all(5)),
                                    ]
                                    );
                                  }
                                  ).toList()
                              )
                          )
                      );
                  }
                })
        )
    );
  }
}

