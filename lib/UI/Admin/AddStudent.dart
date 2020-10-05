import 'package:flutter/material.dart';
import '../Constance.dart';
import 'package:flutter/cupertino.dart';


class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _name;
  TextEditingController _age;
  TextEditingController _district;
  TextEditingController _email;
  TextEditingController _phone;
  TextEditingController _live;
  TextEditingController _nationality;
  TextEditingController _idNumber;
  String _gender;
  DateTime _dateOfBirth = DateTime.now();


  List<String> genderRadioButtons = ["ذكر", "أنثى"];
  int selectedIndex = 0;

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget radioButton(String txt, int index) {
    return OutlineButton(
      onPressed: () {
        changeIndex(index);
        selectedIndex == 0 ? _gender = "male" : _gender = "female";
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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[//KAppBarTextInkwell("إلغاء", MainAdminScreen(2)),
              ],
              title: Text("إضافة طالب ", style: KTextAppBarStyle),
              centerTitle: true,
              backgroundColor: KAppBarColor,
            ),
            body: Container(
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
                          radioButton(genderRadioButtons [0], 0),
                          Padding(padding:  EdgeInsets.all(10)),
                            radioButton(genderRadioButtons [1], 1),
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
  }
}
