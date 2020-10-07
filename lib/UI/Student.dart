
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:hanan/services/auth.dart';
import 'Constance.dart';

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


  AddStudent({this.name,this.age,this.email,this.phone,this.type,this.gender,this.teacherName,this.teacherId,
    this.communicationSpecialistName,this.communicationSpecialistId,
    this.occupationalSpecialistName,this.occupationalSpecialistId,
    this.physiotherapySpecialistName,this.physiotherapySpecialistId,
    this.psychologySpecialistName,this.psychologySpecialistId,
    this.birthday,
  });

  @override
  Widget  build(BuildContext context) {
    CollectionReference Students = FirebaseFirestore.instance.collection('Students');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Specialists = FirebaseFirestore.instance.collection('Specialists');


    Future<void> addStudent() async {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: "123456");
      User user = result.user;
      //problem:the document must be have the same ID
      var addToStudent = Students.doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday.toString(),
        "Teacher": { 'name': teacherName,
          'uid': teacherId},
        "psychologySpecialist": { 'name': psychologySpecialistName,
          'uid': psychologySpecialistId},
        "communicationSpecialist": { 'name': communicationSpecialistName,
          'uid': communicationSpecialistId},
        "occupationalSpecialist": { 'name': occupationalSpecialistName,
          'uid': occupationalSpecialistId},
        "physiotherapySpecialist": { 'name': physiotherapySpecialistName,
          'uid': physiotherapySpecialistId}
        }).then((value) => print("User Added in Student Collection"))
          .catchError((error) => print("Failed to add Student: $error"));
     // "$teacherId/Students"
      var updateTeacher=Teachers.doc(teacherId).
          update({
        user.uid: {
          'uid': user.uid,
          'name': name,
          'age': age,
          'email': email,
          'phone': phone,
          "gender": gender,
          "type": type,
          "birthday": birthday.toString(),
          "psychologySpecialist": { 'name': psychologySpecialistName,
            'uid': psychologySpecialistId},
          "communicationSpecialist": { 'name': communicationSpecialistName,
            'uid': communicationSpecialistId},
          "occupationalSpecialist": { 'name': occupationalSpecialistName,
            'uid': occupationalSpecialistId},
          "physiotherapySpecialist": { 'name': physiotherapySpecialistName,
            'uid': physiotherapySpecialistId}
        }
          } ).then((value) => print("Teacher Updated"))
          .catchError((error) => print("Failed to update Teacher: $error"));
      var updatePsychology=Specialists.doc(psychologySpecialistId).
      update({
        user.uid: {
          'uid': user.uid,
          'name': name,
          'age': age,
          'email': email,
          'phone': phone,
          "gender": gender,
          "type": type,
          "birthday": birthday.toString(),
          "Teacher": { 'name': teacherName,
            'uid': teacherId},
          "communicationSpecialist": { 'name': communicationSpecialistName,
            'uid': communicationSpecialistId},
          "occupationalSpecialist": { 'name': occupationalSpecialistName,
            'uid': occupationalSpecialistId},
          "physiotherapySpecialist": { 'name': physiotherapySpecialistName,
            'uid': physiotherapySpecialistId}
        }
      } ).then((value) => print("psychology specialist Updated"))
          .catchError((error) => print("Failed to update psychology specialist: $error"));
      var updateCommunication=Specialists.doc(communicationSpecialistId).
      update({
        user.uid: {
          'uid': user.uid,
          'name': name,
          'age': age,
          'email': email,
          'phone': phone,
          "gender": gender,
          "type": type,
          "birthday": birthday.toString(),
          "Teacher": { 'name': teacherName,
            'uid': teacherId},
          "psychologySpecialist": { 'name': psychologySpecialistName,
            'uid': psychologySpecialistId},
          "occupationalSpecialist": { 'name': occupationalSpecialistName,
            'uid': occupationalSpecialistId},
          "physiotherapySpecialist": { 'name': physiotherapySpecialistName,
            'uid': physiotherapySpecialistId}
        }
      } ).then((value) => print("communication specialist Updated"))
          .catchError((error) => print("Failed to update communication specialist: $error"));
      var updateOccupational=Specialists.doc(occupationalSpecialistId).
      update({
        user.uid: {
          'uid': user.uid,
          'name': name,
          'age': age,
          'email': email,
          'phone': phone,
          "gender": gender,
          "type": type,
          "birthday": birthday.toString(),
          "Teacher": { 'name': teacherName,
            'uid': teacherId},
          "psychologySpecialist": { 'name': psychologySpecialistName,
            'uid': psychologySpecialistId},
          "communicationSpecialist": { 'name': communicationSpecialistName,
            'uid': communicationSpecialistId},
          "physiotherapySpecialist": { 'name': physiotherapySpecialistName,
            'uid': physiotherapySpecialistId}
        }
      } ).then((value) => print("occupational specialist Updated"))
          .catchError((error) => print("Failed to update occupational specialist: $error"));
      var updatePhysiotherapy=Specialists.doc(physiotherapySpecialistId).
      update({
        user.uid: {
          'uid': user.uid,
          'name': name,
          'age': age,
          'email': email,
          'phone': phone,
          "gender": gender,
          "type": type,
          "birthday": birthday.toString(),
          "Teacher": { 'name': teacherName,
            'uid': teacherId},
          "psychologySpecialist": { 'name': psychologySpecialistName,
            'uid': psychologySpecialistId},
          "communicationSpecialist": { 'name': communicationSpecialistName,
            'uid': communicationSpecialistId},
          "occupationalSpecialist": { 'name': occupationalSpecialistName,
            'uid': occupationalSpecialistId},
        }
      } ).then((value) => print("physiotherapy specialist Updated"))
          .catchError((error) => print("Failed to update physiotherapy specialist: $error"));
      var addToUsers=Users.doc(user.uid)
          .set({
        'uid': user.uid,
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday.toString(),
        "Teacher": { 'name': teacherName,
          'uid': teacherId},
        "psychologySpecialist": { 'name': psychologySpecialistName,
          'uid': psychologySpecialistId},
        "communicationSpecialist": { 'name': communicationSpecialistName,
          'uid': communicationSpecialistId},
        "occupationalSpecialist": { 'name': occupationalSpecialistName,
          'uid': occupationalSpecialistId},
        "physiotherapySpecialist": { 'name': physiotherapySpecialistName,
          'uid': physiotherapySpecialistId}
      })
          .then((value) => print("User Added in Users Collection"))
          .catchError((error) => print("Failed to add user: $error"));
      Navigator.pop(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MainAdminScreen(2)));
    }

    return RaisedButton(
        color: KButtonColor,
        child: Text("إضافة", style: KTextButtonStyle),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)),
        onPressed:

                     addStudent

    );
  }
}


class StudentCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference Students = FirebaseFirestore.instance.collection('Students');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    AuthService _auth=AuthService();
    return StreamBuilder<QuerySnapshot>(
      stream:
      Students.snapshots(),
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
                            Students.doc(document.id).delete();
                            Users.doc(document.id).delete();
                           _auth.deleteUser(document.data()['email'],"123456",document.data()['uid']);}
                        ),
                        title: new Text(document.data()['name'], style: KTextPageStyle),
                        subtitle: new Text("طالب", style: KTextPageStyle),
                      ));
                }).toList());
        }
      },
    );
  }}


/*items: snapshot.data.documents.map((DocumentSnapshot document) {
// I do not know what fields you want to access, thus I am fetching "field"
return DropdownMenuItem(child: Text(document.documentID)}),
)*/
/*new StreamBuilder<QuerySnapshot>(
stream: Teachers.snapshots(),
builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
var length = snapshot.data.docs.length;
DocumentSnapshot ds = snapshot.data.docs[length - 1];
if (!snapshot.hasData)
Center(
child: const CupertinoActivityIndicator(),
);
return new DropdownButton(
items: snapshot.data.docs.map((DocumentSnapshot document) {
return DropdownMenuItem(child: new Text(document.id),

)
;
}).toList(),
onChanged: (newValue) {
setState(() {
category = newValue;
print(category);
});
},
hint: new Text("المعلم المسؤول"),
value: category
);
}
);*/