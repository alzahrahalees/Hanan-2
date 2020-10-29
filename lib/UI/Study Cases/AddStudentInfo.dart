import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../Constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddStudentInfo extends StatefulWidget {
  final String studentId;

  AddStudentInfo(this.studentId);

  @override
  _AddStudentInfoState createState() => _AddStudentInfoState();
}

class _AddStudentInfoState extends State<AddStudentInfo> {
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

    List<dynamic> _emotionalGrowth=[];

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(

              title: Text("دراسة الحالة ", style: kTextAppBarStyle),
              centerTitle: true,
              backgroundColor: kAppBarColor,
            ),
            body: Container(
                padding: EdgeInsets.all(10),
                color: kBackgroundPageColor,
                alignment: Alignment.topCenter,
                child: ListView(shrinkWrap: true, children: <Widget>[
                  new Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("تاريخ الحالة",style: kTextPageStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                            value: _whoDiscoverCase,
                            items: ["المستشفى", "الأم", "المركز", "آخرين"],
                            hint: "من أكتشف أعراض الحالة؟",
                            onChanged: (value) {
                              setState(() {
                                _whoDiscoverCase = value;
                              });
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          hint: "عمر ظهور العرض",
                          items: ["قبل السنة الأولى", "بعد السنة الأولى"],
                          onChanged: (value) {
                            setState(() {
                              _ageConditionAppears = value;
                            });
                          },
                          value: _ageConditionAppears,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: KNormalTextFormFieldLines(
                          hintText:
                              "ماهي الأعراض التي ظهرت على الطفل بداية ظهور الإضطراب",
                          onChanged: (value) {
                            _symptomsChildBeginningDisorder = value;
                          },
                        ),
                      ),


                      //The extent to which the disorder affects the child
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text("مدى تأثير الإضطراب على الطفل",style: kTextPageStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          hint: "إجتماعيا",
                          value: _socialSide,
                          onChanged: (value) {
                            setState(() {
                              _socialSide = value;
                            });
                          },
                          items: [
                            "غير متصل",
                            "متصل في بعض الأحيان",
                            "متصل بفاعلية"
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          onChanged: (v) {
                            setState(() {
                              _motorSide = v;
                            });
                          },

                          value: _motorSide,
                          hint: "حركيا",
                          items: [
                            "أداء حركي عادي",
                            "أداء حركي قليل الإتزان",
                            "أداء حركي مضطرب وغير متزن"
                          ],
                        ),
                      ),
                      Padding(

                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          items: [
                            "يعتني بنفسه دائما",
                            "يعتني بنفسه أحيانا",
                            "يساعده الآخرون دائما"
                          ],
                          hint: "العناية الشخصية",
                          value: _personalCareAspect,
                          onChanged: (value) {
                            setState(() {
                              _personalCareAspect = value;
                            });
                          },
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          hint: "معرفيا وعقليا",
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
                      Divider(color: Colors.black54,),

                      //###########
                      //Evolutionary history of the condition التاريخ التطوري للحالة

                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text("التاريخ التطوري للحالة",style: kTextPageStyle,),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          hint: "فترة الحمل",
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
                          hint: "حالة الأم الصحية أثناء فترة الحمل",
                          items: ["أمراض أخرى", "مشاكل حمل", "طبيعية"],
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
                          hint: "عملية الولادة",
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
                          hint: "أين تمت الولادة",
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
                          hint: "هل حدث إضطراب أثناء الولادة",
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
                          hintText: "إذا كانت الإجابة نعم أذكريها",
                          onChanged: (value) {
                            _birthDisorder = value;
                          },
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          hint: "وزن الطفل عند الولادة",
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
                          hint: "نوع الرضاعة",
                          items: ['طبيعية-صناعية', "صناعية", "طبيعية"],
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
                          hint: "متى بدأ بالجلوس",
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
                          hint: "الوقوف",
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
                          hint: "المشي",
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
                          hint: "التسنين",
                          items: ['قبل سنة', "بعد سنة", "سنة"],
                          onChanged: (value) {
                            setState(() {
                              _teething = value;
                            });
                          },
                          value: _teething,
                        ),
                      ),
                      Divider(color: Colors.black54,),


                      //#######################
                      //Emotional growth
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: MultiSelectFormField(

                            hintWidget: Center(child: Text('اضغط لاختيار واحدة أو أكثر')),
                            fillColor: kBackgroundPageColor,
                            autovalidate: false,
                            title: Text('النمو الإنفعالي'),
                            validator: (value) {
                              if (value == null || value.length == 0) {
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
                              change: (value){
                              for(int i =0; i<value.length;i++){
                                if(value[i]!=null)
                                  _emotionalGrowth.add(value[i].toString());
                                print(_emotionalGrowth);
                              }},
                            onSaved: (value){
                              for (var t in value){
                                _emotionalGrowth.add(t);
                              }
                              print(_emotionalGrowth);
                              }

                          ),
                        ),
                      ),
                      Divider(color: Colors.black54,),



                      //#############
                      //general Capalties
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("القدرات العامة",style: kTextPageStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          hint: "الإنتباه والتركيز",
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
                          hint: "الإستيعاب والفهم",
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
                          hint: "الإدراك",
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
                          hint: "التذكر",
                          items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                          onChanged: (value) {
                            setState(() {
                              _memory = value;
                            });
                          },
                          value: _memory,
                        ),
                      ),
                      Divider(color: Colors.black54,),


                      //####################
                      //Personal skills
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("المهارت الشخصية",style: kTextPageStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          hint: "كثير النشاط والحركة",
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
                          hint: "يؤذي نفسه",
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
                          hint: "يؤذي الآخرين",
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
                          hint: "كثير التخريب",
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
                          hint: "كثير الصراخ",
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
                          hint: "يتقبل الآخرين بسرعة",
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
                          hint: "تنتابه نوبات غضب",
                          items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                          onChanged: (value) {
                            setState(() {
                              _hasTantrums = value;
                            });
                          },
                          value: _hasTantrums,
                        ),
                      ),
                      Divider(color: Colors.black54,),



                      //#################
                      // Self-reliance skills
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text("مهارات الإعتماد عالذات",style: kTextPageStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          hint: "الإعنماد على الذات في الأكل والشرب",
                          items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                          onChanged: (value) {
                            setState(() {
                              _selfRelianceInEatingAndDrinking = value;
                            });
                          },
                          value: _selfRelianceInEatingAndDrinking,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          hint: "يطلب دخول الحمام",
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
                          hint: "يغير ملابسه",
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
                          hint: "يلبس حذائه",
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
                          hint: "يغسل يديه",
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
                          hint: "يفرش أسنانه",
                          items: ["ممتاز", "متوسط", "جيد", "ضعيف"],
                          onChanged: (value) {
                            setState(() {
                              _brushingTeeth = value;
                            });
                          },
                          value: _brushingTeeth,
                        ),
                      ),
                      Divider(color: Colors.black54,),


                      //###################
                      // Communication skills
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("مهارات التواصل",style: kTextPageStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KDropDownList(
                          hint: "التواصل اللفظي",
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
                          hint: "التواصل البصري",
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
                          hint: "التواصل الإجتماعي",
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
                          hint: "النمو اللغوي",
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
                          hint: "القدرة التعبيرية",
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
                          hint: "المهارات اللإستقلالية",
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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KNormalTextFormFieldLinesNoV(
                          hintText:
                              'ماهي المراكز أو المدارس التي التحق فيها الطفل قبل ذلك',
                          onChanged: (value) {
                            _latestCentersAndSchools = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KNormalTextFormFieldLinesNoV(
                          hintText:
                              'ماهي الأهداف التي تعبر بالنسبة للوالدين ذات أهمية والتي يريدون وضعها في البرنامج التربوي الفردي',
                          onChanged: (value) {
                            _importantGoalsForParents = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KNormalTextFormFieldLinesNoV(
                          hintText: 'ملاحظات الأسرة الإضافية',
                          onChanged: (value) {
                            _extraFamilyNotes = value;
                          },
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
                                .doc(widget.studentId + 'info')
                                .set({
                                  '_attentionAndFocus': _attentionAndFocus,
                                  '_comprehensionAndUnderstanding':
                                      _comprehensionAndUnderstanding,
                                  '_perception': _perception,
                                  '_memory': _memory,
                                  //Personal skills
                                  '_moreActive': _moreActive,
                                  '_hurtsHimself': _hurtsHimself,
                                  '_hurtsOthers': _hurtsOthers,
                                  '_aLotOfSabotage': _aLotOfSabotage,
                                  '_aLotOfShouting': _aLotOfShouting,
                                  '_quicklyEmbracesOthers': _quicklyEmbracesOthers,
                                  '_hasTantrums': _hasTantrums,
                                  //Self-reliance skills
                                  '_selfRelianceInEatingAndDrinking': _selfRelianceInEatingAndDrinking,
                                  '_bathIsRequired': _bathIsRequired,
                                  '_changesClothes': _changesClothes,
                                  '_wearsShoes': _wearsShoes,
                                  '_washesHands': _washesHands,
                                  '_brushingTeeth': _brushingTeeth,
                                  //Communication skills
                                  '_verbalCommunication': _verbalCommunication,
                                  '_eyeContact': _eyeContact,
                                  '_socialMedia': _socialMedia,
                                  '_languageDevelopment': _languageDevelopment,
                                  '_expressiveAbility': _expressiveAbility,
                                  '_independenceSkills': _independenceSkills,
                                  //The extent to which the disorder affects the child
                                  '_socialSide': _socialSide,
                                  '_motorSide': _motorSide,
                                  '_personalCareAspect': _personalCareAspect,
                                  '_cognitiveMentalAspect': _cognitiveMentalAspect,
                                  //Evolutionary history of the condition
                                  '_durationOfPregnancy': _durationOfPregnancy,
                                  '_motherHealthInPregnancy': _motherHealthInPregnancy,
                                  '_birthProcess': _birthProcess,
                                  '_placeOfBirth': _placeOfBirth,
                                  '_disturbanceAtChildbirth': _disturbanceAtChildbirth,
                                  '_birthDisorder': _birthDisorder,
                                  '_babyBirthWeight': _babyBirthWeight,
                                  '_typeOfLactation': _typeOfLactation,
                                  //Growth history
                                  '_startSitting': _startSitting,
                                  '_standUp': _standUp,
                                  '_walking': _walking,
                                  '_teething': _teething,
                                  '_whoDiscoverCase': _whoDiscoverCase,
                                  '_ageConditionAppears': _ageConditionAppears,
                                  '_symptomsChildBeginningDisorder': _symptomsChildBeginningDisorder,
                                  //the last
                                  '_latestCentersAndSchools': _latestCentersAndSchools,
                                  '_importantGoalsForParents': _importantGoalsForParents,
                                  '_extraFamilyNotes': _extraFamilyNotes,
                                  '_editedBy': _currentUserName,
                                  '_emotionalGrowth': _emotionalGrowth
                                })
                                .whenComplete(() => Navigator.pop(context))
                                .catchError((err) => print(err));
                          },
                        ),
                      ),
                    ],
                  )
                ]))));
  }
}

class KDropDownList extends StatelessWidget {
  final String value;
  final List items;
  final Function onChanged;
  final String hint;

  const KDropDownList({this.value, this.items, this.onChanged, this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        alignment: Alignment(1, 0),
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
    );
  }
}
