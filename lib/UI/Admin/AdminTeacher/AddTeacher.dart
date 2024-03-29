import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Teacher.dart';
import '../../Constance.dart';



class AddTeacherScreen extends StatefulWidget {
  @override
  _AddTeacherScreenState createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  @override
  void initState() {
    super.initState();
  }
  User userAdmin =  FirebaseAuth.instance.currentUser;
  CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
  final _formkey = GlobalKey<FormState>();

  bool _isEmailExists =false;
  String _name;
  String _age;
  String _email='';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kUnselectedItemColor),
          title: Text("إضافة معلم ", style: kTextAppBarStyle),
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
                                  kTextPageStyle.copyWith(color: Colors.grey)),
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
                          child: _isEmailExists? RaisedButton(
                            onPressed: (){},
                              color: Colors.black38,
                              child: Text("إضافة", style: kTextButtonStyle),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                                )
                              :AddTeacher(
                            formkey: _formkey,
                              name: _name,
                              age: _age,
                              email: _email.toLowerCase(),
                              phone: _phone,
                              gender: _gender,
                              type: "Teachers",
                              birthday: _Birthdate),
                        )

            ])])  )))   );
  }
}

