
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
    User userAdmin =  FirebaseAuth.instance.currentUser;
    CollectionReference Students = FirebaseFirestore.instance.collection('Students');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Specialists = FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Teachers =Admin.doc(userAdmin.email).collection('Teachers');
    CollectionReference Admin_Specialists = Admin.doc(userAdmin.email).collection('Specialists');
    CollectionReference Admin_Students=Admin.doc(userAdmin.email).collection('Students');

    Future<void> addStudent() async {
      //problem:the document must be have the same ID
      var NoAuth =FirebaseFirestore.instance.collection('NoAuth').doc(email)
          .set({
      });

      var addToStudent = Students.doc(email).set({
        "isAuth":false,
        'uid': email,
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday.toString(),
      });
      var addToAminStudent = Admin_Students.doc(email).set({
        "isAuth":false,
        'uid': email,
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday.toString(),
      });


      var addToAdminStudentTeacher = Admin_Students.doc(email).collection('Teachers').doc(teacherId).set(
          {
             'name': teacherName,
              'uid': teacherId,
          });

      var addToAdminTeacherStudent= Admin_Teachers.doc(teacherId).collection('Students').doc(email).
          set({
        'uid': email,
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
      });


      var addToStudentTeacher = Students.doc(email).collection('Teachers').doc(teacherId).set(
          {
            'name': teacherName,
            'uid': teacherId,
          });

      var addTeacherStudent= Teachers.doc(teacherId).collection('Students').doc(email).
      set({
        'uid': email,
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
      } );

      var addToStudentPsychologyS = Students.doc(email).collection('psychologySpecialist').doc(psychologySpecialistId).set(
          {
            'name': psychologySpecialistName,
            'uid': psychologySpecialistId,
          });

      var addPsychologyStudent=Specialists.doc(psychologySpecialistId).collection('Students').doc(email).
      set({
          'uid': email,
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
      );
      var addToAdminStudentPsychologyS = Admin_Students.doc(email).collection('psychologySpecialist').doc(psychologySpecialistId).set(
          {
            'name': psychologySpecialistName,
            'uid': psychologySpecialistId,
          });

      var addAdminPsychologyStudent=Admin_Specialists.doc(psychologySpecialistId).collection('Students').doc(email).
      set({
        'uid': email,
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
      );



      var addToStudentCommunicationS = Students.doc(email).collection('CommunicationSpecialist').doc(communicationSpecialistId).set(
          {
            'name': communicationSpecialistName,
            'uid': communicationSpecialistId,
          });

      var addCommunicationStudent=Specialists.doc(communicationSpecialistId).collection('Students').doc(email).
      set({
          'center':userAdmin.email,
          'uid': email,
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
        });

      var addToAdminStudentCommunicationS = Admin_Students.doc(email).collection('CommunicationSpecialist').doc(communicationSpecialistId).set(
          {
            'name': communicationSpecialistName,
            'uid': communicationSpecialistId,
          });

      var addAdminCommunicationStudent=Admin_Specialists.doc(communicationSpecialistId).collection('Students').doc(email).
      set({
        'center':userAdmin.email,
        'uid': email,
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
      });


      var addToStudentOccupationalS = Students.doc(email).collection('OccupationalSpecialist').doc(occupationalSpecialistId).set(
          {
            'name': occupationalSpecialistName,
            'uid':occupationalSpecialistId,
          });


      var addOccupationalStudent=Specialists.doc(occupationalSpecialistId).collection('Students').doc(email).
      set({
          'center':userAdmin.email,
          'uid': email,
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
        });

      var addAdminToStudentOccupationalS = Admin_Students.doc(email).collection('OccupationalSpecialist').doc(occupationalSpecialistId).set(
          {
            'name': occupationalSpecialistName,
            'uid':occupationalSpecialistId,
          });


      var addAdminOccupationalStudent=Admin_Specialists.doc(occupationalSpecialistId).collection('Students').doc(email).
      set({
        'center':userAdmin.email,
        'uid': email,
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
      });


      var addToStudentPhysiotherapyS = Students.doc(email).collection('PhysiotherapySpecialist').doc(physiotherapySpecialistId).set(
          {
            'name': physiotherapySpecialistName,
            'uid':physiotherapySpecialistId,
          });

      var addPhysiotherapy=Specialists.doc(physiotherapySpecialistId).collection("Students").doc(email).set({
          'center':userAdmin,
          'name':name,
          'uid':email,
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
       );

      var addToAdminStudentPhysiotherapyS = Admin_Students.doc(email).collection('PhysiotherapySpecialist').doc(physiotherapySpecialistId).set(
          {
            'name': physiotherapySpecialistName,
            'uid':physiotherapySpecialistId,
          });

      var addToAdminPhysiotherapy=Admin_Specialists.doc(physiotherapySpecialistId).collection("Students").doc(email).set({
        'center':userAdmin,
        'name':name,
        'uid':email,
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
      );


      var addToUsers=Users.doc(email)
          .set({
        "isAuth":false,
        'uid': email,
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
      });

      Navigator.pop(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MainAdminScreen(2)));
    };

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


class StudentCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    User userAdmin =  FirebaseAuth.instance.currentUser;
    //References
    CollectionReference Students = FirebaseFirestore.instance.collection('Students');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Students=Admin.doc(userAdmin.email).collection('Students');
    AuthService _auth=AuthService();

    return StreamBuilder<QuerySnapshot>(
      stream:
      Admin_Students.snapshots(),
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
                         Admin_Students.doc(document.id).delete();
    }
                        ),
                        title: new Text(document.data()['name'], style: kTextPageStyle),
                        subtitle: new Text("طالب", style: kTextPageStyle),
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