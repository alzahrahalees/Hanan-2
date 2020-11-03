import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constance.dart';
import '../AdminMainScreen.dart';

class StudentInfo extends StatefulWidget {
  String uid;

  StudentInfo(String uid) {
    this.uid = uid;
  }

  @override
  _StudentInfoState createState() => _StudentInfoState(uid);
}

class _StudentInfoState extends State<StudentInfo> {
  String uid;

  _StudentInfoState(String uid) {
    this.uid = uid;
  }

  String gender1;
  List<String> list = ["أنثى", "ذكر"];
  int selectedIndex;

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget RadioButton(String txt, int index) {
    return OutlineButton(
      onPressed: () {
        changeIndex(index);
        selectedIndex == 0 ? gender1 = list[0] : gender1 = list[1];
        print(gender1);
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

  String teacherId;
  String teacherName;
  String psychologySpecialistName; //نفسي
  String psychologySpecialistId;
  String communicationSpecialistName; //تخاطب
  String communicationSpecialistId;
  String occupationalSpecialistName; //,ظيفي
  String occupationalSpecialistId;
  String physiotherapySpecialistName; //علاج طبيعي
  String physiotherapySpecialistId;

  @override
  Widget build(BuildContext context) {
    User userAdmin = FirebaseAuth.instance.currentUser;
    CollectionReference Students =
        FirebaseFirestore.instance.collection('Students');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Teachers =
        FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Specialists =
        FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Admin =
        FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Teachers =
        Admin.doc(userAdmin.email).collection('Teachers');
    CollectionReference Admin_Specialists =
        Admin.doc(userAdmin.email).collection('Specialists');
    CollectionReference Admin_Students =
        Admin.doc(userAdmin.email).collection('Students');

    String gender = gender1;
    String name;
    String age;
    String phone;
    String email;
    String newName;
    String newAge;
    String newPhone;

    final formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("معلومات الطالب", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: Admin_Students.where('uid', isEqualTo: uid).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        //  color: Color(0xfff0eaf7),
                        color: kBackgroundPageColor,
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

                                  return Column(children: <Widget>[
                                    ProfileTile(
                                      title: document.data()['name'],
                                      hintTitle: "الإسم",
                                      readOnly: false,
                                      icon: Icons.person,
                                      color: kWolcomeBkg,
                                      onChanged: (value) => newName = value,
                                    ),
                                    ProfileTile(
                                      title: document.data()['age'],
                                      hintTitle: "الععمر",
                                      readOnly: false,
                                      icon: Icons.assistant_outlined,
                                      color: kWolcomeBkg,
                                      onChanged: (value) => newAge = value,
                                    ),
                                    ProfileTile(
                                      title: document.data()['email'],
                                      hintTitle: "الإيميل",
                                      readOnly: true,
                                      icon: Icons.alternate_email_outlined,
                                      color: kWolcomeBkg,
                                      onChanged: (value) {},
                                    ),
                                    ProfileTile(
                                      title: document.data()['phone'],
                                      hintTitle: "رقم الهاتف",
                                      readOnly: false,
                                      icon: Icons.phone,
                                      color: kWolcomeBkg,
                                      onChanged: (value) => newPhone = value,
                                    ),
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
                                    Padding(padding: EdgeInsets.all(10)),
                                    Row(
                                      children: [
                                        Text("المعلم المسؤول",
                                            style: kTextPageStyle.copyWith(
                                                color: Colors.black38)),
                                        new Padding(
                                          padding: new EdgeInsets.all(20),
                                          child: StreamBuilder(
                                              stream: Admin.doc(userAdmin.email)
                                                  .collection('Teachers')
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  Center(
                                                    child:
                                                        const CupertinoActivityIndicator(),
                                                  );
                                                  return DropdownButton<String>(
                                                      value: teacherName,
                                                      isDense: true,
                                                      hint: Text(
                                                          document.data()[
                                                              'teacherName']),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          teacherName =
                                                              newValue;
                                                        });
                                                        print(teacherName);
                                                      },
                                                      items: snapshot.data.docs
                                                          .map((DocumentSnapshot
                                                              document) {
                                                        return new DropdownMenuItem<
                                                                String>(
                                                            value: document
                                                                .data()["name"],
                                                            onTap: () {
                                                              teacherId =
                                                                  document.data()[
                                                                      "uid"];
                                                              print(teacherId);
                                                            },
                                                            child:
                                                                new Container(
                                                              height: 30,
                                                              //color: primaryColor,
                                                              child: new Text(
                                                                document
                                                                    .data()[
                                                                        "name"]
                                                                    .toString(),
                                                              ),
                                                            ));
                                                      }).toList());
                                                } else
                                                  return Text('');
                                              }),
                                        ),
                                      ],
                                    ),
                                    new Padding(
                                        padding: new EdgeInsets.all(10)),
                                    Row(
                                      children: [
                                        Text("الأخصائي النفسي",
                                            style: kTextPageStyle.copyWith(
                                                color: Colors.black38)),
                                        new Padding(
                                          padding: new EdgeInsets.all(20),
                                          child: StreamBuilder(
                                              stream: Admin.doc(userAdmin.email)
                                                  .collection('Specialists')
                                                  .where('typeOfSpechalist',
                                                      isEqualTo: "أخصائي نفسي")
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  Center(
                                                    child:
                                                        const CupertinoActivityIndicator(),
                                                  );
                                                  return DropdownButton<String>(
                                                      value:
                                                          psychologySpecialistName,
                                                      isDense: true,
                                                      hint: Text(document
                                                                      .data()[
                                                                  'psychologySpecialistName'] !=
                                                              null
                                                          ? document.data()[
                                                              'psychologySpecialistName']
                                                          : "لا يوجد"),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          psychologySpecialistName =
                                                              newValue;
                                                        });
                                                        print(
                                                            psychologySpecialistName);},
                                                      items: snapshot.data.docs
                                                          .map((DocumentSnapshot
                                                              document) {
                                                        return new DropdownMenuItem<String>(

                                                            value: document
                                                                .data()["name"],



                                                            onTap: () {
                                                              psychologySpecialistId =
                                                                  document.data()[
                                                                      "uid"];
                                                              print(
                                                                  physiotherapySpecialistId);
                                                            },
                                                            child:
                                                                new Container(
                                                                    height: 23,
                                                                    //color: primaryColor,
                                                                    child: new Text(
                                                                        document
                                                                            .data()["name"])));
                                                      }).toList());
                                                } else
                                                  return Text('');
                                              }),
                                        ),
                                      ],
                                    ),
                                    new Padding(
                                        padding: new EdgeInsets.all(10)),
                                    Row(
                                      children: [
                                        Text("الأخصائي الوظيفي",
                                            style: kTextPageStyle.copyWith(
                                                color: Colors.black38)),
                                        new Padding(
                                          padding: new EdgeInsets.all(20),
                                          child: StreamBuilder(
                                              stream: Admin.doc(userAdmin.email)
                                                  .collection('Specialists')
                                                  .where('typeOfSpechalist',
                                                      isEqualTo:
                                                          "أخصائي علاج وظيفي")
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  Center(
                                                    child:
                                                        const CupertinoActivityIndicator(),
                                                  );
                                                  return DropdownButton<String>(
                                                      value:
                                                          occupationalSpecialistName,
                                                      isDense: true,
                                                      hint: Text(document
                                                                      .data()[
                                                                  'occupationalSpecialistName'] !=
                                                              null
                                                          ? document.data()[
                                                              'occupationalSpecialistName']
                                                          : "لا يوجد"),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          occupationalSpecialistName =
                                                              newValue;
                                                        });
                                                        print(
                                                            occupationalSpecialistName);
                                                      },
                                                      items: snapshot.data.docs
                                                          .map((DocumentSnapshot
                                                              document) {
                                                        return new DropdownMenuItem<
                                                                String>(
                                                            value: document
                                                                .data()["name"],
                                                            onTap: () {
                                                              occupationalSpecialistId =
                                                                  document.data()[
                                                                      "uid"];
                                                              print(
                                                                  occupationalSpecialistId);
                                                            },
                                                            child:
                                                                new Container(
                                                              height: 25,
                                                              //color: primaryColor,
                                                              child: new Text(
                                                                document.data()[
                                                                    "name"],
                                                              ),
                                                            ));
                                                      }).toList());
                                                } else {
                                                  return Text('');
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                    new Padding(
                                        padding: new EdgeInsets.all(10)),
                                    Row(
                                      children: [
                                        Text(" العلاج الطبيعي",
                                            style: kTextPageStyle.copyWith(
                                                color: Colors.black38)),
                                        new Padding(
                                          padding: new EdgeInsets.all(20),
                                          child: StreamBuilder(
                                              stream: Admin.doc(userAdmin.email)
                                                  .collection('Specialists')
                                                  .where('typeOfSpechalist',
                                                      isEqualTo:
                                                          "أخصائي علاج طبيعي")
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  Center(
                                                    child:
                                                        const CupertinoActivityIndicator(),
                                                  );
                                                  return DropdownButton<String>(
                                                      value:
                                                          physiotherapySpecialistName,
                                                      isDense: true,
                                                      hint: Text(document
                                                                      .data()[
                                                                  'physiotherapySpecialistName'] !=
                                                              null
                                                          ? document.data()[
                                                              'physiotherapySpecialistName']
                                                          : "لا يوجد"),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          physiotherapySpecialistName =
                                                              newValue;
                                                        });
                                                        print(
                                                            physiotherapySpecialistName);
                                                      },
                                                      items: snapshot.data.docs
                                                          .map((DocumentSnapshot
                                                              document) {
                                                        return new DropdownMenuItem<
                                                                String>(
                                                            value: document
                                                                .data()["name"],
                                                            onTap: () {
                                                              physiotherapySpecialistId =
                                                                  document.data()[
                                                                      "uid"];
                                                              print(
                                                                  physiotherapySpecialistId);
                                                            },
                                                            child:
                                                                new Container(
                                                              height: 25,
                                                              //color: primaryColor,
                                                              child: new Text(
                                                                document.data()[
                                                                    "name"],
                                                              ),
                                                            ));
                                                      }).toList());
                                                } else {
                                                  return Text('');
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                    new Padding(
                                        padding: new EdgeInsets.all(10)),
                                    Row(
                                      children: [
                                        Text("أخصائي التخاطب",
                                            style: kTextPageStyle.copyWith(
                                                color: Colors.black38)),
                                        new Padding(
                                          padding: new EdgeInsets.all(20),
                                          child: StreamBuilder(
                                              stream: Admin.doc(userAdmin.email)
                                                  .collection('Specialists')
                                                  .where('typeOfSpechalist',
                                                      isEqualTo: "أخصائي تخاطب")
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  Center(
                                                    child:
                                                        const CupertinoActivityIndicator(),
                                                  );
                                                  return DropdownButton<String>(
                                                      value:
                                                          communicationSpecialistName,
                                                      isDense: true,
                                                      hint: Text(document
                                                                      .data()[
                                                                  'communicationSpecialistName'] !=
                                                              null
                                                          ? document.data()[
                                                              'communicationSpecialistName']
                                                          : "لا يوجد"),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          communicationSpecialistName =
                                                              newValue;
                                                        });
                                                        print(
                                                            communicationSpecialistName);
                                                      },
                                                      items: snapshot.data.docs
                                                          .map((DocumentSnapshot
                                                              document) {
                                                        return new DropdownMenuItem<
                                                                String>(
                                                            value: document
                                                                .data()["name"],
                                                            onTap: () {
                                                              communicationSpecialistId =
                                                                  document.data()[
                                                                      "uid"];
                                                              print(
                                                                  communicationSpecialistId);
                                                            },
                                                            child:
                                                                new Container(
                                                              height: 25,
                                                              //color: primaryColor,
                                                              child: new Text(
                                                                document.data()[
                                                                    "name"],
                                                              ),
                                                            ));
                                                      }).toList());
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
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
                                              Admin_Students.doc(uid).update({
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
                                                Admin_Students.doc(uid).update({
                                                  'gender': gender,
                                                });
                                              }
                                              if (teacherId != null) {
                                                Admin_Students.doc(uid).update({
                                                  'teacherId': teacherId,
                                                  'teacherName': teacherName,
                                                });
                                              }
                                              if (psychologySpecialistId !=
                                                  null) {
                                                Admin_Students.doc(uid).update({
                                                  'psychologySpecialistName':
                                                      psychologySpecialistName,
                                                  //نفسي
                                                  'psychologySpecialistId':
                                                      psychologySpecialistId,
                                                });
                                              }
                                              if (occupationalSpecialistId !=
                                                  null) {
                                                Admin_Students.doc(uid).update({
                                                  'occupationalSpecialistName':
                                                      occupationalSpecialistName,
                                                  //,ظيفي
                                                  'occupationalSpecialistId':
                                                      occupationalSpecialistId,
                                                });
                                              }
                                              if (physiotherapySpecialistId !=
                                                  null) {
                                                Admin_Students.doc(uid).update({
                                                  'physiotherapySpecialistName':
                                                      physiotherapySpecialistName,
                                                  //علاج طبيعي
                                                  'physiotherapySpecialistId':
                                                      physiotherapySpecialistId,
                                                });
                                              }

                                              if (communicationSpecialistId !=
                                                  null) {
                                                Admin_Students.doc(uid).update({
                                                  'communicationSpecialistName':
                                                      communicationSpecialistName,
                                                  //تخاطب
                                                  'communicationSpecialistId':
                                                      communicationSpecialistId,
                                                });
                                              }

                                              Students.doc(uid).update({
                                                'name': newName == null
                                                    ? name
                                                    : newName,
                                                'age': newAge == null
                                                    ? age
                                                    : newAge,
                                                'phone': phone == null
                                                    ? phone
                                                    : newPhone,
                                              });
                                              if (gender != null) {
                                                Students.doc(uid).update({
                                                  'gender': gender,
                                                });
                                              }

                                              if (teacherId != null) {
                                                Students.doc(uid).update({
                                                  'teacherId': teacherId,
                                                  'teacherName': teacherName,
                                                });
                                              }
                                              if (psychologySpecialistId !=
                                                  null) {
                                                Students.doc(uid).update({
                                                  'psychologySpecialistName':
                                                      psychologySpecialistName,
                                                  //نفسي
                                                  'psychologySpecialistId':
                                                      psychologySpecialistId,
                                                });
                                              }
                                              if (occupationalSpecialistId !=
                                                  null) {
                                                Students.doc(uid).update({
                                                  'occupationalSpecialistName':
                                                      occupationalSpecialistName,
                                                  //,ظيفي
                                                  'occupationalSpecialistId':
                                                      occupationalSpecialistId,
                                                });
                                              }
                                              if (physiotherapySpecialistId !=
                                                  null) {
                                                Students.doc(uid).update({
                                                  'physiotherapySpecialistName':
                                                      physiotherapySpecialistName,
                                                  //علاج طبيعي
                                                  'physiotherapySpecialistId':
                                                      physiotherapySpecialistId,
                                                });
                                              }

                                              if (communicationSpecialistId !=
                                                  null) {
                                                Students.doc(uid).update({
                                                  'communicationSpecialistName':
                                                      communicationSpecialistName,
                                                  //تخاطب
                                                  'communicationSpecialistId':
                                                      communicationSpecialistId,
                                                });
                                              }

                                              Users.doc(uid).update({
                                                'name': newName == null
                                                    ? name
                                                    : newName,
                                                'age': newAge == null
                                                    ? age
                                                    : newAge,
                                                'phone': phone == null
                                                    ? phone
                                                    : newPhone,
                                              });
                                              if (gender != null) {
                                                Users.doc(uid).update({
                                                  'gender': gender,
                                                });
                                              }
                                              if (teacherId != null) {
                                                Users.doc(uid).update({
                                                  'teacherId': teacherId,
                                                  'teacherName': teacherName,
                                                });
                                              }

                                              if (psychologySpecialistId !=
                                                  null) {
                                                Users.doc(uid).update({
                                                  'psychologySpecialistName':
                                                      psychologySpecialistName,
                                                  //نفسي
                                                  'psychologySpecialistId':
                                                      psychologySpecialistId,
                                                });
                                              }
                                              if (occupationalSpecialistId !=
                                                  null) {
                                                Users.doc(uid).update({
                                                  'occupationalSpecialistName':
                                                      occupationalSpecialistName,
                                                  //,ظيفي
                                                  'occupationalSpecialistId':
                                                      occupationalSpecialistId,
                                                });
                                              }
                                              if (physiotherapySpecialistId !=
                                                  null) {
                                                Users.doc(uid).update({
                                                  'physiotherapySpecialistName':
                                                      physiotherapySpecialistName,
                                                  //علاج طبيعي
                                                  'physiotherapySpecialistId':
                                                      physiotherapySpecialistId,
                                                });
                                              }

                                              if (communicationSpecialistId !=
                                                  null) {
                                                Users.doc(uid).update({
                                                  'communicationSpecialistName':
                                                      communicationSpecialistName,
                                                  //تخاطب
                                                  'communicationSpecialistId':
                                                      communicationSpecialistId,
                                                });
                                              }

                                              if (teacherId != null) {
                                                Admin_Teachers.get().then(
                                                    (value) => value.docs
                                                            .forEach((element) {Admin_Teachers.doc(element.id)
                                                              .collection('Students')
                                                              .doc(uid)
                                                              .delete()
                                                              .whenComplete(() {
                                                            Admin_Teachers.doc(
                                                                    teacherId)
                                                                .collection(
                                                                    'Students')
                                                                .doc(uid)
                                                                .set({
                                                              'uid': uid
                                                            });
                                                          });
                                                        }));

                                                Teachers.get().then((value) =>
                                                    value.docs
                                                        .forEach((element) {
                                                      Teachers.doc(element.id)
                                                          .collection(
                                                              'Students')
                                                          .doc(uid)
                                                          .delete()
                                                          .whenComplete(() {
                                                        Teachers.doc(teacherId)
                                                            .collection(
                                                                'Students')
                                                            .doc(uid)
                                                            .set({'uid': uid});
                                                      });
                                                    }));
                                              }

                                              if (psychologySpecialistId !=
                                                  null) {
                                                Admin_Specialists.where(
                                                        'typeOfSpechalist',
                                                        isEqualTo:
                                                            "أخصائي نفسي")
                                                    .get()
                                                    .then((value) => value.docs
                                                            .forEach((element) {
                                                          Admin_Specialists.doc(
                                                                  element.id)
                                                              .collection(
                                                                  'Students')
                                                              .doc(uid)
                                                              .delete()
                                                              .whenComplete(() {
                                                            Admin_Specialists.doc(
                                                                    psychologySpecialistId)
                                                                .collection(
                                                                    'Students')
                                                                .doc(uid)
                                                                .set({
                                                              'uid': uid
                                                            });
                                                          });
                                                        }));

                                                Specialists.where(
                                                        'typeOfSpechalist',
                                                        isEqualTo:
                                                            "أخصائي نفسي")
                                                    .get()
                                                    .then((value) => value.docs
                                                            .forEach((element) {
                                                          Specialists.doc(
                                                                  element.id)
                                                              .collection(
                                                                  'Students')
                                                              .doc(uid)
                                                              .delete()
                                                              .whenComplete(() {
                                                            Specialists.doc(
                                                                    psychologySpecialistId)
                                                                .collection(
                                                                    'Students')
                                                                .doc(uid)
                                                                .set({
                                                              'uid': uid
                                                            });
                                                          });
                                                        }));
                                              }

                                              if (communicationSpecialistId !=
                                                  null) {
                                                Admin_Specialists.where(
                                                        'typeOfSpechalist',
                                                        isEqualTo:
                                                            "أخصائي تخاطب")
                                                    .get()
                                                    .then((value) => value.docs
                                                            .forEach((element) {
                                                          Admin_Specialists.doc(
                                                                  element.id)
                                                              .collection(
                                                                  'Students')
                                                              .doc(uid)
                                                              .delete()
                                                              .whenComplete(() {
                                                            Admin_Specialists.doc(
                                                                    communicationSpecialistId)
                                                                .collection(
                                                                    'Students')
                                                                .doc(uid)
                                                                .set({
                                                              'uid': uid
                                                            });
                                                          });
                                                        }));

                                                Specialists.where(
                                                        'typeOfSpechalist',
                                                        isEqualTo:
                                                            "أخصائي تخاطب")
                                                    .get()
                                                    .then((value) => value.docs
                                                            .forEach((element) {
                                                          Specialists.doc(
                                                                  element.id)
                                                              .collection(
                                                                  'Students')
                                                              .doc(uid)
                                                              .delete()
                                                              .whenComplete(() {
                                                            Specialists.doc(
                                                                    communicationSpecialistId)
                                                                .collection(
                                                                    'Students')
                                                                .doc(uid)
                                                                .set({
                                                              'uid': uid
                                                            });
                                                          });
                                                        }));
                                              }

                                              if (occupationalSpecialistId !=
                                                  null) {
                                                Admin_Specialists.where(
                                                        'typeOfSpechalist',
                                                        isEqualTo:
                                                            "أخصائي علاج وظيفي")
                                                    .get()
                                                    .then((value) => value.docs
                                                            .forEach((element) {
                                                          Admin_Specialists.doc(
                                                                  element.id)
                                                              .collection(
                                                                  'Students')
                                                              .doc(uid)
                                                              .delete()
                                                              .whenComplete(() {
                                                            Admin_Specialists.doc(
                                                                    occupationalSpecialistId)
                                                                .collection(
                                                                    'Students')
                                                                .doc(uid)
                                                                .set({
                                                              'uid': uid
                                                            });
                                                          });
                                                        }));
                                                Specialists.where(
                                                        'typeOfSpechalist',
                                                        isEqualTo:
                                                            "أخصائي علاج وظيفي")
                                                    .get()
                                                    .then((value) => value.docs
                                                            .forEach((element) {
                                                          Specialists.doc(
                                                                  element.id)
                                                              .collection(
                                                                  'Students')
                                                              .doc(uid)
                                                              .delete()
                                                              .whenComplete(() {
                                                            Specialists.doc(
                                                                    occupationalSpecialistId)
                                                                .collection(
                                                                    'Students')
                                                                .doc(uid)
                                                                .set({
                                                              'uid': uid
                                                            });
                                                          });
                                                        }));
                                              }

                                              if (physiotherapySpecialistId !=
                                                  null) {
                                                Admin_Specialists.where(
                                                        'typeOfSpechalist',
                                                        isEqualTo:
                                                            "أخصائي علاج طبيعي")
                                                    .get()
                                                    .then((value) => value.docs
                                                            .forEach((element) {
                                                          Admin_Specialists.doc(
                                                                  element.id)
                                                              .collection(
                                                                  'Students')
                                                              .doc(uid)
                                                              .delete()
                                                              .whenComplete(() {
                                                            Admin_Specialists.doc(
                                                                    physiotherapySpecialistId)
                                                                .collection(
                                                                    'Students')
                                                                .doc(uid)
                                                                .set({
                                                              'uid': uid
                                                            });
                                                          });
                                                        }));

                                                Specialists.where(
                                                        'typeOfSpechalist',
                                                        isEqualTo:
                                                            "أخصائي علاج طبيعي")
                                                    .get()
                                                    .then((value) => value.docs
                                                            .forEach((element) {
                                                          Specialists.doc(
                                                                  element.id)
                                                              .collection(
                                                                  'Students')
                                                              .doc(uid)
                                                              .delete()
                                                              .whenComplete(() {
                                                            Specialists.doc(
                                                                    physiotherapySpecialistId)
                                                                .collection(
                                                                    'Students')
                                                                .doc(uid)
                                                                .set({
                                                              'uid': uid
                                                            });
                                                          });
                                                        }));
                                              }

                                              Specialists.get().then((value) =>
                                                  value.docs.forEach((element) {
                                                  Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                    'name':newName==null? name: newName,
                                                  });

                                                  if (gender != null) {
                                                    Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                      'gender': gender,
                                                    });
                                                  }
                                                  if (teacherId != null) {
                                                    Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                      'teacherId': teacherId,
                                                      'teacherName': teacherName,
                                                    });
                                                  }
                                                  if (psychologySpecialistId !=
                                                      null) {
                                                    Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                      'psychologySpecialistName':
                                                      psychologySpecialistName,
                                                      //نفسي
                                                      'psychologySpecialistId':
                                                      psychologySpecialistId,
                                                    });
                                                  }
                                                  if (occupationalSpecialistId !=
                                                      null) {
                                                    Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                      'occupationalSpecialistName':
                                                      occupationalSpecialistName,
                                                      //,ظيفي
                                                      'occupationalSpecialistId':
                                                      occupationalSpecialistId,
                                                    });
                                                  }
                                                  if (physiotherapySpecialistId !=
                                                      null) {
                                                    Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                      'physiotherapySpecialistName':
                                                      physiotherapySpecialistName,
                                                      //علاج طبيعي
                                                      'physiotherapySpecialistId':
                                                      physiotherapySpecialistId,
                                                    });
                                                  }

                                                  if (communicationSpecialistId !=
                                                      null) {
                                                    Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                      'communicationSpecialistName':
                                                      communicationSpecialistName,
                                                      //تخاطب
                                                      'communicationSpecialistId':
                                                      communicationSpecialistId,
                                                    });
                                                  }

                                                  })
                                              );

                                              Admin_Specialists.get().then((value) =>
                                                  value.docs.forEach((element) {
                                                    Admin_Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                      'name':newName==null? name: newName,
                                                    });

                                                    if (gender != null) {
                                                      Admin_Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                        'gender': gender,
                                                      });
                                                    }
                                                    if (teacherId != null) {
                                                      Admin_Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                        'teacherId': teacherId,
                                                        'teacherName': teacherName,
                                                      });
                                                    }
                                                    if (psychologySpecialistId != null) {
                                                      Admin_Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                        'psychologySpecialistName':
                                                        psychologySpecialistName,
                                                        //نفسي
                                                        'psychologySpecialistId':
                                                        psychologySpecialistId,
                                                      });
                                                    }
                                                    if (occupationalSpecialistId != null) {
                                                      Admin_Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                        'occupationalSpecialistName':
                                                        occupationalSpecialistName,
                                                        //,ظيفي
                                                        'occupationalSpecialistId':
                                                        occupationalSpecialistId,
                                                      });
                                                    }
                                                    if (physiotherapySpecialistId != null) {
                                                      Admin_Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                        'physiotherapySpecialistName':
                                                        physiotherapySpecialistName,
                                                        //علاج طبيعي
                                                        'physiotherapySpecialistId':
                                                        physiotherapySpecialistId,
                                                      });
                                                    }

                                                    if (communicationSpecialistId != null) {
                                                      Admin_Specialists.doc(element.id).collection('Students').doc(uid).update({
                                                        'communicationSpecialistName':
                                                        communicationSpecialistName,
                                                        //تخاطب
                                                        'communicationSpecialistId':
                                                        communicationSpecialistId,
                                                      });
                                                    }
                                                  })
                                              );
                                              Navigator.pop(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainAdminScreen(0)));
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
