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


      var addToAdminTeacherStudent= Admin_Teachers.doc(teacherId).collection('Students').doc(email.toLowerCase()).
          set({
        'uid': email.toLowerCase(),
      });


      var addTeacherStudent= Teachers.doc(teacherId).collection('Students').doc(email.toLowerCase()).
      set({
        'name': name,
        'uid': email.toLowerCase(),
      } );

    if (psychologySpecialistId != null){


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
        "center": userAdmin.email.toLowerCase(),
        }
      );



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
        "center": userAdmin.email.toLowerCase(),
      }
      );}

     if (communicationSpecialistId != null){


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
        "center": userAdmin.email.toLowerCase(),
        });


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
        "center": userAdmin.email.toLowerCase(),

      });}


      if (occupationalSpecialistId != null){


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
        "center": userAdmin.email.toLowerCase(),
        });


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
        "center": userAdmin.email.toLowerCase(),
      });}

      if (physiotherapySpecialistId != null){

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
        "center": userAdmin.email.toLowerCase(),
        }
       );


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
        "center": userAdmin.email.toLowerCase(),
      }
      );}


      var addToUsers=Users.doc(email.toLowerCase())
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

