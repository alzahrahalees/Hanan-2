import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanan/services/auth.dart';
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
  final formKey;

  AddTeacher({this.formKey,this.name,this.age,this.email,this.phone,this.type,this.gender,this.birthday});


  @override
  Widget  build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    User userAdmin =  FirebaseAuth.instance.currentUser;
    //Reference
    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Teachers =Admin.doc(userAdmin.email).collection('Teachers');


    Future<void> addTeacher() async{
      //problem:the document must be have the same ID
      var NoAuth =FirebaseFirestore.instance.collection('NoAuth').doc(email)
          .set({});


     var addToAdminTeachers=Admin_Teachers.doc(email)
          .set({
       "isAuth":false,
       "center":userAdmin.email,
       "uid":email,
       'name': name,
       'age': age,
       'email': email,
       'phone': phone,
       "gender": gender,
       "type": type,
       "birthday": birthday.toString(),});


      //problem:the document must be have the same ID


     var addToTeachers=Teachers.doc(email)
         .set({
       "isAuth":false,
       "center":userAdmin.email,
       "uid":email,
       'name': name,
       'age': age,
       'email': email,
       'phone': phone,
       "gender": gender,
       "type": type,
       "birthday": birthday.toString(),
     });

      var addToUsers=Users.doc(email)
          .set({
        'uid':email,
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
        if(formKey.currentState.validate())
        {addTeacher();}
     },
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

class TeacherCards extends StatelessWidget {
@override
Widget build(BuildContext context) {

  User userAdmin =  FirebaseAuth.instance.currentUser;
  //Reference
  CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
  CollectionReference Users = FirebaseFirestore.instance.collection('Users');
  CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
  CollectionReference Admin_Teachers =Admin.doc(userAdmin.email).collection('Teachers');
  CollectionReference Admin_Students=Admin.doc(userAdmin.email).collection('Students');
  AuthService _auth=AuthService();

  return StreamBuilder<QuerySnapshot>(
    stream:
    Admin_Teachers.snapshots(),
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
                Admin_Teachers.where(document.data()['isAuth'],isEqualTo: true).get().then((value) =>
                //return ListView.builder(
                //  padding: EdgeInsets.all(10.0),
                //  itemCount: FilteringTeachers.length,
                // itemBuilder: (BuildContext context, int index) {
                Card(
                    borderOnForeground: true,
                    child: ListTile(
                      trailing: IconButton(icon: Icon (Icons.delete),
                          onPressed: () {
                            Teachers.doc(document.id).delete();
                            Users.doc(document.id).delete();

                            Admin_Teachers.doc(document.id).delete();

                      }
                      ),
                      title: new Text(document.data()['name'], style: kTextPageStyle),
                      subtitle: new Text("معلم", style: kTextPageStyle),
                    )));
              }).toList());
      }
    },
  );
}}

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