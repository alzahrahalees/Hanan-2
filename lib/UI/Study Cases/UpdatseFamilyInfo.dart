import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateFamilyInfo extends StatefulWidget {
  final String studentId;

  UpdateFamilyInfo(this.studentId);

  @override
  _UpdateFamilyInfoState createState() => _UpdateFamilyInfoState();
}

class _UpdateFamilyInfoState extends State<UpdateFamilyInfo> {
  User user = FirebaseAuth.instance.currentUser;


  String _motherName;

  String _motherNationality;
  String _motherAgeInBorn;

  String _motherJob;

  String _motherWorkPhone;
  String _motherPhone;

  String _motherNumMarried;

  String _motherNumChildren;
  int _motherBirthYear;
  int _motherBirthMonth;
  int _motherBirthDay;
  String _motherEducation;
  String _motherSocialStatus;

  //father
  String _fatherName;
  String _fatherNationality;
  String _fatherAgeInBorn;
  String _fatherJob;
  String _fatherWorkPhone;
  String _fatherPhone;
  String _fatherNumMarried;
  String _fatherNumChildren;
  int _fatherBirthYear;
  int _fatherBirthMonth;
  int _fatherBirthDay;
  String _fatherEducation;
  String _fatherSocialStatus;

  //Understand the family for the Student Case
  String _motherUnderstandCase;
  String _motherCaseCare;
  String _fatherUnderstandCase;

  String _sisAndBroUnderstandCase;
  String _parentKinship;
  String _parentRelationship;
  String _numOfPplLiveHome;

  //The housing situation of the family
  String _kindOFBulid;
  String _housingCondition;

  //The economic situation of the family
  String _familyIncomeSources;
  String _yearLevelIncome;

  String _oldUserName;

  String _currentUserName = '';

  String onTab(location, changedValue) {
    changedValue = location;

    return changedValue;
  }

  Future<String> gitCurrentUserName() async {
    String name;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email)
        .get()
        .then((doc) {
      name = doc.data()['name'];
    });
    return name;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference student = FirebaseFirestore.instance
        .collection('Students')
        .doc(widget.studentId)
        .collection('StudyCases');

    return Scaffold(
      appBar: AppBar(
        title: Text("دراسة حالة العائلة", style: kTextAppBarStyle),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      body: Container(
        color: kBackgroundPageColor,
        child: StreamBuilder<DocumentSnapshot>(
          stream: student.doc(widget.studentId + 'family').snapshots(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot _data = snapshot.data;
              if (_data.exists) {

                _fatherBirthYear = _data.data()['_fatherBirthYear'];
                _fatherBirthMonth = _data.data()['_fatherBirthMonth'];
                _fatherBirthDay = _data.data()['_fatherBirthDay'];
                _oldUserName = _data.data()['_editedBy']==null? 'لا يوجد بيانات': _data.data()['_editedBy'] ;


                return ListView(children: [
                  Column(children: <Widget>[
                    // //###### mother info #######
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "معلومات الأم",
                        style: kTextPageStyle,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_motherName']==null? 'اختر': _data.data()['_motherName'],
                        hintText: 'اسم الأم',
                        onChanged: (value) {
                          _motherName = value;
                        },
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.all(15),
                        child:
                        Row(children: <Widget>[
                          Text("تاريخ الميلاد", style: kTextPageStyle.copyWith(color: Colors.grey)),
                          new Padding(padding: new EdgeInsets.all(10)),
                          SizedBox(
                            height: 30,
                            width: 250,
                            child: CupertinoDatePicker(
                              initialDateTime: DateTime(
                                  _motherBirthYear==null? DateTime.now().year:_motherBirthYear
                                  ,_motherBirthMonth ==null? DateTime.now().month:_motherBirthMonth
                                  ,_motherBirthDay==null? DateTime.now().day:_motherBirthDay
                              ),
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (dateTime) {
                                setState(() {
                                  _motherBirthYear = dateTime.year;
                                  _motherBirthMonth= dateTime.month;
                                  _motherBirthDay= dateTime.day;
                                });
                              },
                            ),
                          )
                        ])
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: false,
                        title: _data.data()['_motherAgeInBorn']==null? 'اختر': _data.data()['_motherAgeInBorn'],
                        hintText: 'العمر عند الولادة',
                        onChanged: (value) {
                          _motherAgeInBorn = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: false,
                        title: _data.data()['_motherNationality']==null? 'اختر': _data.data()['_motherNationality'],
                        hintText: 'الجنسية',
                        onChanged: (value) {
                          _motherNationality = value;
                        },
                      ),
                    ),
                    //


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: false,
                        title: _data.data()['_motherNumMarried']==null? 'اختر': _data.data()['_motherNumMarried'],
                        hintText: 'عدد مرات الزواج',
                        onChanged: (value) {
                          _motherNumMarried = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: false,
                        title: _data.data()['_motherNumChildren']==null? 'اختر': _data.data()['_motherNumChildren'],
                        hintText: 'عدد الأبناء',
                        onChanged: (value) {
                          _motherNumChildren = value;
                        },
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: false,
                        title: _data.data()['_motherJob']==null? 'اختر': _data.data()['_motherJob'],
                        hintText: 'الوظيفة',
                        onChanged: (value) {
                          _motherJob = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_motherPhone']==null? 'اختر': _data.data()['_motherPhone'],
                        hintText: 'الجوال',
                        onChanged: (value) {
                          _motherPhone = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_motherWorkPhone']==null? 'اختر': _data.data()['_motherWorkPhone'],
                        hintText: 'هاتف العمل',
                        onChanged: (value) {
                          _motherWorkPhone = value;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text("الحالة الإجتماعية للأم", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(10)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton <String>(
                                hint:  Text(  _data.data()['_motherSocialStatus']==null? 'اختر': _data.data()['_motherSocialStatus'] ) ,
                                value: _motherSocialStatus,
                                // // Not necessary for Option 1
                                onChanged: (newValue) {
                                  setState(() {
                                    _motherSocialStatus = newValue;
                                    print(_motherSocialStatus);
                                  });
                                },
                                items: ["أرملة", "متزوجة", "مطلقة"].map((location) {
                                  return DropdownMenuItem(
                                    value:  location,
                                    child:  Text(location),
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text(" المستوى العلمي للأم", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                // Not necessary for Option 1
                                hint: Text (_data.data()[_motherEducation]==null? 'اختر': _data.data()[_motherEducation]) ,
                                // Not necessary for Option 1
                                value: _motherEducation,
                                onChanged: (newValue) {
                                  setState(() {
                                    _motherEducation = newValue;
                                  });
                                },
                                items:  ["عالي", "ثانوي", "متوسط", "إبتدائي", "أمي"].map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),
                    Divider(
                      color: Colors.black54,
                    ),
                    //
                    // #####################################################
                    // //#####  father info #######
                    //
                    Padding(
                      padding: const EdgeInsets.only(top: 25,bottom: 10),
                      child: Text(
                        "معلومات الأب",
                        style: kTextPageStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherName']==null? 'اختر': _data.data()['_fatherSocialStatus'],
                        validatorText: '#مطلوب',
                        hintText: "اسم الأب",
                        onChanged: (value) {
                          _fatherName = value;
                        },
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.all(10),
                        child:
                        Row(children: <Widget>[
                          Text("تاريخ الميلاد", style: kTextPageStyle.copyWith(color: Colors.grey)),
                          new Padding(padding: new EdgeInsets.all(10)),
                          SizedBox(
                            height: 30,
                            width: 250,
                            child: CupertinoDatePicker(
                              initialDateTime: DateTime(_fatherBirthYear,_fatherBirthMonth,_fatherBirthDay),
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (dateTime) {
                                setState(() {
                                  _fatherBirthYear = dateTime.year;
                                  _fatherBirthMonth= dateTime.month;
                                  _fatherBirthDay= dateTime.day;
                                });
                              },
                            ),
                          )
                        ])
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherAgeInBorn']==null? 'اختر': _data.data()['_fatherAgeInBorn'],
                        hintText: 'العمر عند الولاد',
                        onChanged: (value) {
                          _fatherAgeInBorn = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherNationality']==null? 'اختر': _data.data()['_fatherNationality'],
                        hintText: 'الجنسية',
                        onChanged: (value) {
                          _fatherNationality = value;
                        },
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherNumMarried']==null? 'اختر': _data.data()['_fatherNumMarried'],
                        hintText: 'عدد مرات الزواج',
                        onChanged: (value) {
                          _fatherNumMarried = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherNumChildren']==null? 'اختر': _data.data()['_fatherNumChildren'],
                        hintText: 'عدد الأبناء',
                        onChanged: (value) {
                          _fatherNumChildren = value;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherJob']==null? 'اختر': _data.data()['_fatherJob'],
                        hintText: 'الوظيفة',
                        onChanged: (value) {
                          _fatherJob = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherPhone']==null? 'اختر': _data.data()['_fatherPhone'],
                        hintText: 'الجوال',
                        onChanged: (value) {
                          _fatherPhone = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherWorkPhone']==null? 'اختر': _data.data()['_fatherWorkPhone'],
                        hintText: 'هاتف العمل',
                        onChanged: (value) {
                          _fatherWorkPhone = value;
                        },
                      ),
                    ),

                    Row(children: <Widget>[
                      Text("الحالة الإجتماعية للأب", style: kTextPageStyle.copyWith(color: Colors.grey)),
                      new Padding(padding: new EdgeInsets.all(7)),
                      Expanded(
                          child: SizedBox(
                            height: 40,
                            width: 200,
                            child: DropdownButton(
                              // Not necessary for Option 1
                              hint:  Text(_data.data()['_fatherSocialStatus']==null? 'اختر': _data.data()['_fatherSocialStatus']) ,
                              // Not necessary for Option 1
                              value: _fatherSocialStatus,
                              onChanged: (newValue) {
                                setState(() {
                                  _fatherSocialStatus = newValue;
                                });
                              },
                              items:  ["أرمل", "متزوج", "مطلق"].map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ))
                    ]),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text( "المستوى العلمي للأب", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton <String>(
                                hint:  Text(  _data.data()['_fatherEducation'] ==null? 'اختر': _data.data()['_fatherEducation']) ,
                                value: _fatherEducation,
                                // // Not necessary for Option 1
                                onChanged: (newValue) {
                                  setState(() {
                                    _fatherEducation = newValue;
                                    print(_fatherEducation);
                                  });
                                },
                                items:  ["عالي", "ثانوي", "متوسط", "إبتدائي", "أمي"].map((location) {
                                  return DropdownMenuItem(
                                    value:  location,
                                    child:  Text(location),

                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),
                    Divider(color: Colors.black54,),


                    // // ####### Family care with case ##########

                    Padding(
                      padding: const EdgeInsets.only(top: 25,bottom: 10),
                      child: Text("تعامل أفراد الأسرة مع الحالة" , style: kTextPageStyle,),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text("تفهم الأم للحالة", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                // Not necessary for Option 1
                                hint:  Text(_data.data()['_motherUnderstandCase']==null? 'اختر': _data.data()['_motherUnderstandCase']) ,
                                // Not necessary for Option 1
                                value: _motherUnderstandCase,
                                onChanged: (newValue) {
                                  setState(() {
                                    _motherUnderstandCase = newValue;
                                  });
                                },
                                items: [
                                  "غير مهتة ولا تعي بالحالة",
                                  "لديها معلومات غير كافية عن الحالة",
                                  "واعية ومتفهمة للحالة"
                                ].map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text("رعاية الأم الحالة", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                // Not necessary for Option 1
                                hint: Text(  _data.data()['_motherCaseCare']==null? 'اختر': _data.data()['_motherCaseCare']) ,
                                // Not necessary for Option 1
                                value: _motherCaseCare,
                                onChanged: (newValue) {
                                  setState(() {
                                    _motherCaseCare = newValue;
                                  });
                                },
                                items: [
                                  "تلقي بالمسؤولية على الآخرين",
                                  "تشاركها خادمة أو آخرين",
                                  "تعتني بها بنفسها في المنزل"
                                ].map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text("تفهم الأب للحالة", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                // Not necessary for Option 1
                                hint: Text(_data.data()['_fatherUnderstandCase']==null? 'اختر': _data.data()['_fatherUnderstandCase']) ,
                                // Not necessary for Option 1
                                value: _fatherUnderstandCase,
                                onChanged: (newValue) {
                                  setState(() {
                                    _fatherUnderstandCase = newValue;
                                  });
                                },
                                items: [
                                  "غير مهتم ولا يعي بالحالة",
                                  "لديه معلومات غير كافية عن الحالة",
                                  "واعي ومتفهم للحالة"
                                ].map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text("تفهم الأخوة للحالة", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                hint:  Text( _data.data()['_sisAndBroUnderstandCase']==null? 'اختر': _data.data()['_sisAndBroUnderstandCase']),
                                // Not necessary for Option 1
                                value:_sisAndBroUnderstandCase,
                                onChanged: (newValue) {
                                  setState(() {
                                    _sisAndBroUnderstandCase = newValue;
                                  });
                                },
                                items:[
                                  "غير مهتمين ولا مدركين بالحالة",
                                  "لديهم معلومات غير كافية عن الحالة",
                                  "واعيين ومتفهمين للحالة"
                                ].map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text("صلة قرابة الوالدين", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                // Not necessary for Option 1
                                hint: Text( _data.data()['_parentKinship']==null? 'اختر': _data.data()['_parentKinship']),
                                value: _parentKinship,
                                onChanged: (newValue) {
                                  setState(() {
                                    _parentKinship = newValue;
                                  });
                                },
                                items: ["يوجد قرابة", "لا يوجد قرابة"].map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text( "طبيعة علاقة الوالدين", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                // Not necessary for Option 1
                                hint: Text(  _data.data()['_parentRelationship']==null? 'اختر': _data.data()['_parentRelationship']) ,
                                // Not necessary for Option 1
                                value: _parentRelationship,
                                onChanged: (newValue) {
                                  setState(() {
                                    _parentRelationship = newValue;
                                  });
                                },
                                items: [
                                  "الزوجين منفصلين",
                                  "اضطرابات في العلاقة",
                                  "وجود بعض الخلافات",
                                  "علاقة جيدة"
                                ].map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_numOfPplLiveHome']==null? 'اختر': _data.data()['_numOfPplLiveHome'],
                        hintText:
                            "عدد الأفراد الذين يسكنون مع الحالة في المنزل",
                        onChanged: (value) {
                          _numOfPplLiveHome = value;
                        },
                      ),
                    ),




                    //#########################################
                    // Family living situation

                    Padding(
                      padding: const EdgeInsets.only(top: 25,bottom: 10),
                      child: Text(
                        "الوضع السكني والاقتصادي للأسرة",
                        style: kTextPageStyle,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text("نوع السكن", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                // Not necessary for Option 1
                                hint:  Text( _data.data()['_kindOFBulid']==null? 'اختر': _data.data()['_kindOFBulid']) ,
                                // Not necessary for Option 1
                                value: _kindOFBulid,
                                onChanged: (newValue) {
                                  setState(() {
                                    _kindOFBulid = newValue;
                                  });
                                },
                                items:  ["فيلا", "شقة"].map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text("حالة السكن", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                // Not necessary for Option 1
                                hint:  Text( _data.data()['_housingCondition']==null? 'اختر': _data.data()['_housingCondition']) ,
                                // Not necessary for Option 1
                                value: _housingCondition,
                                onChanged: (newValue) {
                                  setState(() {
                                    _housingCondition = newValue;
                                  });
                                },
                                items:  ["إيجار", "ملك"].map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text("مصادر دخل الأسرة", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                // Not necessary for Option 1
                                hint: Text(  _data.data()['_familyIncomeSources']==null? 'اختر': _data.data()['_familyIncomeSources']) ,
                                // Not necessary for Option 1
                                value: _familyIncomeSources,
                                onChanged: (newValue) {
                                  setState(() {
                                    _familyIncomeSources = newValue;
                                  });
                                },
                                items: ["أعمال حرة", "عمل", "عقارات"].map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: <Widget>[
                        Text("مستوى الدخل السنوي", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(7)),
                        Expanded(
                            child: SizedBox(
                              height: 40,
                              width: 200,
                              child: DropdownButton(
                                hint:  Text(_data.data()['_yearLevelIncome']==null? 'اختر': _data.data()['_yearLevelIncome']) ,
                                // Not necessary for Option 1
                                value: _yearLevelIncome,
                                onChanged: (value) {
                                  setState(() {
                                    _yearLevelIncome = value;
                                  });
                                },
                                items:["ممتاز", "متوسط", "جيد", "ضعيف"].map((location) {
                                  return DropdownMenuItem(
                                    child: Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ))
                      ]),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: RaisedButton(
                        color: kButtonColor,
                        child: Text("تعديل", style: kTextButtonStyle),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        onPressed: () async {
                          _currentUserName = await gitCurrentUserName();
                          student.doc(widget.studentId + 'family').update({
                            '_motherName': _motherName == null
                                ? _data.data()['_motherName']
                                : _motherName,
                            '_motherNationality': _motherNationality == null
                                ?_data.data()['_motherNationality']
                                : _motherNationality,
                            '_motherAgeInBorn': _motherAgeInBorn == null
                                ? _data.data()['_motherAgeInBorn']
                                : _motherAgeInBorn,
                            '_motherJob': _motherJob == null
                                ?_data.data()['_motherJob']
                                : _motherJob,
                            '_motherWorkPhone': _motherWorkPhone == null
                                ?_data.data()['_motherWorkPhone']
                                : _motherWorkPhone,
                            '_motherPhone': _motherPhone == null
                                ? _data.data()['_motherPhone']
                                : _motherPhone,
                            '_motherNumMarried': _motherNumMarried == null
                                ? _data.data()['_motherNumMarried']
                                : _motherNumMarried,
                            '_motherNumChildren': _motherNumChildren == null
                                ? _data.data()['_motherNumChildren']
                                : _motherNumChildren,

                            '_motherBirthYear': _motherBirthYear,
                            '_motherBirthMonth': _motherBirthMonth,
                            '_motherBirthDay': _motherBirthDay,

                            '_motherEducation': _motherEducation == null
                                ? _data.data()['_motherEducation']
                                : _motherEducation,
                            '_motherSocialStatus': _motherSocialStatus == null
                                ? _data.data()['_motherSocialStatus']
                                : _motherSocialStatus,
                            '_fatherName': _fatherName == null
                                ? _data.data()['_fatherName']
                                : _fatherName,
                            '_fatherNationality': _fatherNationality == null
                                ? _data.data()['_fatherNationality']
                                : _fatherNationality,
                            '_fatherAgeInBorn': _fatherAgeInBorn == null
                                ? _data.data()['_fatherAgeInBorn']
                                : _fatherAgeInBorn,
                            '_fatherJob': _fatherJob == null
                                ? _data.data()['_fatherJob']
                                : _fatherJob,
                            '_fatherWorkPhone': _fatherWorkPhone == null
                                ? _data.data()['_fatherWorkPhone']
                                : _fatherWorkPhone,
                            '_fatherPhone': _fatherPhone == null
                                ? _data.data()['_fatherPhone']
                                : _fatherPhone,
                            '_fatherNumMarried': _fatherNumMarried == null
                                ? _data.data()['_fatherNumMarried']
                                : _fatherNumMarried,
                            '_fatherNumChildren': _fatherNumChildren == null
                                ? _data.data()['_fatherNumMarried']
                                : _fatherNumChildren,

                            '_fatherBirthYear': _fatherBirthYear,
                            '_fatherBirthMonth': _fatherBirthMonth,
                            '_fatherBirthDay': _fatherBirthDay,

                            '_fatherEducation': _fatherEducation == null
                                ? _data.data()['_fatherEducation']
                                : _fatherEducation,
                            '_fatherSocialStatus': _fatherSocialStatus == null
                                ? _data.data()['_fatherSocialStatus']
                                : _fatherSocialStatus,
                            '_motherUnderstandCase':
                            _motherUnderstandCase == null
                                ? _data.data()['_motherUnderstandCase']
                                : _motherUnderstandCase,
                            '_motherCaseCare': _motherCaseCare == null
                                ? _data.data()['_motherCaseCare']
                                : _motherCaseCare,
                            '_fatherUnderstandCase':
                            _fatherUnderstandCase == null
                                ? _data.data()['_fatherUnderstandCase']
                                : _fatherUnderstandCase,
                            '_sisAndBroUnderstandCase':
                            _sisAndBroUnderstandCase == null
                                ? _data.data()['_sisAndBroUnderstandCase']
                                : _sisAndBroUnderstandCase,
                            '_parentKinship': _parentKinship == null
                                ? _data.data()['_parentKinship']
                                : _parentKinship,
                            '_parentRelationship': _parentRelationship == null
                                ? _data.data()['_parentRelationship']
                                : _parentRelationship,
                            '_numOfPplLiveHome': _numOfPplLiveHome == null
                                ? _data.data()['_numOfPplLiveHome']
                                : _numOfPplLiveHome,
                            '_kindOFBulid': _kindOFBulid == null
                                ? _data.data()['_kindOFBulid']
                                : _kindOFBulid,
                            '_housingCondition': _housingCondition == null
                                ? _data.data()['_housingCondition']
                                : _housingCondition,
                            '_familyIncomeSources': _familyIncomeSources == null
                                ? _data.data()['_familyIncomeSources']
                                : _familyIncomeSources,
                            '_yearLevelIncome': _yearLevelIncome == null
                                ?_data.data()['_yearLevelIncome']
                                : _yearLevelIncome,
                            '_editedBy': _currentUserName,
                          }).catchError((err)=> print(err));
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text('اخر تعديل تم بواسطة : $_oldUserName',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
            ),
                    )
                  ]
                  ),
                ]);
              }
               else
                return Text('');
            } else
              return Text('');
          },
        ),
      ),
    );
  }
}
