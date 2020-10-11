import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminTeacher/TeacherDetails.dart';
import '../../Constance.dart';
import '../../Teacher.dart';
import 'AddTeacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class TeacherScreen extends StatefulWidget {

  Teacher newTeacher;

  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {


  List<Teacher> teachers= [];
  dynamic FilteringTeachers = [];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
              color: kBackgroundPageColor,
              padding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: Column(children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "أدخل اسم المعلم",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (string) {
                    setState(() {
                      FilteringTeachers= (teachers.where((element) =>
                      element.name.contains(string) ||
                          element.position.contains(string))).toList();
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                ),
                Row(children: <Widget>[
                  Icon(Icons.person_add),
                  Padding(padding: EdgeInsets.all(3)),
                  GestureDetector(
                    child: Text(" إضافة معلم", style: kTextPageStyle),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddTeacherScreen()),
                      );
                    },
                  )
                ]),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child:
                        TeacherCards())) // here we add the snapshot from database
              ])),
        ));

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
    CollectionReference Admin_Teachers =Admin.doc(userAdmin.email.toLowerCase()).collection('Teachers');
    CollectionReference Admin_Students=Admin.doc(userAdmin.email.toLowerCase()).collection('Students');

    return StreamBuilder<QuerySnapshot>(
      stream:
      Admin_Teachers.snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child:SpinKitFoldingCube(
          color: kUnselectedItemColor,
          size: 60,
        )
          ,);
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child:SpinKitFoldingCube(
              color: kUnselectedItemColor,
              size: 60,
            )
              ,);
          default:
            return new ListView(

                children:

                snapshot.data.docs.map((DocumentSnapshot document) {
                  if (document.data()["isAuth"]==true ){
                    return Card(
                        borderOnForeground: true,
                        child: ListTile(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TeacherInfo(document.data()['uid'])));
                            },
                          trailing: IconButton(icon: Icon (Icons.delete),
                              onPressed: () {
                                return Alert(
                                  // content: Icon(Icons.clear, color: Colors.red,),
                                  context: context,
                                  type: AlertType.error,
                                  title: " هل أنت مـتأكد من حذف  ${document.data()['name']} ؟ ",
                                  desc: "",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "لا",
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      color: kButtonColor,
                                    ),
                                    DialogButton(
                                      child: Text(
                                        "نعم",
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: ()
                                      {

                                      Teachers.doc(document.id).delete();
                                      Users.doc(document.id).delete();
                                      Admin.doc(userAdmin.email.toLowerCase()).collection('Teachers').doc(document.id).delete();
                                      Navigator.pop(context);
                                        },
                                      color: kButtonColor,
                                    ),
                                  ],
                                ).show();
                              }
                          ),
                          title:  Text(document.data()['name'], style: kTextPageStyle),
                          subtitle:  Text( document.data()["isAuth"]==true? "معلم":" لم تتم المصادقة",style: kTextPageStyle),

                        ));}
                  else{
                    return Card(
                      color: Color(0xffffd6d6),
                      borderOnForeground: true,
                      child: ListTile(
                        trailing: IconButton(icon: Icon (Icons.delete),
                            onPressed: () {
                              return Alert(
                                context: context,
                                type: AlertType.error,
                                title: " هل أنت مـتأكد من حذف  ${document.data()['name']} ؟ ",
                                desc: "",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "لا",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    color: kButtonColor,
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "نعم",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: ()
                                    {

                                      Teachers.doc(document.id).delete();
                                      Users.doc(document.id).delete();
                                      Admin.doc(userAdmin.email.toLowerCase()).collection('Teachers').doc(document.id).delete();
                                      Navigator.pop(context);
                                    },
                                    color: kButtonColor,
                                  ),
                                ],
                              ).show();
                            }
                        ),
                        title:  Text(document.data()['name'], style: kTextPageStyle),
                        subtitle:  Text( document.data()["isAuth"]==true? "معلم":" لم تتم المصادقة",style: kTextPageStyle),
                      ),
                    );
                    //
                  }}).toList());
        }
      },
    );


  }
}



//
//
//
// Card(
//                     //                     borderOnForeground: true,
//                     //                     child: ListTile(
//                     //                       trailing: IconButton(icon: Icon (Icons.delete),
//                     //                           onPressed: () {
//                     //                           Teachers.doc(document.id).delete();
//                     //                             Users.doc(document.id).delete();
//                     //                             Admin.doc(userAdmin.email.toLowerCase()).collection('Teachers').doc(document.id).delete();}
//                     //                       ),
//                     //                       title:  Text(document.data()['name'], style: kTextPageStyle),
//                     //                       subtitle:  Text( document.data()["isAuth"]==true? "معلم":" لم تتم المصادقة",style: kTextPageStyle),
//                     //
//                     //                     ));