import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Profile extends StatefulWidget {
  // final String type;
  //
  // Profile(this.type);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: Text('الصفحة الشخصية', style: kTextAppBarStyle,textAlign: TextAlign.center,),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          color: kWolcomeBkg,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser.email.toLowerCase())
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
              DocumentSnapshot _userData= snapshot.data;
              var type = _userData.data()['type'];
              var arabicType;

              return ListView(
                children: [
                  ProfileTile(
                    color: kWolcomeBkg,
                    icon: Icons.person,
                    hintTitle: 'الاسم',
                    title:_userData.data()['name'],
                  ),
                  ProfileTile(
                    color: kWolcomeBkg,
                    icon: Icons.email,
                    hintTitle: 'الإيميل',
                    title:_userData.data()['email'],
                  ),
                  ProfileTile(
                    color: kWolcomeBkg,
                    icon: Icons.info,
                    hintTitle: 'الوظيفة',
                    title:_userData.data()['type'],
                  ),
                  ProfileTile(
                    color: kWolcomeBkg,
                    icon: Icons.phone,
                    hintTitle: 'رقم الهاتف',
                    title:_userData.data()['phone'],
                  ),
                  (type=='Admin')? Text('') : ProfileTile(
                    color: kWolcomeBkg,
                    icon: Icons.phone,
                    hintTitle: 'العمر',
                    title:_userData.data()['age'],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// final Icon icon;
//   final String hintTitle;
//   final String title;
//   final Color color;