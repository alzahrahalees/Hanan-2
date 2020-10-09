import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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


    Future<void> addTeacher() async{
      //problem:the document must be have the same ID
      var NoAuth =FirebaseFirestore.instance.collection('NoAuth').doc(email.toLowerCase());


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
         if (formkey.currentState.validate())
         {addTeacher();}
       }

     // onPressed: () async{
     //
     //   // print(' befor adding: ${FirebaseAuth.instance.currentUser.uid}');
     //   //  addTeacher();
     //   //  await FirebaseAuth.instance.signOut();
     //   // print(' after sign out: ${FirebaseAuth.instance.currentUser.uid}');
     //   //  // await FirebaseAuth.instance.signInWithEmailAndPassword(email: 'smaile@gmail.com', password: '123456');
     //   // print(' after sign in: ${FirebaseAuth.instance.currentUser.uid}');
     // }
// smaile@gmail.com
   // brP1YIhE3YaUaf7DZ303qTSIDt63
    );
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
//         if (!email) {
//           email = user.providerData[0].email;
//         }
//
//         console.log(name, email, photoUrl, emailVerified, uid);
//       }
//
//     }