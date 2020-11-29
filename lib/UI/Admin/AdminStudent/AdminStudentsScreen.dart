import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constance.dart';
import 'AddStudent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'StudentDetails.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {


  String searchResult = '';

  Widget build(BuildContext context) {

    User userAdmin =  FirebaseAuth.instance.currentUser;
    //References
    CollectionReference students = FirebaseFirestore.instance.collection('Students');
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    CollectionReference teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference specialists= FirebaseFirestore.instance.collection('Specialists');

    return SafeArea(
        child: Scaffold(
          body: Container(
              color: kBackgroundPageColor,
              padding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: Column(children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple,width: 2)),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "أدخل اسم الطالب",
                    prefixIcon: Icon(Icons.search,color: Colors.deepPurple,),
                  ),
                  onChanged: (string) {
                    setState(() {
                      searchResult = string;
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
                    child: Text(" إضافة طالب", style: kTextPageStyle),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddStudentScreen()),
                      );
                    },
                  )
                ]),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child:
                        StreamBuilder<QuerySnapshot>(
                          stream:
                          students.where('center',isEqualTo: userAdmin.email).snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) return Center(child:SpinKitFoldingCube(color: kUnselectedItemColor, size: 60,));
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting: return Center(child:SpinKitFoldingCube(color: kUnselectedItemColor, size: 60,));
                              default:
                                return  ListView.builder(
                                    physics: ScrollPhysics(),
                                    itemCount: snapshot.data.docs.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context,index){
                                      DocumentSnapshot document =snapshot.data.docs[index];
                                      String name = document.data()['name'];
                                      if(name.toLowerCase().contains(searchResult) || name.toUpperCase().contains(searchResult.toUpperCase())){
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
                                            // trailing: IconButton(icon: Icon (Icons.delete),
                                            //     onPressed: () {
                                            //       return Alert(
                                            //         context: context,
                                            //         type: AlertType.error,
                                            //         title: " هل أنت مـتأكد من حذف ${document.data()['name']} ؟ ",
                                            //         desc: "",
                                            //         buttons: [
                                            //           DialogButton(
                                            //             child: Text(
                                            //               "لا",
                                            //               style: TextStyle(color: Colors.white, fontSize: 20),
                                            //             ),
                                            //             onPressed: () => Navigator.pop(context),
                                            //             color: kButtonColor,
                                            //           ),
                                            //           DialogButton(
                                            //             child: Text(
                                            //               "نعم",
                                            //               style: TextStyle(color: Colors.white, fontSize: 20),
                                            //             ),
                                            //             onPressed: ()
                                            //             {
                                            //               students.doc(document.id).delete();
                                            //               users.doc(document.id).delete();
                                            //
                                            //
                                            //               teachers.get().then((value) =>
                                            //                   value.docs.forEach((element) {
                                            //                     teachers.doc(element.id).collection('Students').doc(document.id).delete();
                                            //                   }));
                                            //
                                            //               specialists.get().then((value) =>
                                            //                   value.docs.forEach((element) {
                                            //                     specialists.doc(element.id).collection('Students').doc(document.id).delete();
                                            //                   }));
                                            //
                                            //               FirebaseFirestore.instance.collection('NoAuth').doc(document.id).delete()
                                            //                   .catchError((e)=> print(e));
                                            //
                                            //               Navigator.pop(context);
                                            //             },
                                            //             color: kButtonColor,
                                            //           ),
                                            //         ],
                                            //       ).show();
                                            //     }
                                            // ),
                                            title: new Text(document.data()['name'], style: kTextPageStyle),
                                            subtitle: new Text("طالب", style: kTextPageStyle),
                                          ));}
                                      else return SizedBox();
                                    });
                            }
                          },
                        )
                    )) // here we add the snapshot from database
              ])),
        ));

  }
}
