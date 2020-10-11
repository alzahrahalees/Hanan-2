import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:hanan/UI/Admin/AdminSpecialist/SpecialistDetails.dart';
import 'package:hanan/services/auth.dart';
import 'Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Specialist{
  String name;
  String position;
  Specialist({this.name,this.position});
}

class AddSpecialist extends StatelessWidget {
  final String name ;
  final String age  ;
  final String email;
  final String  phone;
  final String  type;
  final String  gender;
  final String typeOfSpechalist;
  final DateTime  birthday;

  final  formkey ;

  AddSpecialist({this.formkey,this.name,this.age,this.email,this.phone,this.type,this.gender,this.typeOfSpechalist,this.birthday});

  @override
  Widget  build(BuildContext context) {

    User userAdmin =  FirebaseAuth.instance.currentUser;
    //Reference
    CollectionReference Specialists = FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Specialists = Admin.doc(userAdmin.email.toLowerCase()).collection('Specialists');



    Future<void> addTeacher() async{
      var NoAuth =FirebaseFirestore.instance.collection('NoAuth').doc(email.toLowerCase()).set({});
      //problem:the document must be have the same ID
      var addToAdminSpecialist=Admin_Specialists.doc(email.toLowerCase())
          .set({
        "isAuth":false,
        "center":userAdmin.email.toLowerCase(),
        'uid':email,
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "typeOfSpechalist":typeOfSpechalist,
        "birthday": birthday.toString()
      });
      var addToSpecialist=Specialists.doc(email.toLowerCase())
          .set({
        "isAuth":false,
        "center":userAdmin.email.toLowerCase(),
        'uid':email.toLowerCase(),
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "typeOfSpechalist":typeOfSpechalist,
        "birthday": birthday.toString()
      })
          .then((value) => print("User Added in Specialist Collection"))
          .catchError((error) => print("Failed to add in Specialist: $error"));

      var addToUsers=Users.doc(email.toLowerCase())
          .set({
        "isAuth":false,
        "center":userAdmin.email.toLowerCase(),
        'uid':email.toLowerCase(),
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "typeOfSpechalist":typeOfSpechalist,
        "birthday": birthday.toString()
      })
          .then((value) => print("User Added in Users Collection"))
          .catchError((error) => print("Failed to add user: $error"));

      Navigator.pop(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MainAdminScreen(1)));}

    return RaisedButton(
        color: kButtonColor,
        child: Text("إضافة", style: kTextButtonStyle),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)),
        onPressed:() {
          if (formkey.currentState.validate())
          {addTeacher();}
        }

    );
  }
}
