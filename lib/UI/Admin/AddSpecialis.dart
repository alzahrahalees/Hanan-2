import 'package:flutter/material.dart';
import '../Constance.dart';
import 'AdminTeacherScreen.dart';
import 'AdminMainScreen.dart';

class AddSpecialistScreen extends StatefulWidget {
  @override
  _AddSpecialistScreenState createState() => _AddSpecialistScreenState();
}

class _AddSpecialistScreenState extends State<AddSpecialistScreen> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _name ;
  TextEditingController _age  ;
  TextEditingController _email;
  TextEditingController _phone;
  String dropdownValue = 'اخصائي علاج وظيفي';
  String _gender;
  DateTime _BirthDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[KAppBarTextInkwell(text:"إلغاء",page: MainAdminScreen(1))],
          title: Text("إضافة اخصائي ", style: KTextAppBarStyle),
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
                          ),
                        ), //name
                        Padding(
                          padding: new EdgeInsets.all(5),
                          child: KNormalTextFormField(
                              hintText: 'العمر',
                              controller: _age,
                              validatorText: "#مطلوبة",
                          ),
                        ),//age
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: "#مطلوبة",
                             hintText: "البريد الاكتروني",
                             controller: _email,
                          ),
                        ),//email
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: KNormalTextFormField(
                            validatorText: "#مطلوبة",
                             hintText: "الهاتف",
                             controller: _phone,
                          ),
                        ),//phone num
                 ]),
                        new Row(children: <Widget>[
                          Text("الجنس",
                              style:
                                  KTextPageStyle.copyWith(color: Colors.grey)),
                          new Padding(padding: new EdgeInsets.all(5)),
                          KCustomTwoRadioButton(),
                        ]),
                        new Padding(padding: new EdgeInsets.all(10)),

                          kDatePicker(_BirthDate,"تاريخ الميلاد"),

                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: RaisedButton(
                            color: KButtonColor,
                            child: Text("إضافة", style: KTextButtonStyle),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            onPressed: () {
                              if (_formkey.currentState.validate()) {
                               Navigator.pop(context,_name);
                              }
                            },
                          ),
                        ),
                      ]),
                    )
            )
    )
    );
  }
}
