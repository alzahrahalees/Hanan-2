import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



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
  final  formkey ;

  AddTeacher({this.formkey,this.name,this.age,this.email,this.phone,this.type,this.gender,this.birthday});


  @override
  Widget  build(BuildContext context) {
    User userAdmin =  FirebaseAuth.instance.currentUser;
    //Reference
    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');





    Future<void> addTeacher() async{
      //problem:the document must be have the same ID

      var exists = await FirebaseFirestore.instance.collection('Users')
              .doc(email.toLowerCase()).get();
      bool isExists = (exists.exists);
        if(!isExists){

      var NoAuth =FirebaseFirestore.instance.collection('NoAuth').doc(email.toLowerCase()).set({});




      //problem:the document must be have the same ID

     var addToTeachers=Teachers.doc(email.toLowerCase())
         .set({
       "isAuth":false,
       "center":userAdmin.email.toLowerCase(),
       "uid":email.toLowerCase(),
       'name': name,
       'age': age,
       'email': email.toLowerCase(),
       'phone': phone,
       "gender": gender,
       "type": type,
       "birthday": birthday.toString(),
     });

      var addToUsers=Users.doc(email.toLowerCase())
          .set({
        "center": userAdmin.email.toLowerCase(),
        "isAuth":false,
        'uid':email.toLowerCase(),
        'name': name,
        'age': age,
        'email': email.toLowerCase(),
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday.toString()
      });
}

        Navigator.pop(context, MaterialPageRoute(builder: (context) => MainAdminScreen(0)));}


   return RaisedButton(
      color: kButtonColor,
      child: Text("إضافة", style: kTextButtonStyle),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0)),
       onPressed:() {
         if (formkey.currentState.validate()) {
           addTeacher();
         }


       }   );
  }
}
