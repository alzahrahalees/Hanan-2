import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import '../../Constance.dart';

class Student{
  String name;
  String position;
  Student({this.name,this.position});
}

class AddStudent extends StatelessWidget {
  final String name ;
  final String age  ;
  final String email;
  final String  phone;
  final String  type;
  final String  gender;
  final String teacherName;
  final String teacherId;
  final String psychologySpecialistName;//نفسي
  final String psychologySpecialistId;
  final String communicationSpecialistName;//تخاطب
  final String communicationSpecialistId;
  final String occupationalSpecialistName; //,ظيفي
  final String occupationalSpecialistId;
  final String physiotherapySpecialistName;//علاج طبيعي
  final String physiotherapySpecialistId;
  final DateTime  birthday;
  final formKey;


  AddStudent({this.formKey,this.name,this.age,this.email,this.phone,this.type,this.gender,this.teacherName,this.teacherId,
    this.communicationSpecialistName,this.communicationSpecialistId,
    this.occupationalSpecialistName,this.occupationalSpecialistId,
    this.physiotherapySpecialistName,this.physiotherapySpecialistId,
    this.psychologySpecialistName,this.psychologySpecialistId,
    this.birthday,
  });

  @override
  Widget  build(BuildContext context) {


    Future<void> addStudent() async {

      User userAdmin =  FirebaseAuth.instance.currentUser;
      CollectionReference students = FirebaseFirestore.instance.collection('Students');
      CollectionReference users = FirebaseFirestore.instance.collection('Users');

      var exists = await FirebaseFirestore.instance.collection('Users')
          .doc(email).get();
      bool isExists = (exists.exists);
      //problem:the document must be have the same ID

       if(!isExists)   {

         var addTpNoAuth =FirebaseFirestore.instance.collection('NoAuth')
             .doc(email.toLowerCase()).set({});

      var addToStudent = students.doc(email.toLowerCase()).set({
        "isAuth":false,
        "center": userAdmin.email.toLowerCase(),
        'uid': email.toLowerCase(),
        'name': name,
        'age': age,
        'email': email.toLowerCase(),
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday.toString(),
        'teacherName':teacherName,
        'teacherId':teacherId,
        'psychologySpecialistName':psychologySpecialistName,//نفسي
        'psychologySpecialistId':psychologySpecialistId,
        'communicationSpecialistName':communicationSpecialistName,//تخاطب
        'communicationSpecialistId':communicationSpecialistId,
        'occupationalSpecialistName':occupationalSpecialistName,//,ظيفي
        'occupationalSpecialistId':occupationalSpecialistId,
        'physiotherapySpecialistName':physiotherapySpecialistName,//علاج طبيعي
        'physiotherapySpecialistId':physiotherapySpecialistId,
      });

      var addStudyCasesF= students.doc(email.toLowerCase()).collection('StudyCases').doc(email.toLowerCase()+'family').set({});
      var addStudyCasesC= students.doc(email.toLowerCase()).collection('StudyCases').doc(email.toLowerCase()+'clinical').set({});
      var addStudyCasesS= students.doc(email.toLowerCase()).collection('StudyCases').doc(email.toLowerCase()+'info').set({});

      var addToUsers=users.doc(email.toLowerCase())
          .set({
        "center": userAdmin.email.toLowerCase(),
        "isAuth":false,
        'uid': email.toLowerCase(),
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday.toString(),
        'teacherName':teacherName,
        'teacherId':teacherId,
        'psychologySpecialistName':psychologySpecialistName,//نفسي
        'psychologySpecialistId':psychologySpecialistId,
        'communicationSpecialistName':communicationSpecialistName,//تخاطب
        'communicationSpecialistId':communicationSpecialistId,
        'occupationalSpecialistName':occupationalSpecialistName,//,ظيفي
        'occupationalSpecialistId':occupationalSpecialistId,
        'physiotherapySpecialistName':physiotherapySpecialistName,//علاج طبيعي
        'physiotherapySpecialistId':physiotherapySpecialistId,
      });
}
      Navigator.pop(context, MaterialPageRoute(
          builder: (context) => MainAdminScreen(2))
      );}

    return RaisedButton(
        color: kButtonColor,
        child: Text("إضافة", style: kTextButtonStyle),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)),


        onPressed:(){
          if (formKey.currentState.validate())
          {
            addStudent();
          }
        }

    );
  }
}

