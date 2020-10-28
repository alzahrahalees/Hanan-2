import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParentFamilyStudy extends StatefulWidget {

  @override
  _ParentFamilyStudyState createState() => _ParentFamilyStudyState();
}

class _ParentFamilyStudyState extends State<ParentFamilyStudy> {

  User user = FirebaseAuth.instance.currentUser;

  int _motherBirthYear;
  int _motherBirthMonth;
  int _motherBirthDay;
  String _motherEducation;

  int _fatherBirthYear;
  int _fatherBirthMonth;
  int _fatherBirthDay;


  String _oldUserName;


  String onTab(location, changedValue) {
    changedValue = location;

    return changedValue;
  }



  @override
  Widget build(BuildContext context) {
    CollectionReference student = FirebaseFirestore.instance
        .collection('Students')
        .doc(user.email)
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
          stream: student.doc(user.email + 'family').snapshots(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot _data = snapshot.data;
              if (_data.exists) {
               _motherBirthYear = _data.data()['_motherBirthYear'];
                _motherBirthMonth = _data.data()['_motherBirthMonth'];
                _motherBirthDay = _data.data()['_motherBirthDay'];
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
                        readOnly: true,
                        title: _data.data()['_motherName']==null? 'لم يتم إدخال بيانات': _data.data()['_motherName'],
                        hintText: 'اسم الأم',
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.all(15),
                        child:
                        Row(children: <Widget>[
                          Text("تاريخ الميلاد: ", style: kTextPageStyle.copyWith(color: Colors.grey)),
                          Text('$_motherBirthYear / $_motherBirthMonth /  $_motherBirthDay'),
                        ])
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: true,
                        title: _data.data()['_motherAgeInBorn']==null? 'لم يتم إدخال بيانات': _data.data()['_motherAgeInBorn'],
                        hintText: 'العمر عند الولادة',

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: true,
                        title: _data.data()['_motherNationality']==null? 'لم يتم إدخال بيانات': _data.data()['_motherNationality'],
                        hintText: 'الجنسية',

                      ),
                    ),
                    //


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: true,
                        title: _data.data()['_motherNumMarried']==null? 'لم يتم إدخال بيانات': _data.data()['_motherNumMarried'],
                        hintText: 'عدد مرات الزواج',

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: true,
                        title: _data.data()['_motherNumChildren']==null? 'لم يتم إدخال بيانات': _data.data()['_motherNumChildren'],
                        hintText: 'عدد الأبناء',

                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: true,
                        title: _data.data()['_motherJob']==null? 'لم يتم إدخال بيانات': _data.data()['_motherJob'],
                        hintText: 'الوظيفة',

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: true,
                        title: _data.data()['_motherPhone']==null? 'لم يتم إدخال بيانات': _data.data()['_motherPhone'],
                        hintText: 'الجوال',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: true,
                        title: _data.data()['_motherWorkPhone']==null? 'لم يتم إدخال بيانات': _data.data()['_motherWorkPhone'],
                        hintText: 'هاتف العمل',

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
                                // // Not necessary for Option 1
                                onChanged: (newValue) {},
                                items: []
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
                                onChanged: (newValue) {},
                                items:  []
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
                        "معلومات الأب:  ",
                        style: kTextPageStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: true,
                        title: _data.data()['_fatherName']==null? 'لم يتم إدخال بيانات': _data.data()['_fatherName'],
                        hintText: "اسم الأب",

                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.all(10),
                        child:
                        Row(children: <Widget>[
                          Text("تاريخ الميلاد:  ", style: kTextPageStyle.copyWith(color: Colors.grey)),
                          Text('$_fatherBirthYear / $_fatherBirthMonth / $_fatherBirthDay'),
                        ])
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: true,
                        title: _data.data()['_fatherAgeInBorn']==null? 'لم يتم إدخال بيانات': _data.data()['_fatherAgeInBorn'],
                        hintText: 'العمر عند الولاد',

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        readOnly: true,
                        title: _data.data()['_fatherNationality']==null? 'لم يتم إدخال بيانات': _data.data()['_fatherNationality'],
                        hintText: 'الجنسية',

                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherNumMarried']==null? 'لم يتم إدخال بيانات': _data.data()['_fatherNumMarried'],
                        hintText: 'عدد مرات الزواج',
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherNumChildren']==null?'لم يتم إدخال بيانات': _data.data()['_fatherNumChildren'],
                        hintText: 'عدد الأبناء',
                        readOnly: true,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherJob']==null? 'لم يتم إدخال بيانات': _data.data()['_fatherJob'],
                        hintText: 'الوظيفة',
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherPhone']==null? 'لم يتم إدخال بيانات': _data.data()['_fatherPhone'],
                        hintText: 'الجوال',
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                        title: _data.data()['_fatherWorkPhone']==null?'لم يتم إدخال بيانات': _data.data()['_fatherWorkPhone'],
                        hintText: 'هاتف العمل',
                        readOnly: true,
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
                              onChanged: (newValue) {},
                              items:  []
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
                                // // Not necessary for Option 1
                                onChanged: (newValue) {},
                                items:  []
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
                                onChanged: (newValue) { },
                                items: []
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
                                onChanged: (newValue) { },
                                items: []
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
                                onChanged: (newValue) {},
                                items: []
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
                                onChanged: (newValue) {},
                                items:[]
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
                                onChanged: (newValue) {},
                                items: []
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
                                onChanged: (newValue) {},
                                items: []
                              ),
                            ))
                      ]),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: KNormalTextFormField(
                       readOnly: true,
                        title: _data.data()['_numOfPplLiveHome']==null? 'اختر': _data.data()['_numOfPplLiveHome'],
                        hintText:
                        "عدد الأفراد الذين يسكنون مع الحالة في المنزل",
                        onChanged: (value) {},
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
                                onChanged: (newValue) {},
                                items:  []
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
                                onChanged: (newValue) { },
                                items:  []
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
                                onChanged: (newValue) {},
                                items: []
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
                                onChanged: (value) {},
                                items:[]
                              ),
                            ))
                      ]),
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
