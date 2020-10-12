import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Specialist.dart';
import '../../Constance.dart';
import 'AddSpecialis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'SpecialistDetails.dart';


class SpecialistScreen extends StatefulWidget {
  @override

  _SpecialistScreenState createState() => _SpecialistScreenState();
}
class _SpecialistScreenState extends State<SpecialistScreen> {
  List<Specialist> specialists= [];
  List<Specialist> FilteringSpecialists = [];

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
                    hintText: "أدخل اسم الأخصائي",
                    prefixIcon: Icon(Icons.search),
                  ),

                  onChanged: (string) {
                    setState(() {
                      FilteringSpecialists  = (specialists .where((element) =>
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
                    child: Text(" إضافة أخصائي", style: kTextPageStyle),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddSpecialistScreen()),
                      );
                    },
                  )
                ]),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child:
                       SpecialistCards())) // here we add the snapshot from database
              ])),
        ));
  }
}


class SpecialistCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User userAdmin =  FirebaseAuth.instance.currentUser;
    //ReferenceS
    CollectionReference Specialists= FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Specialists = Admin.doc(userAdmin.email.toLowerCase()).collection('Specialists');



    return StreamBuilder<QuerySnapshot>(
      stream:
      Admin_Specialists.snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child:SpinKitFoldingCube(color: kUnselectedItemColor, size: 60,));
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child:SpinKitFoldingCube(color: kUnselectedItemColor, size: 60,));
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
                                        SpecialistInfo(document.data()['uid'])));
                          },
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
                                        Specialists.doc(document.id).delete();
                                        Users.doc(document.id).delete();
                                        Admin.doc(userAdmin.email.toLowerCase()).collection('Specialists').doc(document.id).delete();

                                        Admin_Specialists.doc(document.id).collection("Students").get().then((value) =>
                                            value.docs.forEach((element) {
                                              Admin_Specialists.doc(document.id).collection('Students').doc(element.id).delete();
                                            })
                                        );

                                        Specialists.doc(document.id).collection("Students").get().then((value) =>
                                            value.docs.forEach((element) {
                                              Specialists.doc(document.id).collection('Students').doc(element.id).delete();
                                            })
                                        );
                                      Navigator.pop(context);
                                      },
                                      color: kButtonColor,
                                    ),
                                  ],
                                ).show();
                              }
                          ),
                          title:  Text(document.data()['name'], style: kTextPageStyle),
                          subtitle:  Text( document.data()["isAuth"]==true? document.data()["typeOfSpechalist"]:" لم تتم المصادقة",style: kTextPageStyle),

                        ));
                  }
                  else{
                    return Card(
                      color: Color(0xffffd6d6),
                      borderOnForeground: true,
                      child: ListTile(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SpecialistInfo(document.data()['uid'])));
                        },
                        trailing: IconButton(icon: Icon (Icons.delete),
                            onPressed: () {
                              return Alert(
                                context: context,
                                type: AlertType.error,
                                title: "هل أنت مـتأكد من حذف ${document.data()['name']} ؟ ",
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
                                      Specialists.doc(document.id).delete();
                                      Users.doc(document.id).delete();
                                      Admin.doc(userAdmin.email.toLowerCase()).collection('Specialists').doc(document.id).delete();

                                      Admin_Specialists.doc(document.id).collection("Students").get().then((value) =>
                                          value.docs.forEach((element) {
                                            Admin_Specialists.doc(document.id).collection('Students').doc(element.id).delete();
                                          })
                                      );

                                      Specialists.doc(document.id).collection("Students").get().then((value) =>
                                          value.docs.forEach((element) {
                                            Specialists.doc(document.id).collection('Students').doc(element.id).delete();
                                          })
                                      );

                                      Navigator.pop(context);
                                    },
                                    color: kButtonColor,
                                  ),
                                ],
                              ).show();
                            }
                        ),
                        title:  Text(document.data()['name'], style: kTextPageStyle),
                        subtitle:  Text( document.data()["isAuth"]==true? "أخصائي ${document.data()['typeOfSpechalist']}":" لم تتم المصادقة",style: kTextPageStyle),
                      ),
                    );
                    //
                  }


                }).toList());
        }
      },
    );
  }}
