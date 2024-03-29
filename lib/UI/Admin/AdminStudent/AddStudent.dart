import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constance.dart';
import 'Student.dart';


class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
@override
  void initState() {
    super.initState();
  }
List <String> l;


  final _formkey = GlobalKey<FormState>();

  //Map<String,dynamic> s;
  bool _isEmailExists =false;
  List<String>s;
  String _name;
  String _age;
  String _email='';
  String _phone;
  DateTime _Birthdate = DateTime.now();
  String _gender;
  String _teacherName;
  String _teacherId;
  String _psychologySpecialistName;//نفسي
  String _psychologySpecialistId;
  String _communicationSpecialistName;//تخاطب
  String _communicationSpecialistId;
  String _occupationalSpecialistName; //,ظيفي
  String _occupationalSpecialistId;
  String _physiotherapySpecialistName;//علاج طبيعي
  String _physiotherapySpecialistId;
  List<String> list = ["أنثى", "ذكر"];
  int selectedIndex;

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });

  }

  Future<bool> isEmailExists (String email) async{

    bool isExits;
    await FirebaseFirestore.instance.collection('Users').doc(email).get()
        .then((value){
      if(value.exists){
        isExits=true;
      }
      else isExits=false;
    });
    return isExits;
  }

  Widget RadioButton(String txt, int index) {
    return OutlineButton(
      onPressed: () {
        changeIndex(index);
        selectedIndex == 0 ? _gender = list[0] : _gender = list[1];
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

  @override
  Widget build(BuildContext context) {
    User userAdmin = FirebaseAuth.instance.currentUser;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kUnselectedItemColor),
          title: Text("إضافة طالب", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10),
                color: kBackgroundPageColor,
                alignment: Alignment.topCenter,
                child: Form(
                    key: _formkey,
                    // here we add the snapshot from database
                    child: ListView(shrinkWrap: true, children: <Widget>[
                      new Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'الاسم',
                            onChanged: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                          ),
                        ), //name
                        Padding(
                          padding: new EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            hintText: 'العمر',
                            onChanged: (value) {
                              setState(() {
                                _age = value;
                              });
                            },
                            validatorText: "#مطلوبة",
                          ),
                        ), //age
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: "#مطلوبة",
                            hintText: "البريد الاكتروني",
                            onChanged: (value) async {
                              _isEmailExists = await isEmailExists(value);
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
                        ), //email

                        _isEmailExists?Text('هذا الايميل مستعمل الرجاء اختيار ايميل اخر', style: TextStyle(
                            color: Colors.red, fontSize: 12 ),)
                            : SizedBox(),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: KNormalTextFormField(
                            validatorText: "#مطلوبة",
                            hintText: "الهاتف",
                            onChanged: (value) {
                              setState(() {
                                _phone = value;
                              });
                            },
                          ),
                        ), //phone num
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(children: <Widget>[
                            Text("الجنس",
                                style: kTextPageStyle.copyWith(
                                    color: Colors.grey)),
                            new Padding(padding: new EdgeInsets.all(5)),
                            Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: <Widget>[
                                            RadioButton(list[0], 0),
                                            new Padding(
                                                padding: new EdgeInsets.all(
                                                    10)),
                                            RadioButton(list[1], 1),
                                          ],
                                        ),
                                      ),

                                    ]))
                          ]),
                        ),
                        new Padding(padding: new EdgeInsets.all(10)),

                        new Padding(padding: new EdgeInsets.all(5)),
                        new Row(children: <Widget>[
                          Text("تاريخ الميلاد",
                              style:
                              kTextPageStyle.copyWith(color: Colors.grey)),
                          new Padding(padding: new EdgeInsets.all(5)),
                          SizedBox(
                            height: 30,
                            width: 250,
                            child: CupertinoDatePicker(
                              initialDateTime: _Birthdate,
                              maximumDate: DateTime.now(),
                              use24hFormat: false,
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (dateTime) {
                                setState(() {
                                  _Birthdate = dateTime;
                                });
                              },
                            ),
                          )
                        ]),
                        Row(
                          children: [
                            Text("المعلم المسؤول",
                                style: kTextPageStyle.copyWith(color: Colors
                                    .black38)),
                            new Padding(
                                padding: new EdgeInsets.all(30),
                              child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('Teachers').
                                    where('center',isEqualTo: userAdmin.email).snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData){
                                        Center(
                                          child: const CupertinoActivityIndicator(),
                                        );
                                      return DropdownButton<String>(
                                        value: _teacherName,
                                        isDense: true,
                                        hint: Text('إختر'),
                                        onChanged: (newValue) {
                                          setState(() {
                                            _teacherName = newValue;
                                          });
                                          print(_teacherName);
                                        },
                                        items: snapshot.data.docs
                                            .map((DocumentSnapshot document) {
                                          return new DropdownMenuItem<String>(
                                              value: document.data()["name"],
                                              onTap: () {
                                                _teacherId= document.data()["uid"];
                                              },
                                              child: new Container(
                                                height: 30,
                                                //color: primaryColor,
                                                child: new Text(
                                                  document.data()["name"]
                                                      .toString(),
                                                ),
                                              ));
                                        }).toList()
                                      );
                                  }
                              else{
                                return Text('');
                                      }
                                    }),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("الأخصائي النفسي",
                                style: kTextPageStyle.copyWith(color: Colors
                                    .black38)),
                            new Padding(
                              padding: new EdgeInsets.all(30),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection('Specialists').where('typeOfSpechalist',isEqualTo:"أخصائي نفسي" ).where('center',isEqualTo: userAdmin.email).snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData){
                                    Center(
                                      child: const CupertinoActivityIndicator(),
                                    );
                                    return DropdownButton<String>(
                                      value: _psychologySpecialistName,
                                      isDense: true,
                                      hint: Text('إختر'),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _psychologySpecialistName= newValue;
                                        });
                                        print(_psychologySpecialistName);
                                      },
                                      items:snapshot.data.docs
                                          .map((DocumentSnapshot document) {

                                        return new DropdownMenuItem<String>(
                                            value:  document
                                                .data()["name"],
                                            onTap: () {_psychologySpecialistId = document
                                                  .data()["uid"];
                                              print(_physiotherapySpecialistId);
                                            },
                                            child:
                                            new Container(
                                              height: 23,
                                              //color: primaryColor,
                                              child: new Text( document.data()["name"])
                                            )
                                        )
                                        ;}
                                      ).toList()
                                    );
                                  }
                                  else{
                                    return Text("");
                                    }
                                  }),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("الأخصائي الوظيفي",
                                style: kTextPageStyle.copyWith(color: Colors
                                    .black38)),
                            new Padding(
                              padding: new EdgeInsets.all(30),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection('Specialists').where('typeOfSpechalist',isEqualTo:"أخصائي علاج وظيفي" ).where('center',isEqualTo: userAdmin.email).snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      Center(
                                         child: const CupertinoActivityIndicator(),
                                      );
                                      return DropdownButton<String>(
                                          value: _occupationalSpecialistName,
                                          isDense: true,
                                          hint: Text('إختر'),
                                          onChanged: (newValue) {
                                            setState(() {
                                            _occupationalSpecialistName = newValue;
                                          });
                                          print(_occupationalSpecialistName);
                                          },
                                          items: snapshot.data.docs.map((DocumentSnapshot document) {
                                                return new DropdownMenuItem<String>(
                                                    value: document.data()["name"],
                                                    onTap: () {
                                                      _occupationalSpecialistId = document.data()["uid"];
                                                      print(_occupationalSpecialistId);
                                                      },
                                                    child: new Container(
                                                      height: 25,
                                                      //color: primaryColor,
                                                      child:
                                                      new Text(
                                                        document.data()["name"],
                                                      ),
                                                    ));
                                              }).toList()
                                      );
                                    }
                                    else{
                                    return Text('');
                                    }}),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(" العلاج الطبيعي",
                                style: kTextPageStyle.copyWith(color: Colors
                                    .black38)),
                            new Padding(
                              padding: new EdgeInsets.all(30),
                              child: StreamBuilder(
                                  stream:FirebaseFirestore.instance.collection('Specialists').where('typeOfSpechalist',isEqualTo:"أخصائي علاج طبيعي" ).where('center',isEqualTo: userAdmin.email).snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                   if (snapshot.hasData) {
                                     Center(
                                       child: const CupertinoActivityIndicator(),
                                     );
                                     return DropdownButton<String>(
                                         value: _physiotherapySpecialistName,
                                         isDense: true,
                                         hint: Text('إختر'),
                                         onChanged: (newValue) {
                                           setState(() {
                                             _physiotherapySpecialistName =
                                                 newValue;
                                           });
                                           print(_physiotherapySpecialistName);
                                         },
                                         items: snapshot.data.docs
                                             .map((DocumentSnapshot document) {
                                           return new DropdownMenuItem<String>(
                                               value: document
                                                   .data()["name"],
                                               onTap: () {
                                                 _physiotherapySpecialistId =
                                                 document.data()["uid"];
                                                 print(
                                                     _physiotherapySpecialistId);
                                               },
                                               child: new Container(
                                                 height: 25,
                                                 //color: primaryColor,
                                                 child:
                                                 new Text(
                                                   document.data()["name"],
                                                 ),
                                               ));
                                         }).toList()
                                     );
                                   }
                                  else{
                                    return Text('');
                                   }
                                  }),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("أخصائي التخاطب",
                                style: kTextPageStyle.copyWith(color: Colors
                                    .black38)),
                            new Padding(
                              padding: new EdgeInsets.all(30),
                              child: StreamBuilder(
                                  stream:
                                  FirebaseFirestore.instance.collection('Specialists').where('typeOfSpechalist',isEqualTo:"أخصائي تخاطب" ).where('center',isEqualTo: userAdmin.email).snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                     if (snapshot.hasData) {
                                       Center(
                                         child: const CupertinoActivityIndicator(),
                                       );
                                       return DropdownButton<String>(
                                           value: _communicationSpecialistName,
                                           isDense: true,
                                           hint: Text('إختر'),
                                           onChanged: (newValue) {
                                             setState(() {
                                               _communicationSpecialistName =
                                                   newValue;
                                             });
                                             print(
                                                 _communicationSpecialistName);
                                           },
                                           items: snapshot.data.docs
                                               .map((
                                               DocumentSnapshot document) {
                                             return new DropdownMenuItem<String>(
                                                 value: document
                                                     .data()["name"],
                                                 onTap: () {
                                                   _communicationSpecialistId =
                                                   document
                                                       .data()["uid"];
                                                   print(
                                                       _communicationSpecialistId);
                                                 },
                                                 child: new Container(
                                                   height: 25,
                                                   //color: primaryColor,
                                                   child:
                                                   new Text(
                                                     document.data()["name"],
                                                   ),
                                                 ));
                                           }).toList()
                                       );
                                     }
                                  else return Text('');
                                  }),
                            ),
                          ],
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(15),
                          child:_isEmailExists? RaisedButton(
                            onPressed: (){},
                            color: Colors.black38,
                            child: Text("إضافة", style: kTextButtonStyle),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                          )
                              : AddStudent(
                            formKey: _formkey,
                              name: _name,
                              age: _age,
                              email: _email.toLowerCase(),
                              phone: _phone,
                              gender: _gender,
                              type: "Students",
                              teacherName: _teacherName,
                              teacherId: _teacherId,
                              psychologySpecialistName: _psychologySpecialistName,
                              psychologySpecialistId: _psychologySpecialistId,
                              communicationSpecialistName: _communicationSpecialistName,
                              communicationSpecialistId: _communicationSpecialistId,
                              occupationalSpecialistName: _occupationalSpecialistName,
                              occupationalSpecialistId: _occupationalSpecialistId,
                              physiotherapySpecialistName: _physiotherapySpecialistName,
                              physiotherapySpecialistId: _physiotherapySpecialistId,
                              birthday: _Birthdate)
                        )
                      ])
                    ])))));

  }
}
