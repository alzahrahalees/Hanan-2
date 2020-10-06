import 'package:flutter/material.dart';
import 'TeacherStudentInfo.dart';
import '../Constance.dart';
import 'package:flutter/cupertino.dart';

class AddCase extends StatefulWidget {
  @override
  _AddCaseState createState() => _AddCaseState();
}

class _AddCaseState extends State<AddCase> {
  final _formkey = GlobalKey<FormState>();

  //mother
  TextEditingController _motherName = TextEditingController();
  TextEditingController _motherNationality = TextEditingController();
  TextEditingController _motherAgeInBorn = TextEditingController();
  TextEditingController _motherJob = TextEditingController();
  TextEditingController _motherWorkPhone = TextEditingController();
  TextEditingController _motherPhone = TextEditingController();
  TextEditingController _motherNumMarried = TextEditingController();
  TextEditingController _motherNumChildren = TextEditingController();
  DateTime _motherBirthDate = DateTime.now();
  String _motherEducation;
  String _motherSocialStatus;

  //father
  TextEditingController _fatherName = TextEditingController();
  TextEditingController _fatherNationality = TextEditingController();
  TextEditingController _fatherAgeInBorn = TextEditingController();
  TextEditingController _fatherJob = TextEditingController();
  TextEditingController _fatherWorkPhone = TextEditingController();
  TextEditingController _fatherPhone = TextEditingController();
  TextEditingController _fatherNumMarried = TextEditingController();
  TextEditingController _fatherNumChildren = TextEditingController();
  DateTime _fatherBirthDate = DateTime.now();
  String _fatherEducation;
  String _fatherSocialStatus;

  //doctor
  TextEditingController _doctorName = TextEditingController();
  TextEditingController _hospitalName = TextEditingController();
  TextEditingController _doctorPhone = TextEditingController();
  TextEditingController _doctorWorkPhone = TextEditingController();
  TextEditingController _hospitalPhone = TextEditingController();
  TextEditingController _HospitalExtPhone = TextEditingController();
  DateTime _interviewDate = DateTime.now();

  //Understand the family for the Student Case
  String _motherUnderstandCase;
  String _motherCaseCare;
  String _fatherUnderstandCase;

  String _sisAndBroUnderstandCase;
  String _parentKinship;
  String _parentRelationship;
  TextEditingController _numOfPplLiveHome = TextEditingController();

  //The housing situation of the family
  String _kindOFBulid;
  String _housingCondition;

  //The economic situation of the family
  String _familyIncomeSources;
  String _yearLevelIncome;

  //Case History
  String _whoDiscoverCase;
  String _ageConditionAppears;
  TextEditingController _symptomsChildBeginningDisorder =
      TextEditingController();

//Emotional growth
  List emotionalGrowth;

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
  TextEditingController _birthDisorder = TextEditingController();
  String _babyBirthWeight;
  String _typeOfLactation;

  //Growth history
  String _startSitting;
  String _standUp;
  String _walking;
  String _teething;

  //Medical history
  String _suffersOrganicDiseases;
  String _admissionOfHospital;
  String _surgery;
  String _injuriesOrAccidents;
  String _disabilitiesInFamily;

  //the last
  TextEditingController _latestCentersAndSchools = TextEditingController();
  TextEditingController _importantGoalsForParents = TextEditingController();
  TextEditingController _extraFamilyNotes = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            body: Container(
                padding: EdgeInsets.all(10),
                color: kBackgroundPageColor,
                alignment: Alignment.topCenter,
                child: Form(
                    key: _formkey,
                    child: ListView(shrinkWrap: true, children: <Widget>[
                      new Column(children: <Widget>[
                        kDatePicker(_interviewDate, "تاريخ المقابلة"),
                        //mother info
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "معلومات الأم",
                            style: kTextPageStyle,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'اسم الأم',
                            controller: _motherName,
                          ),
                        ),
                        kDatePicker(_motherBirthDate, "تاريخ الميلاد"),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'العمر عند الولادة',
                            controller: _motherAgeInBorn,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'الجنسية',
                            controller: _motherNationality,
                          ),
                        ),
                        KDropDownList(
                            "الحالة الإجتماعية",
                            "الحالة الإجتماعية للأم",
                            _motherSocialStatus,
                            ["أرملة", "متزوجة", "مطلقة"]),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'عدد مرات الزواج',
                            controller: _motherNumMarried,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'عدد الأبناء',
                            controller: _motherNumChildren,
                          ),
                        ),
                        KDropDownList(
                            "المستوى العلمي",
                            "المستوى العلمي للأم",
                            _motherEducation,
                            ["عالي", "ثانوي", "متوسط", "إبتدائي", "أمي"]),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'الوظيفة',
                            controller: _motherJob,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'الجوال',
                            controller: _motherPhone,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormFieldNoV(
                            hintText: 'هاتف العمل',
                            controller: _motherWorkPhone,
                          ),
                        ),
                        //father info
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "معلومات الأب",
                            style: kTextPageStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: "اسم الأب",
                            controller: _fatherName,
                          ),
                        ),
                        kDatePicker(_fatherBirthDate, "تاريخ الميلاد"),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'العمر عند الولادة',
                            controller: _fatherAgeInBorn,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'الجنسية',
                            controller: _fatherNationality,
                          ),
                        ),
                        KDropDownList(
                            "الحالة الإجتماعية",
                            "الحالة الإجتماعية للأب",
                            _fatherSocialStatus,
                            ["أرمل", "متزوج", "مطلق"]),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'عدد مرات الزواج',
                            controller: _fatherNumMarried,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'عدد الأبناء',
                            controller: _fatherNumChildren,
                          ),
                        ),
                        KDropDownList(
                            "المستوى العلمي",
                            "المستوى العلمي للأب",
                            _fatherEducation,
                            ["عالي", "ثانوي", "متوسط", "إبتدائي", "أمي"]),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'الوظيفة',
                            controller: _fatherJob,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'الجوال',
                            controller: _fatherPhone,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormFieldNoV(
                            hintText: 'هاتف العمل',
                            controller: _fatherWorkPhone,
                          ),
                        ),
                        //doctor info
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "معلومات الطبيب المتابع للحالة",
                            style: kTextPageStyle,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'اسم الطبيب',
                            controller: _doctorName,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'اسم المستشفى-العيادة',
                            controller: _hospitalName,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            validatorText: '#مطلوب',
                            hintText: 'هاتف الطبيب',
                            controller: _doctorPhone,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormFieldNoV(
                            hintText: 'هاتف العمل',
                            controller: _doctorWorkPhone,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormFieldNoV(
                            hintText: "هاتف المستشفى",
                            controller: _hospitalPhone,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormFieldNoV(
                            hintText: "تحويلة",
                            controller: _HospitalExtPhone,
                          ),
                        ),
                        //Family care with case
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("تعامل أفراد الأسرة مع الحالة"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("تفهم للحالة",
                              "تفهم الأم للحالة", _motherUnderstandCase, [
                            "غير مهتة ولا تعي بالحالة",
                            "لديها معلومات غير كافية عن الحالة",
                            "واعية ومتفهمة للحالة"
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("رعاية الحالة",
                              "رعاية الأم للحالة", _motherCaseCare, [
                            "تلقي بالمسؤولية على الآخرين",
                            "تشاركها خادمة أو آخرين",
                            "تعتني بها بنفسها في المنزل"
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("تفهم للحالة",
                              "تفهم الأب للحالة", _fatherUnderstandCase, [
                            "غير مهتم ولا يعي بالحالة",
                            "لديه معلومات غير كافية عن الحالة",
                            "واعي ومتفهم للحالة"
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("تفهم للحالة",
                              "تفهم الأخوة للحالة", _sisAndBroUnderstandCase, [
                            "غير مهتمين ولا مدركين بالحالة",
                            "لديهم معلومات غير كافية عن الحالة",
                            "واعيين ومتفهمين للحالة"
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("صلة قرابة الوالدين", "اختر",
                              _parentKinship, ["يوجد قرابة", "لا يوجد قرابة"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("طبيعة علاقة الوالدين", "اختر",
                              _parentRelationship, [
                            "الزوجين منفصلين",
                            "اضطرابات في العلاقة",
                            "وجود بعض الخلافات",
                            "علاقة جيدة"
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(
                            hintText:
                                "عدد الأفراد الذين يسكنون مع الحالة في المنزل",
                            controller: _numOfPplLiveHome,
                          ),
                        ),
                        //The housing situation of the family
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("الوضع السكني للأسرة"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("نوع السكن", "اختر",
                              _kindOFBulid, ["فيلا", "شقة"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("حالة السكن", "اختر",
                              _housingCondition, ["إيجار", "ملك"]),
                        ),
                        //The economic situation of the family
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("الوضع الإقتصادي للأسرة"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "مصادر دخل الأسرة",
                              "اختر",
                              _familyIncomeSources,
                              ["أعمال حرة", "عمل", "عقارات"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "مستوى الدخل السنوي",
                              "اختر",
                              _yearLevelIncome,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),

                        //Case History
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("تاريخ الحالة"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "من أكتشف أعراض الحالة؟",
                              "اختر",
                              _whoDiscoverCase,
                              ["المستشفى", "الأم", "المركز", "آخرين"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "عمر ظهور العرض",
                              "اختر",
                              _ageConditionAppears,
                              ["قبل السنة الأولى", "بعد السنة الأولى"]),
                        ),
                        KNormalTextFormFieldLines(
                          hintText:
                              "ماهي الأعراض التي ظهرت على الطفل بداية ظهور الإضطراب",
                          validatorText: "مطلوب",
                          controller: _symptomsChildBeginningDisorder,
                        ),
                        //The extent to which the disorder affects the child
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("مدى تأثير الإضطراب على الطفل"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "إجتماعيا", "اختر", _socialSide, [
                            "غير متصل",
                            "متصل في بعض الأحيان",
                            "متصل بفاعلية"
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("حركيا", "اختر", _motorSide, [
                            "أداء حركي عادي",
                            "أداء حركي قليل الإتزان",
                            "أداء حركي مضطرب وغير متزن"
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "العناية الشخصية", "اختر", _personalCareAspect, [
                            "يعتني بنفسه دائما",
                            "يعتني بنفسه أحيانا",
                            "يساعده الآخرون دائما"
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "معرفيا وعقليا", "اختر", _cognitiveMentalAspect, [
                            "يفهم بسرعة ويتصرف بوعي",
                            "يفهم ببطء ويتصرف أحيانا بوعي",
                            "لا يفهم ولا يتصرف بوعي"
                          ]),
                        ),

                        //Evolutionary history of the condition التاريخ التطوري للحالة
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("التاريخ التطوري للحالة"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "فترة الحمل",
                              "اختر",
                              _durationOfPregnancy,
                              ["قبل تسعة أشهر", "طبيعي تسعة أشهر"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "حالة الأم الصحية أثناء فترة الحمل",
                              "اختر",
                              _motherHealthInPregnancy,
                              ["أمراض أخرى", "مشاكل حمل", "طبيعية"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("عملية الولادة", "اختر",
                              _birthProcess, ["طبيعي", "قيصري"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("أين تمت الولادة", "اختر",
                              _placeOfBirth, ["الأخرى", "المستشفى", "المنزل"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("هل حدث إضطراب أثناء الولادة",
                              "اختر", _disturbanceAtChildbirth, ["نعم", "لا"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormFieldNoV(
                            hintText: "إذا كانت الإجابة نعم أذكريها",
                            controller: _birthDisorder,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("وزن الطفل عند الولادة", "اختر",
                              _babyBirthWeight, [
                            "أخرى",
                            "أربعة إلى خمسة كيلو",
                            "ثلاثة إلى أربعة كيلو",
                            "إثنين إلى ثلاثة كيلو"
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "نوع الرضاعة",
                              "اختر",
                              _typeOfLactation,
                              ['طبيعية-صناعية', "صناعية", "طبيعية"]),
                        ),
                        //Growth history
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("متى بدأ بالجلوس", "اختر",
                              _startSitting, ['قبل سنة', "بعد سنة", "سنة"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("الوقوف", "اختر", _standUp,
                              ['قبل سنة', "بعد سنة", "سنة"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("المشي", "اختر", _walking,
                              ['قبل سنة', "بعد سنة", "سنة"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("التسنين", "اختر", _teething,
                              ['قبل سنة', "بعد سنة", "سنة"]),
                        ),

                        //Medical history
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("االتاريخ الطبي"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "أمراض عضوية يعاني منها",
                              "اختر",
                              _suffersOrganicDiseases,
                              ['أمراض مزمنة', "أمراض غير مزمنة"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "هل سبق وأن تنويم الحالة في المستشفى",
                              "اختر",
                              _admissionOfHospital,
                              ['نعم', "لا"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "هل سبق وأجري للحالة أي عمليات جراحية",
                              "اختر",
                              _surgery,
                              ['نعم', "لا"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "هل هناك أي إصابات أو حدوث حوادث",
                              "اختر",
                              _injuriesOrAccidents,
                              ['نعم', "لا"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("هل توجد إعاقات في العائلة",
                              "اختر", _disabilitiesInFamily, ['نعم', "لا"]),
                        ),
                        //Emotional growth
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: MultiSelect(emotionalGrowth),
                        ),

                        //general Capalties
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("القدرات العامة"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "الإنتباه والتركيز",
                              "اختر",
                              _attentionAndFocus,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "الإستيعاب والفهم",
                              "اختر",
                              _comprehensionAndUnderstanding,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("الإدراك", "اختر", _perception,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("التذكر", "اختر", _memory,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        //Personal skills
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("المهارت الشخصية"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("كثير النشاط والحركة", "اختر",
                              _moreActive, ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("يؤذي نفسه", "اختر",
                              _hurtsHimself, ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("يؤذي الآخرين", "اختر",
                              _hurtsOthers, ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "كثير التخريب",
                              "اختر",
                              _aLotOfSabotage,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "كثير الصراخ",
                              "اختر",
                              _aLotOfShouting,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "يتقبل الآخرين بسرعة",
                              "اختر",
                              _quicklyEmbracesOthers,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("تنتابه نوبات غضب", "اختر",
                              _hasTantrums, ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        // Self-reliance skills
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("مهارات الإعتماد عالذات"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "الإعنماد على الذات في الأكل والشرب",
                              "اختر",
                              _selfRelianceInEatingAndDrinking,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "يطلب دخول الحمام",
                              "اختر",
                              _bathIsRequired,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "يغير ملابسه",
                              "اختر",
                              _changesClothes,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("يلبس حذائه", "اختر",
                              _wearsShoes, ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("يغسل يديه", "اختر",
                              _washesHands, ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "يفرش أسنانه",
                              "اختر",
                              _brushingTeeth,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        // Communication skills
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("مهارات التواصل"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "التواصل اللفظي",
                              "اختر",
                              _verbalCommunication,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("التواصل البصري", "اختر",
                              _eyeContact, ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList("التواصل الإجتماعي", "اختر",
                              _socialMedia, ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "النمو اللغوي",
                              "اختر",
                              _languageDevelopment,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "القدرة التعبيرية",
                              "اختر",
                              _expressiveAbility,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KDropDownList(
                              "المهارات اللإستقلالية",
                              "اختر",
                              _independenceSkills,
                              ["ممتاز", "متوسط", "جيد", "ضعيف"]),
                        ),

                        //the last
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormFieldLinesNoV(
                            hintText:
                                'ماهي المراكز أو المدارس التي التحق فيها الطفل قبل ذلك',
                            controller: _latestCentersAndSchools,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormFieldLinesNoV(
                            hintText:
                                'ماهي الأهداف التي تعبر بالنسبة للوالدين ذات أهمية والتي يريدون وضعها في البرنامج التربوي الفردي',
                            controller: _importantGoalsForParents,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormFieldLinesNoV(
                            hintText: 'ملاحظات الأسرة الإضافية',
                            controller: _extraFamilyNotes,
                          ),
                        ),

                        //RaisedButton
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: RaisedButton(
                            color: kButtonColor,
                            child: Text("إضافة دراسة الحالة ",
                                style: kTextButtonStyle),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            onPressed: () {
                              if (_formkey.currentState.validate()) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StudentInfo()));
                              }
                            },
                          ),
                        ),
                      ])
                    ])))));
  }
}
