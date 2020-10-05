import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'Constance.dart';

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

  AddSpecialist({this.name,this.age,this.email,this.phone,this.type,this.gender,this.typeOfSpechalist,this.birthday});

  @override
  Widget  build(BuildContext context) {
    CollectionReference Specialists = FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');

    Future<void> addTeacher() async{
      var result=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: "123456");
      User user=result.user;
      //problem:the document must be have the same ID
      var addToTeachers=Specialists.doc(user.uid)
          .set({
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
          .catchError((error) => print("Failed to add Specialist: $error"));
      var addToUsers=Users.doc(user.uid)
          .set({
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
                  MainAdminScreen(0)));
    }

    return RaisedButton(
        color: KButtonColor,
        child: Text("إضافة", style: KTextButtonStyle),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)),
        onPressed: addTeacher

    );
  }
}

class SpecialistCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference Specialists= FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    return StreamBuilder<QuerySnapshot>(
      stream:
      Specialists.snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Text('Loading');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading..');
          default:
            return new ListView(
                children:
                snapshot.data.docs.map((DocumentSnapshot document) {
                  return Card(
                      borderOnForeground: true,
                      child: ListTile(
                        trailing: IconButton(icon: Icon (Icons.delete),
                            onPressed: () {
                              Specialists.doc(document.id).delete();
                              Users.doc(document.id).delete();
                            }
                        ),
                        title: new Text(document.data()['name'], style: KTextPageStyle),
                        subtitle: new Text("أخصائي", style: KTextPageStyle),
                      ));
                }).toList());
        }
      },
    );
  }}