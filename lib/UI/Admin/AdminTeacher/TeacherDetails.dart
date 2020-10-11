import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constance.dart';
import '../AdminMainScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TeacherInfo extends StatefulWidget {
  String uid;
  TeacherInfo(String uid) {this.uid=uid;}
  @override
  _TeacherInfoState createState() => _TeacherInfoState(uid);
}

class _TeacherInfoState extends State<TeacherInfo> {

  String uid;
  _TeacherInfoState (String uid) {this.uid=uid;}
  String gender1;
  List<String> list =["أنثى","ذكر"];
  int selectedIndex;
  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });}

  Widget RadioButton(String txt, int index) {
    return OutlineButton(
      onPressed: () {
        changeIndex(index);
        selectedIndex == 0 ? gender1 = list[0] : gender1 = list[1];
        print (gender1);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color:
          selectedIndex == index ? Colors.deepPurpleAccent : Colors.grey),
      child: Text(txt,
          style: TextStyle(
              color: selectedIndex == index
                  ? Colors.deepPurpleAccent
                  : Colors.grey)),
    );}

  @override
  Widget build(BuildContext context) {
    User userAdmin =  FirebaseAuth.instance.currentUser;
    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Teachers =Admin.doc(userAdmin.email).collection('Teachers');

    String gender=gender1;
    String name;
    String age;
    String phone;
    String email;

    final formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("معلومات المعلم ", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: Admin_Teachers.where('uid' ,isEqualTo:uid ).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Center(child:SpinKitFoldingCube(
                    color: kUnselectedItemColor,
                    size: 60,
                  ),
                  );
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child:SpinKitFoldingCube(
                        color: kUnselectedItemColor,
                        size: 60,
                      )
                        ,);
                      default:
                  return Container(
                  padding: EdgeInsets.all(10),
                  color: kWolcomeBkg,
                  alignment: Alignment.topRight,
                  child: Form(
                  key: formkey,
    // here we add the snapshot from database
                  child:  ListView(shrinkWrap: true, children:
                  snapshot.data.docs.map((DocumentSnapshot document) {
                    name=document.data()['name'];
                    age=document.data()['age'];
                    phone=document.data()['phone'];
                    email=document.data()['email'];

                      return Column(children: <Widget>[
                          ProfileTile(
                            readOnly: false,
                            color: kWolcomeBkg,
                            title: document.data()['name'] ,
                            hintTitle:  "الإسم",
                            icon: Icons.person,
                            onChanged: (value)=> name=value,
                          ),

                          Padding(padding: EdgeInsets.all(5)),

                          ProfileTile(
                            readOnly: false,
                            color: kWolcomeBkg,
                            title: document.data()['age'] ,
                            hintTitle:  "العمر",
                            icon: Icons.assistant_outlined,
                            onChanged: (value)=> age=value,
                          ),
                        Padding(padding: EdgeInsets.all(5)),
                        ProfileTile(
                          readOnly: true,
                          color: kWolcomeBkg,
                          title: document.data()['email'] ,
                          hintTitle:  "البريد الإلكتروني",
                          icon: Icons.alternate_email_outlined,
                          onChanged: (value)=> email=value,
                          ),
                        Padding(padding: EdgeInsets.all(5)),
                        ProfileTile(
                          readOnly: false,
                          color: kWolcomeBkg,
                          title: document.data()['phone'] ,
                          hintTitle:  "رقم الهاتف",
                          icon: Icons.phone,
                          onChanged: (value)=> phone=value,
                        ),

                        Padding(padding: EdgeInsets.all(5)),


                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10,left: 5,right: 8),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Circle(
                                  child: Icon(Icons.accessibility),
                                  color: kWolcomeBkg,),
                                    SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text("الجنس",
                                          style: kTextPageStyle.copyWith(
                                              color: Colors.grey)),
                                    ),
                                    Container(
                                        child: Container(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    RadioButton(list[0], 0),
                                                    Padding(padding:  EdgeInsets.all(10)),
                                                    RadioButton(list[1], 1),
                                                  ],
                                                ),
                                              ),
                                              // Padding(padding: EdgeInsets.all(30)),


                                    )
                                  ],
                                ),

                              ]
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: kButtonColor,
                                  child: Text("تعديل", style: kTextButtonStyle),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0)),
                                  onPressed:() {
                                    if (formkey.currentState.validate()){
                                      Admin_Teachers.doc(uid).update({
                                        'name':name,
                                        'age':age,
                                        'phone':phone,
                                      });
                                      if (gender!=null){
                                        Admin_Teachers.doc(uid).update({
                                          'gender':gender,
                                        });
                                      }
                                      Teachers.doc(uid).update({
                                        'name':name,
                                        'age':age,
                                        'phone':phone,
                                      });
                                      if (gender!=null){
                                        Teachers.doc(uid).update({
                                          'gender':gender,
                                        });
                                      }

                                      Users.doc(uid).update({
                                        'name':name,
                                        'age':age,
                                        'phone':phone,
                                      });
                                      if (gender!=null){
                                        Users.doc(uid).update({
                                          'gender':gender,
                                        });
                                      }
                                      Navigator.pop(context, MaterialPageRoute(
                                          builder: (context) =>
                                              MainAdminScreen(0)));
                                    }
                                    },

                                ),
                              ),



      //     RaisedButton(
      // color: kButtonColor,
      // child: Text("الغاء", style: kTextButtonStyle),
      // shape: RoundedRectangleBorder(
      // borderRadius: BorderRadius.circular(18.0)),
      // onPressed:(){
      //   Navigator.pop(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             MainAdminScreen(0)));}
      //             )
        ],
      ),
                        ),
    ]
                      );
    }
    ).toList()
    )
    )
    );
    }
              }
    )
        )
    );
  }
}
