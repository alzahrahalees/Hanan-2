import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:hanan/services/auth.dart';
import 'StudentDetails.dart';
import '../../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      CollectionReference Students = FirebaseFirestore.instance.collection('Students');
      CollectionReference Users = FirebaseFirestore.instance.collection('Users');
      CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
      CollectionReference Specialists = FirebaseFirestore.instance.collection('Specialists');
      CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
      CollectionReference Admin_Teachers =Admin.doc(userAdmin.email).collection('Teachers');
      CollectionReference Admin_Specialists = Admin.doc(userAdmin.email).collection('Specialists');
      CollectionReference Admin_Students=Admin.doc(userAdmin.email).collection('Students');

      var exists = await FirebaseFirestore.instance.collection('Users')
          .doc(email).get();
      bool isExists = (exists.exists);
      //problem:the document must be have the same ID

       if(!isExists)   {

         var addTpNoAuth =FirebaseFirestore.instance.collection('NoAuth')
             .doc(email.toLowerCase()).set({});

      var addToStudent = Students.doc(email.toLowerCase()).set({
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

      var addStudyCasesF= Students.doc(email.toLowerCase()).collection('StudyCases').doc(email.toLowerCase()+'family').set({});
      var addStudyCasesC= Students.doc(email.toLowerCase()).collection('StudyCases').doc(email.toLowerCase()+'clinical').set({});
      var addStudyCasesS= Students.doc(email.toLowerCase()).collection('StudyCases').doc(email.toLowerCase()+'info').set({});

      var addToAdminStudent = Admin_Students.doc(email.toLowerCase()).set({
        "isAuth":false,
        'center': userAdmin.email.toLowerCase(),
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

     /* var addToAdminStudentTeacher = Admin_Students.doc(email.toLowerCase()).collection('Teachers').doc(teacherId).set(
          {
             'name': teacherName,
              'uid': teacherId,
          });*/

      var addToAdminTeacherStudent= Admin_Teachers.doc(teacherId).collection('Students').doc(email.toLowerCase()).
          set({
        'uid': email.toLowerCase(),
      });

      /*var addToStudentTeacher = Students.doc(email.toLowerCase()).collection('Teachers').doc(teacherId).set(
          {
            'name': teacherName,
            'uid': teacherId,
          });*/

      var addTeacherStudent= Teachers.doc(teacherId).collection('Students').doc(email.toLowerCase()).
      set({
        'name': name,
        'uid': email.toLowerCase(),
      } );

    if (psychologySpecialistId != null){
    /*  var addToStudentPsychologyS = Students.doc(email.toLowerCase()).collection('psychologySpecialist').doc(psychologySpecialistId).set(
          {
            'name': psychologySpecialistName,
            'uid': psychologySpecialistId,
          });*/

      var addPsychologyStudent=Specialists.doc(psychologySpecialistId).collection('Students').doc(email.toLowerCase()).
      set({

        'uid': email.toLowerCase(),
        'name':name,
        'gender':gender,
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
        }
      );

   /*   var addToAdminStudentPsychologyS = Admin_Students.doc(email.toLowerCase())
          .collection('psychologySpecialist').doc(psychologySpecialistId).set(
          {
            'name': psychologySpecialistName,
            'uid': psychologySpecialistId,
          });*/

      var addAdminPsychologyStudent=Admin_Specialists.doc(psychologySpecialistId)
          .collection('Students').doc(email.toLowerCase()).
      set({
        'uid': email.toLowerCase(),
        'name':name,
        'gender':gender,
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
      }
      );}

     if (communicationSpecialistId != null){

      /*var addToStudentCommunicationS = Students.doc(email.toLowerCase())
          .collection('CommunicationSpecialist').doc(communicationSpecialistId).set(
          {
            'name': communicationSpecialistName,
            'uid': communicationSpecialistId,
          });*/

      var addCommunicationStudent=Specialists.doc(communicationSpecialistId)
          .collection('Students').doc(email.toLowerCase()).
      set({
          'uid': email.toLowerCase(),
        'name':name,
        'gender':gender,
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

      /*var addToAdminStudentCommunicationS = Admin_Students.doc(email.toLowerCase())
          .collection('CommunicationSpecialist').doc(communicationSpecialistId).set(
          {
            'name': communicationSpecialistName,
            'uid': communicationSpecialistId,
          });*/

      var addAdminCommunicationStudent=Admin_Specialists.doc(communicationSpecialistId)
          .collection('Students').doc(email.toLowerCase()).
      set({
        'uid': email.toLowerCase(),
        'name':name,
        'gender':gender,
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

      });}


      if (occupationalSpecialistId != null){
      /*var addToStudentOccupationalS = Students.doc(email.toLowerCase())
          .collection('OccupationalSpecialist').doc(occupationalSpecialistId).set(
          {
            'name': occupationalSpecialistName,
            'uid':occupationalSpecialistId,
          });*/


      var addOccupationalStudent=Specialists.doc(occupationalSpecialistId)
          .collection('Students').doc(email.toLowerCase()).
      set({
          'uid': email.toLowerCase(),
        'name':name,
        'gender':gender,
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

     /* var addAdminToStudentOccupationalS = Admin_Students.doc(email.toLowerCase())
          .collection('OccupationalSpecialist').doc(occupationalSpecialistId).set(
          {
            'name': occupationalSpecialistName,
            'uid':occupationalSpecialistId,
          });*/


      var addAdminOccupationalStudent=Admin_Specialists.doc(occupationalSpecialistId)
          .collection('Students').doc(email.toLowerCase()).
      set({
        'center':userAdmin.email.toLowerCase(),
        'uid': email.toLowerCase(),
        'name':name,
        'gender':gender,
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
      });}

      if (physiotherapySpecialistId != null){
     /* var addToStudentPhysiotherapyS = Students.doc(email.toLowerCase())
          .collection('PhysiotherapySpecialist').doc(physiotherapySpecialistId).set(
          {
            'name': physiotherapySpecialistName,
            'uid':physiotherapySpecialistId,
          });*/

      var addPhysiotherapy=Specialists.doc(physiotherapySpecialistId).collection("Students")
          .doc(email.toLowerCase()).set({
          'center':userAdmin,
          'uid':email.toLowerCase(),
        'name':name,
        'gender':gender,
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
        }
       );

      /*var addToAdminStudentPhysiotherapyS = Admin_Students.doc(email.toLowerCase())
          .collection('PhysiotherapySpecialist').doc(physiotherapySpecialistId).set(
          {
            'name': physiotherapySpecialistName,
            'uid':physiotherapySpecialistId,
          });*/

      var addToAdminPhysiotherapy=Admin_Specialists.doc(physiotherapySpecialistId)
          .collection("Students").doc(email.toLowerCase()).set({
        'uid':email.toLowerCase(),
        'name':name,
        'gender':gender,
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
      }
      );}


      var addToUsers=Users.doc(email.toLowerCase())
          .set({
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
    CollectionReference Admin_Students=Admin.doc(userAdmin.email.toLowerCase()).collection('Students');
    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Admin_Teachers =Admin.doc(userAdmin.email.toLowerCase()).collection('Teachers');
    CollectionReference Specialists= FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Admin_Specialists = Admin.doc(userAdmin.email.toLowerCase()).collection('Specialists');

    AuthService _auth=AuthService();

    return StreamBuilder<QuerySnapshot>(
      stream:
      Admin_Students.snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child:SpinKitFoldingCube(color: kUnselectedItemColor, size: 60));
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child:SpinKitFoldingCube(color: kUnselectedItemColor, size: 60));
          default:
            return new ListView(
                children:
                snapshot.data.docs.map((DocumentSnapshot document) {
                  return Card(
                      borderOnForeground: true,
                      child: ListTile(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                     StudentInfo(document.data()['uid'])));
                        },
                        trailing: IconButton(icon: Icon (Icons.delete),
                          onPressed: () {
                            Students.doc(document.id).delete();
                            Users.doc(document.id).delete();
                            Admin_Students.doc(document.id).delete();

                            Admin_Teachers.get().then((value) => value.docs.forEach((element) {
                                  Admin_Teachers.doc(element.id).collection('Students').doc(document.id).delete();
                                }));

                            Teachers.get().then((value) =>
                                value.docs.forEach((element) {
                                  Teachers.doc(element.id).collection('Students').doc(document.id).delete();
                                }));

                            Admin_Specialists.get().then((value) =>
                                value.docs.forEach((element) {
                                  Admin_Specialists.doc(element.id).collection('Students').doc(document.id).delete();
                                }));

                            Specialists.get().then((value) =>
                                value.docs.forEach((element) {
                                  Specialists.doc(element.id).collection('Students').doc(document.id).delete();
                                }));}),


                        title: new Text(document.data()['name'], style: kTextPageStyle),
                        subtitle: new Text("طالب", style: kTextPageStyle),
                      ));
                }).toList());
        }
      },
    );
  }}


