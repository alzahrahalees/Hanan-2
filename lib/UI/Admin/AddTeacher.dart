import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hanan/services/addTeacher.dart';
import '../Constance.dart';
import 'package:hanan/services/auth.dart';

class AddTeacherScreen extends StatefulWidget {
  @override
  _AddTeacherScreenState createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {

  @override
  void initState() {
    super.initState();

  }

  final _formkey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;

  final AuthService _auth = AuthService();
  TextEditingController _name ;
  TextEditingController _age  ;
  TextEditingController _email;
  TextEditingController _phone;
  String specialistType;
  String _gender;
  DateTime _birthdate=DateTime.now();
  String name;
  String email;
  String age;
  String phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("إضافة معلم ", style: KTextAppBarStyle),
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
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'الاسم',
                            controller: _name,
                              onChanged: (value){
                                setState(() {
                                  name=value;
                                });
                              }
                          ),
                        ), //name
                        Padding(
                          padding: new EdgeInsets.all(5),
                          child: KNormalTextFormField(
                              hintText: 'العمر',
                              controller: _age,
                              validatorText: "#مطلوبة",
                              onChanged: (value){
                                setState(() {
                                  age=value;
                                });
                              }
                          ),
                        ),//age
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: "#مطلوبة",
                             hintText: "البريد الاكتروني",
                             controller: _email,
                            onChanged: (value){
                              setState(() {
                                email=value;
                              });
                            }
                          ),
                        ),//email
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: KNormalTextFormField(
                            validatorText: "#مطلوبة",
                             hintText: "الهاتف",
                             controller: _phone,
                              onChanged: (value){
                                setState(() {
                                  phone=value;
                                });
                              }
                             // "رقم الهاتف ", "* مطلوبة", _phone
                          ),
                        ),//phone num

                         Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Row(children: <Widget>[
                            Text("الجنس",
                                style:
                                    KTextPageStyle.copyWith(color: Colors.grey)),
                            new Padding(padding: new EdgeInsets.all(5)),
                            KCustomTwoRadioButton(),
                        ]),
                         ),
                        new Padding(padding: new EdgeInsets.all(10)),

                          new Padding(padding: new EdgeInsets.all(5)),
                          kDatePicker(_birthdate,"تاريخ الميلاد"),

                         Padding(padding: new EdgeInsets.all(5),
                          child: AddTeacher(
                            email: email,
                            type: "Teacher",
                            name: name,
                            age: age,
                            phone: phone,
                            birthday:_birthdate.toString() ,
                            gender: _gender,
                          ),
                         )
                      ]
                      ),
                    ]
                    )
                )
            )
        )
    );

  }

}
