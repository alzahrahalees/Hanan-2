import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  String searchResult = '';

  Widget build(BuildContext context) {

    User userAdmin =  FirebaseAuth.instance.currentUser;
    //ReferenceS
    CollectionReference Specialists= FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Specialists = Admin.doc(userAdmin.email.toLowerCase()).collection('Specialists');




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
                        borderSide: BorderSide(color: Colors.deepPurple,width: 2),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "أدخل اسم الأخصائي",
                    prefixIcon: Icon(Icons.search,color: Colors.deepPurple,)
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
                        StreamBuilder<QuerySnapshot>(
                          stream:
                          Admin_Specialists.snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) return Center(child:SpinKitFoldingCube(color: kUnselectedItemColor, size: 60,));
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(child:SpinKitFoldingCube(color: kUnselectedItemColor, size: 60,));
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
                                          color:  document.data()["isAuth"]==false ?Color(0xffffd6d6): Colors.white,
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

                                                          FirebaseFirestore.instance.collection('NoAuth').doc(document.id).delete()
                                                              .catchError((e)=> print(e));
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

                                          ));}
                                      else return SizedBox();
                                    });
                            }
                          },
                        )
                    )
                ) // here we add the snapshot from database
              ])),
        ));
  }
}

