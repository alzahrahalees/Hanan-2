import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../Constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateStudentInfo extends StatefulWidget {
  final String studentId;

  UpdateStudentInfo(this.studentId);

  @override
  _UpdateStudentInfoState createState() => _UpdateStudentInfoState();
}

class _UpdateStudentInfoState extends State<UpdateStudentInfo> {
  User user = FirebaseAuth.instance.currentUser;



//General capabilities
  String _attentionAndFocus;
  String _comprehensionAndUnderstanding;
  String _perception; //الإدراك
  String _memory; //التذكر
  //Personal skills
  String _moreActive;
  String _hurtsHimself;
  String _hurtsOthers;
  String _aLotOfSabotage; // كثير التخريب
  String _aLotOfShouting; //كثير الصراخ
  String _quicklyEmbracesOthers; //يتقبل الاخرين بسرعة
  String _hasTantrums; //نوبات الغضب

  //Self-reliance skills
  String _selfRelianceInEatingAndDrinking;
  String _bathIsRequired;
  String _changesClothes;
  String _wearsShoes;
  String _washesHands;
  String _brushingTeeth;

  //Communication skills
  String _verbalCommunication;
  String _eyeContact;
  String _socialMedia;
  String _languageDevelopment;
  String _expressiveAbility;
  String _independenceSkills;

  //The extent to which the disorder affects the child
  String _socialSide;
  String _motorSide; //الجانب الحركي
  String _personalCareAspect;
  String _cognitiveMentalAspect; //الجانب المعرفي العقلي

  //Evolutionary history of the condition

  String _durationOfPregnancy;
  String _motherHealthInPregnancy;
  String _birthProcess;
  String _placeOfBirth;
  String _disturbanceAtChildbirth;
  String _birthDisorder;

  String _babyBirthWeight;
  String _typeOfLactation;

  //Growth history
  String _startSitting;
  String _standUp;
  String _walking;
  String _teething;

  String _whoDiscoverCase;
  String _ageConditionAppears;
  String _symptomsChildBeginningDisorder;

  //the last
  String _latestCentersAndSchools;
  String _importantGoalsForParents;

  String _extraFamilyNotes;
  String _oldUser ;
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

    List<dynamic> _emotionalGrowth=[];


    var student = FirebaseFirestore.instance
        .collection('Students')
        .doc(widget.studentId)
        .collection('StudyCases');

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                //KAppBarTextInkwell("إلغاء", StudentInfo())
              ],
              title: Text("دراسة الحالة ", style: kTextAppBarStyle),
              centerTitle: true,
              backgroundColor: kAppBarColor,
            ),
            body: StreamBuilder<Object>(
                stream: student.doc(widget.studentId + 'info').snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    DocumentSnapshot _data = snapshot.data;
                    if (_data.exists) {
                      _emotionalGrowth= _data.data()['_emotionalGrowth']==null? [] : _data.data()['_emotionalGrowth'];
                      _oldUser= _data.data()['_editedBy']==null? 'لم يتم إضافة بيانات' : _data.data()['_editedBy'];
                      return Container(
                          padding: EdgeInsets.all(10),
                          color: kBackgroundPageColor,
                          alignment: Alignment.topCenter,
                          child: ListView(shrinkWrap: true, children: <Widget>[
                            new Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "تاريخ الحالة",
                                    style: kTextPageStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text("من أكتشف أعراض الحالة؟", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: DropdownButton(
                                          hint: Text(_data.data()['_whoDiscoverCase']==null?'اختر':_data.data()['_whoDiscoverCase']),
                                          // Not necessary for Option 1
                                          value: _whoDiscoverCase,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _whoDiscoverCase = newValue;
                                            });
                                          },
                                          items: ["المستشفى", "الأم", "المركز", "آخرين"]
                                              .map((location) {
                                            return DropdownMenuItem(
                                              child:  Text(location),
                                              value: location,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text("عمر ظهور العرض", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: DropdownButton(
                                          hint: Text(_data.data()['_ageConditionAppears']==null?'اختر':_data.data()['_ageConditionAppears']),
                                          // Not necessary for Option 1
                                          value: _ageConditionAppears,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _ageConditionAppears = newValue;
                                            });
                                          },
                                          items: [
                                            "قبل السنة الأولى",
                                            "بعد السنة الأولى"
                                          ]
                                              .map((location) {
                                            return DropdownMenuItem(
                                              child: new Text(location),
                                              value: location,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('ماهي الأعراض التي ظهرت على الطفل بداية ظهور الإضطراب؟'),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: KNormalTextFormFieldLines(
                                        hintText:
                                        _symptomsChildBeginningDisorder==null?'':_symptomsChildBeginningDisorder,
                                        onChanged: (value) {
                                          setState(() {
                                            _symptomsChildBeginningDisorder = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                //The extent to which the disorder affects the child


                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "مدى تأثير الإضطراب على الطفل",
                                    style: kTextPageStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text("إجتماعيا", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: DropdownButton(
                                          hint: Text(_data.data()['_socialSide']==null?'اختر':_data.data()['_socialSide']),
                                          // Not necessary for Option 1
                                          value: _socialSide,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _socialSide = newValue;
                                            });
                                          },
                                          items: [
                                            "غير متصل",
                                            "متصل في بعض الأحيان",
                                            "متصل بفاعلية"
                                          ]
                                              .map((location) {
                                            return DropdownMenuItem(
                                              child: new Text(location),
                                              value: location,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "معرفيا وعقليا",
                                    hint: _data.data()['_cognitiveMentalAspect']==null?'اختر':_data.data()['_cognitiveMentalAspect'],
                                    items: [
                                      "يفهم بسرعة ويتصرف بوعي",
                                      "يفهم ببطء ويتصرف أحيانا بوعي",
                                      "لا يفهم ولا يتصرف بوعي"
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _cognitiveMentalAspect = value;
                                      });
                                    },
                                    value: _cognitiveMentalAspect,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "العناية الشخصية",
                                    onChanged: (v) {
                                      setState(() {
                                        _personalCareAspect = v;
                                      });
                                    },
                                    value: _personalCareAspect,
                                    hint: _data.data()['_personalCareAspect']==null?'اختر':_data.data()['_personalCareAspect'],
                                    items: [
                                      "يعتني بنفسه دائما",
                                      "يعتني بنفسه أحيانا",
                                      "يساعده الآخرون دائما"
                                    ],
                                  ),
                                ),

                                Divider(
                                  color: Colors.black54,
                                ),

                                //###########
                                //Evolutionary history of the condition التاريخ التطوري للحالة
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "التاريخ التطوري للحالة",
                                    style: kTextPageStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "فترة الحمل",
                                    hint: _data.data()['_durationOfPregnancy']==null?'اختر':_data.data()['_durationOfPregnancy'],
                                    items: ["قبل تسعة أشهر", "طبيعي تسعة أشهر"],
                                    onChanged: (value) {
                                      setState(() {
                                        _durationOfPregnancy = value;
                                      });
                                    },
                                    value: _durationOfPregnancy,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "حالة الأم الصحية أثناء فترة الحمل",
                                    hint: _data.data()['_motherHealthInPregnancy']==null?'اختر': _data.data()['_motherHealthInPregnancy'],
                                    items: [
                                      "أمراض أخرى",
                                      "مشاكل حمل",
                                      "طبيعية"
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _motherHealthInPregnancy = value;
                                      });
                                    },
                                    value: _motherHealthInPregnancy,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "عملية الولادة",
                                    hint:_data.data()['_birthProcess']==null?'اختر':_data.data()['_birthProcess'],
                                    items: ["طبيعي", "قيصري"],
                                    onChanged: (value) {
                                      setState(() {
                                        _birthProcess = value;
                                      });
                                    },
                                    value: _birthProcess,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "أين تمت الولادة",
                                    hint: _data.data()['_placeOfBirth']==null?'اختر': _data.data()['_placeOfBirth'],
                                    items: ["الأخرى", "المستشفى", "المنزل"],
                                    onChanged: (value) {
                                      setState(() {
                                        _placeOfBirth = value;
                                      });
                                    },
                                    value: _placeOfBirth,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "هل حدث إضطراب أثناء الولادة",
                                    hint: _data.data()['_disturbanceAtChildbirth']==null?'اختر': _data.data()['_disturbanceAtChildbirth'],
                                    items: ["نعم", "لا"],
                                    onChanged: (value) {
                                      setState(() {
                                        _disturbanceAtChildbirth = value;
                                      });
                                    },
                                    value: _disturbanceAtChildbirth,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KNormalTextFormField(
                                    title:_birthDisorder==null? '':_birthDisorder ,
                                    hintText: "إذا كانت الإجابة نعم أذكريها",
                                    onChanged: (value) {
                                      _birthDisorder = value;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "وزن الطفل عند الولادة",
                                    hint: _data.data()['_babyBirthWeight']==null?'اختر':_data.data()['_babyBirthWeight'],
                                    items: [
                                      "أخرى",
                                      "أربعة إلى خمسة كيلو",
                                      "ثلاثة إلى أربعة كيلو",
                                      "إثنين إلى ثلاثة كيلو"
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _babyBirthWeight = value;
                                      });
                                    },
                                    value: _babyBirthWeight,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "نوع الرضاعة",
                                    hint:_data.data()['_typeOfLactation']==null?'اختر':_data.data()['_typeOfLactation'],
                                    items: [
                                      'طبيعية-صناعية',
                                      "صناعية",
                                      "طبيعية"
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _typeOfLactation = value;
                                      });
                                    },
                                    value: _typeOfLactation,
                                  ),
                                ),
                                //Growth history
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "متى بدأ بالجلوس",
                                    hint:_data.data()['_startSitting']==null?'اختر':_data.data()['_startSitting'],
                                    items: ['قبل سنة', "بعد سنة", "سنة"],
                                    onChanged: (value) {
                                      setState(() {
                                        _startSitting = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "الوقوف",
                                    hint:_data.data()['_standUp']==null?'اختر':_data.data()['_standUp'],
                                    items: ['قبل سنة', "بعد سنة", "سنة"],
                                    onChanged: (value) {
                                      setState(() {
                                        _standUp = value;
                                      });
                                    },
                                    value: _standUp,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "المشي",
                                    hint: _data.data()['_walking']==null?'اختر': _data.data()['_walking'],
                                    items: ['قبل سنة', "بعد سنة", "سنة"],
                                    onChanged: (value) {
                                      setState(() {
                                        _walking = value;
                                      });
                                    },
                                    value: _walking,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "التسنين",
                                    hint: _data.data()['_teething']==null?'اختر':_data.data()['_teething'],
                                    items: ['قبل سنة', "بعد سنة", "سنة"],
                                    onChanged: (value) {
                                      setState(() {
                                        _teething = value;
                                      });
                                    },
                                    value: _teething,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black54,
                                ),

                               // #######################
                               // Emotional growth
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: MultiSelectFormField(
                                      hintWidget: Center(
                                          child: Text(
                                              'اضغط لاختيار واحدة أو أكثر')),
                                      fillColor: kBackgroundPageColor,
                                      autovalidate: false,
                                      title: Text('النمو الإنفعالي'),
                                      validator: (value) {
                                        if (value == null ||
                                            value.length == 0) {
                                          return 'مطلوب';
                                        }
                                        return null;
                                      },
                                      dataSource: [
                                        {
                                          "display": "عدواني",
                                          "value": "عدواني",
                                        },
                                        {
                                          "display": "عنيد",
                                          "value": "عنيد",
                                        },
                                        {
                                          "display": "تخريب",
                                          "value": "تخريب",
                                        },
                                        {
                                          "display": "توتر",
                                          "value": "توتر",
                                        },
                                        {
                                          "display": "قلق",
                                          "value": "قلق",
                                        },
                                        {
                                          "display": "مخاوف",
                                          "value": "مخاوف",
                                        },
                                        {
                                          "display": "الإحباط",
                                          "value": "الإحباط",
                                        },
                                        {
                                          "display": "الهروب",
                                          "value": "الهروب",
                                        },
                                        {
                                          "display": "نشاط زائد",
                                          "value": "نشاط زائد",
                                        },
                                        {
                                          "display": "خمول",
                                          "value": "خمول",
                                        },
                                      ],
                                      textField: 'display',
                                      valueField: 'value',
                                      okButtonLabel: 'تم',
                                      cancelButtonLabel: 'إلغاء',
                                      // hintText: ' الرجاء تحديد خيار أو أكثر',
                                      initialValue: _emotionalGrowth,
                                      onSaved: (value) {
                                        if (value == null)
                                          setState(() {
                                            _emotionalGrowth = value;
                                          });
                                      },
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black54,
                                ),

                                //#############
                                //general Capalties
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "القدرات العامة",
                                    style: kTextPageStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "الإنتباه والتركيز",
                                    hint: _data.data()['_attentionAndFocus']==null?'اختر':_data.data()['_attentionAndFocus'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _attentionAndFocus = value;
                                      });
                                    },
                                    value: _attentionAndFocus,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "الإستيعاب والفهم",
                                    hint: _data.data()['_comprehensionAndUnderstanding']==null?'اختر': _data.data()['_comprehensionAndUnderstanding'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _comprehensionAndUnderstanding = value;
                                      });
                                    },
                                    value: _comprehensionAndUnderstanding,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "الإدراك",
                                    hint: _data.data()['_perception']==null?'اختر':_data.data()['_perception'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _perception = value;
                                      });
                                    },
                                    value: _perception,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "التذكر",
                                    hint: _data.data()['_memory']==null?'اختر':_data.data()['_memory'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _memory = value;
                                      });
                                    },
                                    value: _memory,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black54,
                                ),

                                //####################
                                //Personal skills
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "المهارت الشخصية",
                                    style: kTextPageStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "كثير النشاط والحركة",
                                    hint: _data.data()['_moreActive']==null?'اختر': _data.data()['_moreActive'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _moreActive = value;
                                      });
                                    },
                                    value: _moreActive,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يؤذي نفسه",
                                    hint: _data.data()['_hurtsHimself']==null?'اختر':_data.data()['_hurtsHimself'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _hurtsHimself = value;
                                      });
                                    },
                                    value: _hurtsHimself,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يؤذي الآخرين",
                                    hint: _data.data()['_hurtsOthers']==null?'اختر':_data.data()['_hurtsOthers'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _hurtsOthers = value;
                                      });
                                    },
                                    value: _hurtsOthers,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title:  "كثير التخريب",
                                    hint: _data.data()['_aLotOfSabotage'] ==null?'اختر':_data.data()['_aLotOfSabotage'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _aLotOfSabotage = value;
                                      });
                                    },
                                    value: _aLotOfSabotage,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "كثير الصراخ",
                                    hint: _data.data()['_aLotOfShouting']==null?'اختر':_data.data()['_aLotOfShouting'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _aLotOfShouting = value;
                                      });
                                    },
                                    value: _aLotOfShouting,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title:  "يتقبل الآخرين بسرعة",
                                    hint: _data.data()['_quicklyEmbracesOthers']==null?'اختر': _data.data()['_quicklyEmbracesOthers'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _quicklyEmbracesOthers = value;
                                      });
                                    },
                                    value: _quicklyEmbracesOthers,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "تنتابه نوبات غضب",
                                    hint: _data.data()['_hasTantrums']==null?'اختر': _data.data()['_hasTantrums'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _hasTantrums = value;
                                      });
                                    },
                                    value: _hasTantrums,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black54,
                                ),

                                //#################
                                // Self-reliance skills
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "مهارات الإعتماد عالذات",
                                    style: kTextPageStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "الإعنماد على الذات في الأكل والشرب",
                                    hint: _data.data()['_selfRelianceInEatingAndDrinking']==null?'اختر':_data.data()['_selfRelianceInEatingAndDrinking'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _selfRelianceInEatingAndDrinking =
                                            value;
                                      });
                                    },
                                    value: _selfRelianceInEatingAndDrinking,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يطلب دخول الحمام",
                                    hint: _data.data()['_bathIsRequired'] ==null?'اختر':_data.data()['_bathIsRequired'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _bathIsRequired = value;
                                      });
                                    },
                                    value: _bathIsRequired,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يغير ملابسه",
                                    hint: _data.data()['_changesClothes']==null?'اختر':_data.data()['_changesClothes'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _changesClothes = value;
                                      });
                                    },
                                    value: _changesClothes,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يلبس حذائه",
                                    hint: _data.data()['_wearsShoes']==null?'اختر':_data.data()['_wearsShoes'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _wearsShoes = value;
                                      });
                                    },
                                    value: _wearsShoes,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title:  "يغسل يديه",
                                    hint: _data.data()['_washesHands']==null?'اختر':_data.data()['_washesHands'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _washesHands = value;
                                      });
                                    },
                                    value: _washesHands,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يفرش أسنانه",
                                    hint: _data.data()['_brushingTeeth']==null?'اختر':_data.data()['_brushingTeeth'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _brushingTeeth = value;
                                      });
                                    },
                                    value: _brushingTeeth,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black54,
                                ),

                                //###################
                                // Communication skills
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "مهارات التواصل",
                                    style: kTextPageStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "التواصل اللفظي",
                                    hint: _data.data()['_verbalCommunication']==null?'اختر':_data.data()['_verbalCommunication'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _verbalCommunication = value;
                                      });
                                    },
                                    value: _verbalCommunication,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "التواصل البصري",
                                    hint: _data.data()['_eyeContact']==null?'اختر':_data.data()['_eyeContact'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _eyeContact = value;
                                      });
                                    },
                                    value: _eyeContact,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "التواصل الإجتماعي",
                                    hint: _data.data()['_socialMedia']==null?'اختر': _data.data()['_socialMedia'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _socialMedia = value;
                                      });
                                    },
                                    value: _socialMedia,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "النمو اللغوي",
                                    hint: _data.data()['_languageDevelopment']==null?'اختر':_data.data()['_languageDevelopment'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _languageDevelopment = value;
                                      });
                                    },
                                    value: _languageDevelopment,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "القدرة التعبيرية",
                                    hint: _data.data()['_expressiveAbility']==null?'اختر':_data.data()['_expressiveAbility'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _expressiveAbility = value;
                                      });
                                    },
                                    value: _expressiveAbility,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "المهارات اللإستقلالية",
                                    hint: _data.data()['_independenceSkills']==null?'اختر': _data.data()['_independenceSkills'],
                                    items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                                    onChanged: (value) {
                                      setState(() {
                                        _independenceSkills = value;
                                      });
                                    },
                                    value: _independenceSkills,
                                  ),
                                ),

                                //the last
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('ماهي المراكز أو المدارس التي التحق فيها الطفل قبل ذلك' ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: KNormalTextFormFieldLines(
                                        hintText: _latestCentersAndSchools==null? '':_latestCentersAndSchools,
                                        onChanged: (value) {
                                          _latestCentersAndSchools = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text( 'ماهي الأهداف التي تعبر بالنسبة للوالدين ذات أهمية والتي يريدون وضعها في البرنامج التربوي الفردي', ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: KNormalTextFormFieldLinesNoV(
                                        hintText:_importantGoalsForParents==null? '':_importantGoalsForParents,
                                        onChanged: (value) {
                                          _importantGoalsForParents = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text( 'ملاحظات الأسرة الإضافية', ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: KNormalTextFormFieldLinesNoV(
                                        hintText: _extraFamilyNotes==null? '':_extraFamilyNotes ,
                                        onChanged: (value) {
                                          _extraFamilyNotes = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: RaisedButton(
                                    color: kButtonColor,
                                    child:
                                        Text("تعديل", style: kTextButtonStyle),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0)),
                                    onPressed: () async {
                                      _currentUserName =
                                          await gitCurrentUserName();
                                      student
                                          .doc(widget.studentId + 'info')
                                          .set({
                                            '_attentionAndFocus':
                                                _attentionAndFocus==null? _data.data()['_attentionAndFocus']:_attentionAndFocus,
                                            '_comprehensionAndUnderstanding':
                                                _comprehensionAndUnderstanding==null? _data.data()['_comprehensionAndUnderstanding']:_comprehensionAndUnderstanding,
                                            '_perception': _perception==null? _data.data()['_perception']:_perception,
                                            '_memory': _memory==null? _data.data()['_memory']:_memory,
                                            //Personal skills
                                            '_moreActive': _moreActive==null? _data.data()['_moreActive']:_moreActive,
                                            '_hurtsHimself': _hurtsHimself==null? _data.data()['_hurtsHimself']:_hurtsHimself,
                                            '_hurtsOthers': _hurtsOthers==null? _data.data()['_hurtsOthers']:_hurtsOthers,
                                            '_aLotOfSabotage': _aLotOfSabotage==null? _data.data()['_aLotOfSabotage']:_aLotOfSabotage,
                                            '_aLotOfShouting': _aLotOfShouting==null? _data.data()['_aLotOfShouting']:_aLotOfShouting,
                                            '_quicklyEmbracesOthers':
                                                _quicklyEmbracesOthers==null? _data.data()['_quicklyEmbracesOthers']:_quicklyEmbracesOthers,
                                            '_hasTantrums': _hasTantrums==null? _data.data()['_hasTantrums']:_hasTantrums,
                                            //Self-reliance skills
                                            '_selfRelianceInEatingAndDrinking':
                                                _selfRelianceInEatingAndDrinking==null? _data.data()['_selfRelianceInEatingAndDrinking']:_selfRelianceInEatingAndDrinking,
                                            '_bathIsRequired': _bathIsRequired==null? _data.data()['_bathIsRequired']:_bathIsRequired,
                                            '_changesClothes': _changesClothes==null? _data.data()['_changesClothes']:_changesClothes,
                                            '_wearsShoes': _wearsShoes==null? _data.data()['_wearsShoes']:_wearsShoes,
                                            '_washesHands': _washesHands==null? _data.data()['_washesHands']:_washesHands,
                                            '_brushingTeeth': _brushingTeeth==null? _data.data()['_brushingTeeth']:_brushingTeeth,
                                            //Communication skills
                                            '_verbalCommunication':
                                                _verbalCommunication==null? _data.data()['_verbalCommunication']:_verbalCommunication,
                                            '_eyeContact': _eyeContact==null? _data.data()['_eyeContact']:_eyeContact,
                                            '_socialMedia': _socialMedia==null? _data.data()['_socialMedia']:_socialMedia,
                                            '_languageDevelopment':
                                                _languageDevelopment==null? _data.data()['_languageDevelopment']:_languageDevelopment,
                                            '_expressiveAbility':
                                                _expressiveAbility==null? _data.data()['_expressiveAbility']:_expressiveAbility,
                                            '_independenceSkills':
                                                _independenceSkills==null? _data.data()['_independenceSkills']:_independenceSkills,
                                            //The extent to which the disorder affects the child
                                            '_socialSide': _socialSide==null? _data.data()['_socialSide']:_socialSide,
                                            '_motorSide': _motorSide==null? _data.data()['_motorSide']:_motorSide,
                                            '_personalCareAspect':
                                                _personalCareAspect==null? _data.data()['_personalCareAspect']:_personalCareAspect,
                                            '_cognitiveMentalAspect':
                                                _cognitiveMentalAspect==null? _data.data()['_cognitiveMentalAspect']:_cognitiveMentalAspect,
                                            //Evolutionary history of the condition
                                            '_durationOfPregnancy':
                                                _durationOfPregnancy==null? _data.data()['_durationOfPregnancy']:_durationOfPregnancy,
                                            '_motherHealthInPregnancy':
                                                _motherHealthInPregnancy==null? _data.data()['_motherHealthInPregnancy']:_motherHealthInPregnancy,
                                            '_birthProcess': _birthProcess==null? _data.data()['_birthProcess']:_birthProcess,
                                            '_placeOfBirth': _placeOfBirth==null? _data.data()['_placeOfBirth']:_placeOfBirth,
                                            '_disturbanceAtChildbirth':
                                                _disturbanceAtChildbirth==null? _data.data()['_disturbanceAtChildbirth']:_disturbanceAtChildbirth,
                                            '_birthDisorder': _birthDisorder==null? _data.data()['_birthDisorder']:_birthDisorder,
                                            '_babyBirthWeight':
                                                _babyBirthWeight==null? _data.data()['_babyBirthWeight']:_babyBirthWeight,
                                            '_typeOfLactation':
                                                _typeOfLactation==null? _data.data()['_typeOfLactation']:_typeOfLactation,
                                            //Growth history
                                            '_startSitting': _startSitting==null? _data.data()['_startSitting']:_startSitting,
                                            '_standUp': _standUp==null? _data.data()['_standUp']:_standUp,
                                            '_walking': _walking==null? _data.data()['_walking']:_walking,
                                            '_teething': _teething==null? _data.data()['_teething']:_teething,
                                            '_whoDiscoverCase':
                                                _whoDiscoverCase==null? _data.data()['_whoDiscoverCase']:_whoDiscoverCase,
                                            '_ageConditionAppears':
                                                _ageConditionAppears==null? _data.data()['_ageConditionAppears']:_ageConditionAppears,
                                            '_symptomsChildBeginningDisorder':
                                                _symptomsChildBeginningDisorder==null? _data.data()['_symptomsChildBeginningDisorder']:_symptomsChildBeginningDisorder,
                                            //the last
                                            '_latestCentersAndSchools':
                                                _latestCentersAndSchools==null? _data.data()['_latestCentersAndSchools']:_latestCentersAndSchools,
                                            '_importantGoalsForParents':
                                                _importantGoalsForParents==null? _data.data()['_importantGoalsForParents']:_importantGoalsForParents,
                                            '_extraFamilyNotes':
                                            _extraFamilyNotes==null? _data.data()['_extraFamilyNotes']:_extraFamilyNotes,
                                            '_editedBy': _currentUserName,
                                            '_emotionalGrowth': _emotionalGrowth
                                          })
                                          .whenComplete(
                                              () => Navigator.pop(context))
                                          .catchError((err) => print(err));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text('اخر تعديل تم بواسطة : $_oldUser',
                                      style: TextStyle(fontSize: 14, color: Colors.black54),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ]));
                    } else {
                      return Text('');
                    }
                  } else
                    return Text('');
                })
        )
    );
  }
}

class KDropDownList extends StatelessWidget {
  final String value;
  final List items;
  final Function onChanged;
  final String hint;
  final String title;

  const KDropDownList({this.value, this.items, this.onChanged, this.hint,this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title==null?'': title, style: kTextPageStyle.copyWith(color: Colors.grey)),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: DropdownButton(
            hint: Text(hint),
            // Not necessary for Option 1
            value: value,
            onChanged: onChanged,
            items: items.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
