import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StudentProfile extends StatefulWidget {
  final String uid;
  StudentProfile(this.uid);
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {

  String uid;
  @override
  void initState() {
    super.initState();
    uid= widget.uid;
  }

  //all Path
  //get type

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: kUnselectedItemColor),
          backgroundColor: kAppBarColor,
          title: Text('الصفحة الشخصية', style: kTextAppBarStyle,textAlign: TextAlign.center,),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          color: kBackgroundPageColor,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(widget.uid)
                .snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return SpinKitFoldingCube(
                  color: kUnselectedItemColor,
                  size: 60,
                );
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return SpinKitFoldingCube(
                  color: kUnselectedItemColor,
                  size: 60,
                );
              }
              DocumentSnapshot document= snapshot.data;

              return Form(
                child: ListView(
                  children: [
                    ProfileTile(
                      readOnly: true ,
                      color: kWolcomeBkg,
                      icon: Icons.person,
                      hintTitle: 'الاسم',
                      title:document.data()['name'],

                    ),
                    ProfileTile(
                      readOnly: true,
                      color: kWolcomeBkg,
                      icon: Icons.email,
                      hintTitle: 'الإيميل',
                      title:document.data()['email'],
                    ),
                    ProfileTile(
                      readOnly: true,
                      color: kWolcomeBkg,
                      icon: Icons.phone,
                      hintTitle: 'رقم الهاتف',
                      title:document.data()['phone'],
                    ),

                     ProfileTile(
                      readOnly: true,
                      color: kWolcomeBkg,
                      icon: Icons.assistant_outlined,
                      hintTitle: 'العمر',
                      title:document.data()['age'],
                    ),
                     ProfileTile(
                      readOnly: true,
                      color: kWolcomeBkg,
                      icon: Icons.accessibility,
                      hintTitle: 'الجنس',
                      title:document.data()['gender'],
                    ),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}