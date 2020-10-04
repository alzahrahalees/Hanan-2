import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'auth.dart';
import 'package:hanan/UI/Constance.dart';

class AddTeacher extends StatelessWidget {
  final String name;
  final String age;
  final String email;
  final String phone;
  final String gender;
  final String type;
  final String birthday;

  const AddTeacher({Key key, this.name, this.age, this.email, this.phone, this.gender, this.type, this.birthday}) ;



  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    CollectionReference teacherEmails = FirebaseFirestore.instance.collection('teachersEmail');

    Future<void> registerUser()async{
      final AuthService _auth = AuthService();
      await _auth.registerWithEmailAndPassword(email: email, password: "12345678");
    }

    Future<void> addEmail(){
      return teacherEmails.add({
        'email': email
      });
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
      onPressed:(){
        addEmail();
        registerUser();
        addUser();
        Navigator.pop(context);
        },
      child: Text("إضافة", style: KTextButtonStyle),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0)),


    );
  }
}