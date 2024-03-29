import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Specialist.dart';
import '../../Constance.dart';
import '../AdminMainScreen.dart';

class AddSpecialistScreen extends StatefulWidget {
  @override
  _AddSpecialistScreenState createState() => _AddSpecialistScreenState();
}

class _AddSpecialistScreenState extends State<AddSpecialistScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;

  bool _isEmailExists =false;
  String _name;
  String _age;
  String _email='';
  String _phone;
  String _typeOfSpechalist;
  List<String> items=["أخصائي علاج طبيعي","أخصائي علاج وظيفي","أخصائي نفسي","أخصائي تخاطب"];
  DateTime _Birthdate = DateTime.now();
  String _gender;
  List<String> list =["أنثى","ذكر"];
  int selectedIndex;
  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });}

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
    );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kUnselectedItemColor),
          title: Text("إضافة أخصائي", style: kTextAppBarStyle),
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
                        ),

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
                    padding: new EdgeInsets.all(10)),
                Row(children: <Widget>[
                  new Padding(padding: new EdgeInsets.all(5)),
                  Text("التخصص", style: kTextPageStyle.copyWith(color: Colors.grey)),
                  new Padding(padding: new EdgeInsets.all(7)),
                  Expanded(
                      child: SizedBox(
                        height: 40,
                        width: 200,
                        child: DropdownButton(
                          hint: Text('اختر'),
                          // Not necessary for Option 1
                          value: _typeOfSpechalist,
                          onChanged: (newValue) {
                            setState(() {
                              _typeOfSpechalist = newValue;
                            });
                          },
                          items: items.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ))
                ]),
                        new Padding(
                          padding:  EdgeInsets.all(15),
                          child:_isEmailExists? RaisedButton(
                            onPressed: (){},
                            color: Colors.black38,
                            child: Text("إضافة", style: kTextButtonStyle),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                          )
                              : AddSpecialist(
                            formkey: _formkey,
                              name: _name,
                              age: _age,
                              email: _email.toLowerCase(),
                              phone: _phone,
                              gender: _gender,
                              type: "Specialists",
                              typeOfSpechalist: _typeOfSpechalist,
                              birthday: _Birthdate),
                        )

                      ])])  )))   );

  }
}
