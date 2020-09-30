import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hanan/UI/Admin/AdminTeacherScreen.dart';
import 'auth.dart';
import 'package:hanan/UI/Constance.dart';

class AddUser extends StatelessWidget {
  final String name;
  final String age;
  final String email;
  final String phone;
  final String gender;
  final String type;
  final String birthday;

  const AddUser({Key key, this.name, this.age, this.email, this.phone, this.gender, this.type, this.birthday}) ;



  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    Future<void> registerUser()async{
      final AuthService _auth = AuthService();
      await _auth.registerWithEmailAndPassword(email: email, password: "12345678");
    }

    Future<void> addUser() {

      return users
          .add({

        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday,

      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return FlatButton(
      color: KButtonColor,
      onPressed:(){registerUser(); addUser(); Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TeacherScreen()));},
      child: Text("إضافة", style: KTextButtonStyle),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0)),


    );
  }
}