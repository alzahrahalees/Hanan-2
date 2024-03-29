import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constance.dart';
import '../AdminMainScreen.dart';
import 'SpecialistStudents.dart';

class SpecialistInfo extends StatefulWidget {
  String uid;

  SpecialistInfo(String uid) {
    this.uid = uid;
  }

  @override
  _SpecialistInfoState createState() => _SpecialistInfoState(uid);
}

class _SpecialistInfoState extends State<SpecialistInfo> {
  String uid;

  _SpecialistInfoState(String uid) {
    this.uid = uid;
  }

  String gender1;
  List<String> list = ["أنثى", "ذكر"];
  int selectedIndex;

  void changeIndex(int index) async {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget RadioButton(String txt, int index) {
    return OutlineButton(
      onPressed: () {
        changeIndex(index);
        selectedIndex == 0 ? gender1 = list[0] : gender1 = list[1];
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
    );
  }

  String typeOfSpechalist;
  List<String> items = [
    "أخصائي علاج طبيعي",
    "أخصائي علاج وظيفي",
    "أخصائي نفسي",
    "أخصائي تخاطب"
  ];

  @override
  Widget build(BuildContext context) {
    User userAdmin = FirebaseAuth.instance.currentUser;
    //Reference
    CollectionReference Specialists =
        FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');


    String gender = gender1;
    String name;
    String age;
    String phone;
    String email;

    final formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("معلومات الأخصائي ", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    Specialists.where('uid', isEqualTo: uid).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        alignment: Alignment.topRight,
                        child: Form(
                            key: formkey,
                            // here we add the snapshot from database
                            child: ListView(
                                shrinkWrap: true,
                                children: snapshot.data.docs
                                    .map((DocumentSnapshot document) {
                                  name = document.data()['name'];
                                  age = document.data()['age'];
                                  phone = document.data()['phone'];
                                  email = document.data()['email'];
                                  String newName;
                                  String newAge;
                                  String newPhone;
                                  //selectedIndex= document.data()['gender']=='ذكر'? 1:0;

                                  return Column(children: <Widget>[
                                    ProfileTile(
                                      readOnly: false,
                                      color: kWolcomeBkg,
                                      title: document.data()['name'],
                                      hintTitle: "الإسم",
                                      icon: Icons.person,
                                      onChanged: (value) => newName = value,
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    ProfileTile(
                                      readOnly: false,
                                      color: kWolcomeBkg,
                                      title: document.data()['age'],
                                      hintTitle: "العمر",
                                      icon: Icons.assistant_outlined,
                                      onChanged: (value) => newAge = value,
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    ProfileTile(
                                      readOnly: true,
                                      color: kWolcomeBkg,
                                      title: document.data()['email'],
                                      hintTitle: "البريد الإلكتروني",
                                      icon: Icons.alternate_email_outlined,
                                      onChanged: (value) => email = value,
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    ProfileTile(
                                      readOnly: false,
                                      color: kWolcomeBkg,
                                      title: document.data()['phone'],
                                      hintTitle: "رقم الهاتف",
                                      icon: Icons.phone,
                                      onChanged: (value) => newPhone = value,
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 5,
                                          right: 8),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Circle(
                                                  child:
                                                      Icon(Icons.accessibility),
                                                  color: kWolcomeBkg,
                                                ),
                                                SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text("الجنس",
                                                          style: kTextPageStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey)),
                                                    ),
                                                    Container(
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            RadioButton(
                                                                list[0], 0),
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10)),
                                                            RadioButton(
                                                                list[1], 1),
                                                          ],
                                                        ),
                                                      ),
                                                      // Padding(padding: EdgeInsets.all(30)),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 5,
                                          right: 8),
                                      child: Row(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Circle(
                                            color: kWolcomeBkg,
                                            child: Icon(Icons.info),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("التخصص",
                                                  style:
                                                      kTextPageStyle.copyWith(
                                                          color: Colors.grey)),
                                              SizedBox(
                                                height: 40,
                                                width: 200,
                                                child: DropdownButton(
                                                  hint: Text(document.data()['typeOfSpechalist'],
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  // Not necessary for Option 1
                                                  value: typeOfSpechalist,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      typeOfSpechalist =
                                                          newValue;
                                                    });
                                                  },
                                                  items: items.map((location) {
                                                    return DropdownMenuItem(
                                                      child: Text(location),
                                                      value: location,
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),

                                    Padding(padding: EdgeInsets.all(10)),
                                    InkWell(
                                      child: Text("إضغط هنا لعرض الطلاب",style: kTextPageStyle.copyWith(fontSize: 20),),
                                      onTap:(){Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (
                                                  context) =>
                                                  SpecialistStudents(uid)));} ,
                                    ),
                                    Padding(padding: EdgeInsets.all(10)),


                                    Padding(
                                        padding: EdgeInsets.only(right: 90)),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          color: kButtonColor,
                                          child: Text("تعديل",
                                              style: kTextButtonStyle),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0)),
                                          onPressed: () {
                                            if (formkey.currentState
                                                .validate()) {
                                              Specialists.doc(uid).update({
                                                'name': newName == null
                                                    ? name
                                                    : newName,
                                                'age': newAge == null
                                                    ? age
                                                    : newAge,
                                                'phone': newPhone == null
                                                    ? phone
                                                    : newPhone,
                                              });
                                              if (gender != null) {
                                                Specialists.doc(uid).update({
                                                  'gender': gender,
                                                });
                                              }
                                              if (typeOfSpechalist != null) {
                                                Specialists.doc(uid).update({
                                                  'typeOfSpechalist':
                                                      typeOfSpechalist,
                                                });
                                              }

                                              Users.doc(uid).update({
                                                'name': newName == null
                                                    ? name
                                                    : newName,
                                                'age': newAge == null
                                                    ? age
                                                    : newAge,
                                                'phone': newPhone == null
                                                    ? phone
                                                    : newPhone,
                                              });
                                              if (gender != null) {
                                                Users.doc(uid).update({
                                                  'gender': gender,
                                                });
                                              }
                                              if (typeOfSpechalist != null) {
                                                Users.doc(uid).update({
                                                  'typeOfSpechalist':
                                                      typeOfSpechalist,
                                                });
                                              }

                                              Navigator.pop(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainAdminScreen(1)));
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ]);
                                }).toList())));
                  } else {
                    return Text("");
                  }
                })));
  }
}
