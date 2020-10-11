import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanan/UI/Admin/AdminTeacher/TeacherDetails.dart';
import 'package:hanan/services/auth.dart';
import 'Constance.dart';
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
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Teachers =Admin.doc(userAdmin.email).collection('Teachers');


   final List<String>TeachersL=[];
  Future <void> TeacherListNames() async {

      await Admin.doc(userAdmin.email).collection('Teachers').where('type',isEqualTo: "Teachers").get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs
            .forEach((doc) {
          TeachersL.add(doc.data()['name']);
        }
        )

        ;});
    }

    Future<void> addTeacher() async{
      //problem:the document must be have the same ID


      var NoAuth =FirebaseFirestore.instance.collection('NoAuth').doc(email.toLowerCase()).set({});


     var addToAdminTeachers=Admin_Teachers.doc(email.toLowerCase())
          .set({
       "isAuth":false,
       "center":userAdmin.email.toLowerCase(),
       "uid":email.toLowerCase(),
       'name': name,
       'age': age,
       'email': email,
       'phone': phone,
       "gender": gender,
       "type": type,
       "birthday": birthday.toString(),});


      //problem:the document must be have the same ID

     var addToTeachers=Teachers.doc(email.toLowerCase())
         .set({
       "isAuth":false,
       "center":userAdmin.email.toLowerCase(),
       "uid":email.toLowerCase(),
       'name': name,
       'age': age,
       'email': email,
       'phone': phone,
       "gender": gender,
       "type": type,
       "birthday": birthday.toString(),
     });

      var addToUsers=Users.doc(email.toLowerCase())
          .set({
        "isAuth":false,
        'uid':email.toLowerCase(),
        'name': name,
        'age': age,
        'email': email,
        'phone': phone,
        "gender": gender,
        "type": type,
        "birthday": birthday.toString()
      });



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
       onPressed:() {
         if (formkey.currentState.validate()) {
           addTeacher();
         }


       }   );
  }
}


//document.data()['name']
//componentDidMount() {
//
//       let user = firebase.auth().currentUser;
//
//       let name, email, photoUrl, uid, emailVerified;
//
//       if (user) {
//         name = user.displayName;
//         email = user.email;
//         photoUrl = user.photoURL;
//         emailVerified = user.emailVerified;
//         uid = user.uid;
//
//         if
//           email = user.providerData[0].email;
//         }
//
//         console.log(name, email, photoUrl, emailVerified, uid);
//       }
//
//     }