import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Constance.dart';
import 'package:flutter/cupertino.dart';

class FamilyInfo extends StatefulWidget {
  final String studentId;

  FamilyInfo(this.studentId);

  @override
  _FamilyInfoState createState() => _FamilyInfoState();
}

class _FamilyInfoState extends State<FamilyInfo> {
  User user = FirebaseAuth.instance.currentUser;

  DateTime _interviewDate = DateTime.now();

  String _motherName = '';
  String _motherNationality = '';
  String _motherAgeInBorn = '';
  String _motherJob = '';
  String _motherWorkPhone = '';
  String _motherPhone = '';
  String _motherNumMarried = '';
  String _motherNumChildren = '';
  int _motherBirthYear ;
  int _motherBirthMonth ;
  int _motherBirthDay ;
  String _motherEducation;
  String _motherSocialStatus;

  //father
  String _fatherName = '';
  String _fatherNationality = '';
  String _fatherAgeInBorn = '';
  String _fatherJob = '';
  String _fatherWorkPhone = '';
  String _fatherPhone = '';
  String _fatherNumMarried = '';
  String _fatherNumChildren = '';
  int _fatherBirthYear ;
  int _fatherBirthMonth ;
  int _fatherBirthDay ;
  String _fatherEducation;
  String _fatherSocialStatus;

  //Understand the family for the Student Case
  String _motherUnderstandCase;
  String _motherCaseCare;
  String _fatherUnderstandCase;

  String _sisAndBroUnderstandCase;
  String _parentKinship;
  String _parentRelationship;
  String _numOfPplLiveHome = '';

  //The housing situation of the family
  String _kindOFBulid;
  String _housingCondition;

  //The economic situation of the family
  String _familyIncomeSources;
  String _yearLevelIncome;

  String _currentUserName = '';

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
    var student = FirebaseFirestore.instance
        .collection('Students')
        .doc(widget.studentId)
        .collection('StudyCases');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("دراسة حالة العائلة", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body: Container(
            color: kBackgroundPageColor,
            child: Container(
              color: kBackgroundPageColor,
              child: ListView(
                children: [
                  Column(children: <Widget>[
                    //###### mother info #######

                    //
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
                        hintText: 'اسم الأم',
                        onChanged: (value) {
                          _motherName = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 10),
                      child:
                      //kDatePicker(_motherBirthDate, "تاريخ الميلاد"),
                        Row(children: <Widget>[
                          Text("تاريخ الميلاد", style: kTextPageStyle.copyWith(color: Colors.grey)),
                          new Padding(padding: new EdgeInsets.all(5)),
                          SizedBox(
                            height: 30,
                            width: 250,
                            child: CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              maximumDate: DateTime.now(),
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (dateTime) {
                                setState(() {
                                  _motherBirthYear = dateTime.year;
                                  _motherBirthMonth = dateTime.month;
                                  _motherBirthDay = dateTime.day;
                                });
                              },
                            ),
                          )
                        ])
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'العمر عند الولادة',
                        onChanged: (value) {
                          _motherAgeInBorn = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'الجنسية',
                        onChanged: (value) {
                          _motherNationality = value;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'عدد مرات الزواج',
                        onChanged: (value) {
                          _motherNumMarried = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'عدد الأبناء',
                        onChanged: (value) {
                          _motherNumChildren = value;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'الوظيفة',
                        onChanged: (value) {
                          _motherJob = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'الجوال',
                        onChanged: (value) {
                          _motherPhone = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'هاتف العمل',
                        onChanged: (value) {
                          _motherWorkPhone = value;
                        },
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("المستوى العلمي للأم"),
                          // Not necessary for Option 1
                          value: _motherEducation,
                          onChanged: (newValue) {
                            setState(() {
                              _motherEducation = newValue;
                            });
                          },
                          items: ["عالي", "ثانوي", "متوسط", "إبتدائي", "أمي"]
                              .map((location) {
                            return DropdownMenuItem(
                              child: Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("الحالة الإجتماعية للأم"),
                          // Not necessary for Option 1
                          value: _motherSocialStatus,
                          onChanged: (newValue) {
                            setState(() {
                              _motherSocialStatus = newValue;
                            });
                          },
                          items: ["أرملة", "متزوجة", "مطلقة"]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),


                    //#####  father info #######

                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        "معلومات الأب",
                        style: kTextPageStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        validatorText: '#مطلوب',
                        hintText: "اسم الأب",
                        onChanged: (value) {
                          _fatherName = value;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 5),
                      child:
                        Row(children: <Widget>[
                          Text("تاريخ الميلاد", style: kTextPageStyle.copyWith(color: Colors.grey)),
                          new Padding(padding: new EdgeInsets.all(5)),
                          SizedBox(
                            height: 30,
                            width: 250,
                            child: CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              maximumDate: DateTime.now(),
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (dateTime) {
                                setState(() {
                                  _fatherBirthYear = dateTime.year;
                                  _fatherBirthMonth = dateTime.month;
                                  _fatherBirthDay = dateTime.day;
                                });
                              },
                            ),
                          )
                        ])
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'العمر عند الولادة',
                        onChanged: (value) {
                          _fatherAgeInBorn = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'الجنسية',
                        onChanged: (value) {
                          _fatherNationality = value;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'عدد مرات الزواج',
                        onChanged: (value) {
                          _fatherNumMarried = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'عدد الأبناء',
                        onChanged: (value) {
                          _fatherNumChildren = value;
                        },
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'الوظيفة',
                        onChanged: (value) {
                          _fatherJob = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'الجوال',
                        onChanged: (value) {
                          _fatherPhone = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText: 'هاتف العمل',
                        onChanged: (value) {
                          _fatherWorkPhone = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("الحالة الإجتماعية للأب"),
                          // Not necessary for Option 1
                          value: _fatherSocialStatus,
                          onChanged: (newValue) {
                            setState(() {
                              _fatherSocialStatus = newValue;
                            });
                          },
                          items: ["أرمل", "متزوج", "مطلق"]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text( "المستوى العلمي للأب"),
                          // Not necessary for Option 1
                          value: _fatherEducation,
                          onChanged: (newValue) {
                            setState(() {
                              _fatherEducation = newValue;
                            });
                          },
                          items:  ["عالي", "ثانوي", "متوسط", "إبتدائي", "أمي"]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),



                    // ####### Family care with case ##########

                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text("تعامل أفراد الأسرة مع الحالة"),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("تفهم الأم للحالة"),
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
                          ]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("رعاية الأم للحالة"),
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
                          ]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("تفهم الأب للحالة"),
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
                          ]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("تفهم الأخوة للحالة"),
                          // Not necessary for Option 1
                          value: _sisAndBroUnderstandCase,
                          onChanged: (newValue) {
                            setState(() {
                              _sisAndBroUnderstandCase = newValue;
                            });
                          },
                          items: [
                            "غير مهتمين ولا مدركين بالحالة",
                            "لديهم معلومات غير كافية عن الحالة",
                            "واعيين ومتفهمين للحالة"
                          ]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("صلة قرابة الوالدين"),
                          // Not necessary for Option 1
                          value: _parentKinship,
                          onChanged: (newValue) {
                            setState(() {
                              _parentKinship = newValue;
                            });
                          },
                          items: ["يوجد قرابة", "لا يوجد قرابة"]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("طبيعة علاقة الوالدين"),
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
                          ]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        hintText:
                            "عدد الأفراد الذين يسكنون مع الحالة في المنزل",
                        onChanged: (value) {
                          _numOfPplLiveHome = value;
                        },
                      ),
                    ),

                    // ##### family situation

                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text("الوضع السكني والاقتصادي للأسرة"),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("نوع السكن"),
                          // Not necessary for Option 1
                          value: _kindOFBulid,
                          onChanged: (newValue) {
                            setState(() {
                              _kindOFBulid = newValue;
                            });
                          },
                          items: ["فيلا", "شقة"]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("حالة السكن"),
                          // Not necessary for Option 1
                          value: _housingCondition,
                          onChanged: (newValue) {
                            setState(() {
                              _housingCondition = newValue;
                            });
                          },
                          items: ["إيجار", "ملك"]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("مصادر دخل الأسرة"),
                          // Not necessary for Option 1
                          value: _familyIncomeSources,
                          onChanged: (newValue) {
                            setState(() {
                              _familyIncomeSources = newValue;
                            });
                          },
                          items: ["أعمال حرة", "عمل", "عقارات"]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        alignment: Alignment(1, 0),
                        child: DropdownButton(
                          hint: Text("مستوى الدخل السنوي"),
                          // Not necessary for Option 1
                          value: _yearLevelIncome,
                          onChanged: (newValue) {
                            setState(() {
                              _yearLevelIncome = newValue;
                            });
                          },
                          items: ["ممتاز", "متوسط", "جيد", "ضعيف"]
                              .map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: RaisedButton(
                        color: kButtonColor,
                        child: Text("إضافة", style: kTextButtonStyle),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        onPressed: () async {
                          _currentUserName = await gitCurrentUserName();
                          student
                              .doc(widget.studentId + 'family')
                              .set({
                                '_motherName': _motherName,
                                '_motherNationality': _motherNationality,
                                '_motherAgeInBorn': _motherAgeInBorn,
                                '_motherJob': _motherJob,
                                '_motherWorkPhone': _motherWorkPhone,
                                '_motherPhone': _motherPhone,
                                '_motherNumMarried': _motherNumMarried,
                                '_motherNumChildren': _motherNumChildren,
                                '_motherBirthYear': _motherBirthYear,
                                '_motherBirthMonth': _motherBirthMonth,
                                '_motherBirthDay' : _motherBirthDay,
                                '_motherEducation': _motherEducation,
                                '_motherSocialStatus': _motherSocialStatus,
                                '_fatherName': _fatherName,
                                '_fatherNationality': _fatherNationality,
                                '_fatherAgeInBorn': _fatherAgeInBorn,
                                '_fatherJob': _fatherJob,
                                '_fatherWorkPhone': _fatherWorkPhone,
                                '_fatherPhone': _fatherPhone,
                                '_fatherNumMarried': _fatherNumMarried,
                                '_fatherNumChildren': _fatherNumChildren,
                                '_fatherBirthYear': _fatherBirthYear,
                                '_fatherBirthMonth': _fatherBirthMonth,
                                '_fatherBirthDay':_fatherBirthDay,
                                '_fatherEducation': _fatherEducation,
                                '_fatherSocialStatus': _fatherSocialStatus,
                                '_motherUnderstandCase': _motherUnderstandCase,
                                '_motherCaseCare': _motherCaseCare,
                                '_fatherUnderstandCase': _fatherUnderstandCase,
                                '_sisAndBroUnderstandCase':
                                    _sisAndBroUnderstandCase,
                                '_parentKinship': _parentKinship,
                                '_parentRelationship': _parentRelationship,
                                '_numOfPplLiveHome': _numOfPplLiveHome,
                                '_kindOFBulid': _kindOFBulid,
                                '_housingCondition': _housingCondition,
                                '_familyIncomeSources': _familyIncomeSources,
                                '_yearLevelIncome': _yearLevelIncome,
                                '_editedBy': _currentUserName,
                              })
                              .whenComplete(() => Navigator.pop(context))
                              .catchError((err) => print(err));
                        },
                      ),
                    ),
                  ])
                ],
              ),
            )),
      ),
    );
  }
}
