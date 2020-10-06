import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Constance.dart';


class Teacher{
  String name;
  String position;
  Teacher({this.name,this.position});}

class AddTeacher extends StatelessWidget {
  final String name ;
  final String age  ;
  final String email;
  final String  phone;
  final String  type;
  final String  gender;
  final DateTime  birthday;
  AddTeacher({this.name,this.age,this.email,this.phone,this.type,this.gender,this.birthday});

  @override
  Widget  build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');

    Future<void> addTeacher() async{
      var result=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: "123456");
      User user=result.user;
      //problem:the document must be have the same ID
     var addToTeachers=Teachers.doc(user.uid)
          .set({
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday.toString()

      })
          .then((value) => print("User Added in Teacher Collection"))
          .catchError((error) => print("Failed to add Teacher: $error"));
      var addToUsers=Users.doc(user.uid)
          .set({
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday.toString()
      })
          .then((value) => print("User Added in Users Collection"))
          .catchError((error) => print("Failed to add user: $error"));
      Navigator.pop(
          context,
          MaterialPageRoute(
              builder: (context) =>
                 MainAdminScreen(0)));}
   return RaisedButton(
      color: kButtonColor,
      child: Text("إضافة", style: kTextButtonStyle),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0)),
     onPressed: addTeacher

    );
  }
}

class TeacherCards extends StatelessWidget {
@override
Widget build(BuildContext context) {
  CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
  CollectionReference Users = FirebaseFirestore.instance.collection('Users');
  return StreamBuilder<QuerySnapshot>(
    stream:
    Teachers.snapshots(),
    builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) return Text('Loading');
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Text('Loading..');
        default:
        //List <Widget>s =snapshot.data.docs.map((DocumentSnapshot document) {
        //teachers.add(Teacher(name: document.data()['name'], position: "معلم"));
        //}).toList();
        //FilteringTeachers.addAll(teachers);
          return new ListView(
              children:
              snapshot.data.docs.map((DocumentSnapshot document) {
                //return ListView.builder(
                //  padding: EdgeInsets.all(10.0),
                //  itemCount: FilteringTeachers.length,
                // itemBuilder: (BuildContext context, int index) {
                return Card(
                    borderOnForeground: true,
                    child: ListTile(
                      trailing: IconButton(icon: Icon (Icons.delete),
                          onPressed: () {
                            Teachers.doc(document.id).delete();
                            Users.doc(document.id).delete();
                          }
                      ),
                      title: new Text(document.data()['name'], style: kTextPageStyle),
                      subtitle: new Text("معلم", style: kTextPageStyle),
                    ));
              }).toList());
      }
    },
  );
}}

