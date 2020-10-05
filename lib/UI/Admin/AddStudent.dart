import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constance.dart';
import '../Student.dart';
import 'AdminMainScreen.dart';
import 'package:hanan/services/auth.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;

  final AuthService _auth = AuthService();
  String _name;
  String _age;
  String _email;
  String _phone;
  DateTime _Birthdate = DateTime.now();
  String _gender;
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
    );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            KAppBarTextInkwell(text: "إلغاء", page: MainAdminScreen(0))
          ],
          title: Text("إضافة طالب", style: KTextAppBarStyle),
          centerTitle: true,
          backgroundColor: KAppBarColor,
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10),
                color: KBackgroundPageColor,
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
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
                        ), //email
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
                                style: KTextPageStyle.copyWith(
                                    color: Colors.grey)),
                            new Padding(padding: new EdgeInsets.all(5)),
                            Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            RadioButton(list[0], 0),
                                            new Padding(padding: new EdgeInsets.all(10)),
                                            RadioButton(list[1], 1),
                                          ],
                                        ),
                                      ),

                                    ]))]),
                        ),
                        new Padding(padding: new EdgeInsets.all(10)),

                        new Padding(padding: new EdgeInsets.all(5)),
                        new Row(children: <Widget>[
                          Text("تاريخ الميلاد",
                              style:
                              KTextPageStyle.copyWith(color: Colors.grey)),
                          new Padding(padding: new EdgeInsets.all(5)),
                          SizedBox(
                            height: 30,
                            width: 250,
                            child: CupertinoDatePicker(
                              initialDateTime: _Birthdate,
                              maximumDate: DateTime.now(),
                              use24hFormat: false ,
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (dateTime) {
                                setState(() {
                                  _Birthdate = dateTime;
                                });
                              },
                            ),
                          )
                        ]),
                        new Padding(
                          padding: new EdgeInsets.all(15),
                          child: AddStudent(
                              name: _name,
                              age: _age,
                              email: _email,
                              phone: _phone,
                              gender: _gender,
                              type: "Student",
                              birthday: _Birthdate),
                        )

                      ])])  )))   );

   /* key: _formkey,
                  // here we add the snapshot from database
                  child: ListView(shrinkWrap: true, children: <Widget>[
                  new Column(children: <Widget>[
                  Padding(
                  padding: const EdgeInsets.all(5),
                  child: KNormalTextFormField(
                    validatorText: '#مطلوب',
                    hintText: 'الاسم',
                    controller: _name,
                  ),
                ), //name
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: KNormalTextFormField(
                        validatorText: '#مطلوب',
                        hintText: 'الجنسية',
                        controller: _nationality,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: KNormalTextFormField(
                        validatorText: '#مطلوب',
                        hintText: 'رقم الهوية',
                        controller:_idNumber,
                      ),
                    ),
                    Padding(
                  padding: new EdgeInsets.all(5),
                  child: KNormalTextFormField(
                    hintText: 'العمر الزمني',
                    controller: _age,
                    validatorText: "#مطلوبة",
                  ),
                ), //age
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: KNormalTextFormField(
                    validatorText: "#مطلوبة",
                    hintText: "البريد الاكتروني",
                    controller: _email,
                  ),
                ), //email
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: KNormalTextFormField(
                    validatorText: "#مطلوبة",
                    hintText: "الهاتف",
                    controller: _phone,
                  ),
                ), //phone num
                ]),
                    Row(children: <Widget>[
                      Text("الجنس",
                          style:KTextPageStyle.copyWith(color: Colors.grey)),
                      Padding(padding:  EdgeInsets.all(5)),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                          RadioButton(genderRadioButtons [0], 0),
                          Padding(padding:  EdgeInsets.all(10)),
                            RadioButton(genderRadioButtons [1], 1),
                          ],
                        ),
                      )
                    ]
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: KNormalTextFormField(
                        validatorText: "#مطلوبة",
                        hintText: "مكان الإقامة",
                        controller: _live,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: KNormalTextFormField(
                        validatorText: "#مطلوبة",
                        hintText: "الحي",
                        controller: _district,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    kDatePicker(_dateOfBirth,"تاريخ الميلاد"),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: RaisedButton(
                        color: KButtonColor,
                        child: Text("إضافة", style: KTextButtonStyle),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            Navigator.pop(context);
              }
            },
          ),
        ),
        ]),)
    )
    )
    ,
    );
*/
  }
}
