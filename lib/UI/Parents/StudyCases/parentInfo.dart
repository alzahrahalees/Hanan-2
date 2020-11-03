import 'package:flutter/material.dart';
import '../../Constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParentInfoStudy extends StatefulWidget {
  @override
  _ParentInfoStudyState createState() => _ParentInfoStudyState();
}

class _ParentInfoStudyState extends State<ParentInfoStudy> {
  User user = FirebaseAuth.instance.currentUser;

  //the last

  @override
  Widget build(BuildContext context) {
    String _oldUser;
    List<dynamic> _emotionalGrowth = [];

    var student = FirebaseFirestore.instance
        .collection('Students')
        .doc(user.email)
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
                stream: student.doc(user.email + 'info').snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    DocumentSnapshot _data = snapshot.data;
                    if (_data.exists) {
                      _emotionalGrowth = _data.data()['_emotionalGrowth'];
                      _oldUser = _data.data()['_editedBy'] == null
                          ? 'لا يوجد بيانات'
                          : _data.data()['_editedBy'];

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
                                      Text("من أكتشف أعراض الحالة؟",
                                          style: kTextPageStyle.copyWith(
                                              color: Colors.grey)),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: DropdownButton(
                                          items: [],
                                          onChanged: (v) {},
                                          hint: Text(_data.data()[
                                                      '_whoDiscoverCase'] ==
                                                  null
                                              ? 'لا يوجد بيانات'
                                              : _data
                                                  .data()['_whoDiscoverCase']),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text("عمر ظهور العرض",
                                          style: kTextPageStyle.copyWith(
                                              color: Colors.grey)),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: DropdownButton(
                                          onChanged: (v) {},
                                          items: [],
                                          hint: Text(_data.data()[
                                                      '_ageConditionAppears'] ==
                                                  null
                                              ? 'لا يوجد بيانات'
                                              : _data.data()[
                                                  '_ageConditionAppears']),
                                          // Not necessary for Option 1
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        'ماهي الأعراض التي ظهرت على الطفل بداية ظهور الإضطراب؟'),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: KNormalTextFormFieldLines(
                                        readOnly: true,
                                        hintText: _data.data()[
                                                    '_symptomsChildBeginningDisorder'] ==
                                                null
                                            ? 'لا يوجد بيانات'
                                            : _data.data()[
                                                '_symptomsChildBeginningDisorder'],
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
                                      Text("إجتماعيا",
                                          style: kTextPageStyle.copyWith(
                                              color: Colors.grey)),
                                      Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: DropdownButton(
                                            hint: Text(
                                                _data.data()['_socialSide'] ==
                                                        null
                                                    ? 'لا يوجد بيانات'
                                                    : _data
                                                        .data()['_socialSide']),
                                            // Not necessary for Option 1

                                            onChanged: (newValue) {},
                                            items: []),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "معرفيا وعقليا",
                                    hint: _data.data()[
                                                '_cognitiveMentalAspect'] ==
                                            null
                                        ? 'لا يوجد بيانات'
                                        : _data
                                            .data()['_cognitiveMentalAspect'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "العناية الشخصية",
                                    onChanged: (v) {},
                                    hint: _data.data()['_personalCareAspect'] ==
                                            null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_personalCareAspect'],
                                    items: [],
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
                                    hint:
                                        _data.data()['_durationOfPregnancy'] ==
                                                null
                                            ? 'لا يوجد بيانات'
                                            : _data
                                                .data()['_durationOfPregnancy'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "حالة الأم الصحية أثناء فترة الحمل",
                                    hint: _data.data()[
                                                '_motherHealthInPregnancy'] ==
                                            null
                                        ? 'لا يوجد بيانات'
                                        : _data
                                            .data()['_motherHealthInPregnancy'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "عملية الولادة",
                                    hint: _data.data()['_birthProcess'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_birthProcess'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "أين تمت الولادة",
                                    hint: _data.data()['_placeOfBirth'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_placeOfBirth'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "هل حدث إضطراب أثناء الولادة",
                                    hint: _data.data()[
                                                '_disturbanceAtChildbirth'] ==
                                            null
                                        ? 'لا يوجد بيانات'
                                        : _data
                                            .data()['_disturbanceAtChildbirth'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KNormalTextFormField(
                                    readOnly: true,
                                    title:
                                        _data.data()['_birthDisorder'] == null
                                            ? 'لا يوجد بيانات'
                                            : _data.data()['_birthDisorder'],
                                    hintText: "إذا كانت الإجابة نعم أذكريها",
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "وزن الطفل عند الولادة",
                                    hint:
                                        _data.data()['_babyBirthWeight'] == null
                                            ? 'لا يوجد بيانات'
                                            : _data.data()['_babyBirthWeight'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "نوع الرضاعة",
                                    hint:
                                        _data.data()['_typeOfLactation'] == null
                                            ? 'لا يوجد بيانات'
                                            : _data.data()['_typeOfLactation'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                //Growth history
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "متى بدأ بالجلوس",
                                    hint: _data.data()['_startSitting'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_startSitting'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "الوقوف",
                                    hint: _data.data()['_standUp'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_standUp'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                      title: "المشي",
                                      hint: _data.data()['_walking'] == null
                                          ? 'لا يوجد بيانات'
                                          : _data.data()['_walking'],
                                      items: [],
                                      onChanged: (value) {}),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "التسنين",
                                    hint: _data.data()['_teething'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_teething'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Divider(
                                  color: Colors.black54,
                                ),

                                // #######################
                                // Emotional growth
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    'النمو الإنفعالي',
                                    style: kTextPageStyle,
                                  ),
                                ),
                                _emotionalGrowth.isNotEmpty
                                    ? Container(
                                        width: 300,
                                        height: 70,
                                        child: ListView(
                                          scrollDirection:  Axis.horizontal,
                                          children: _emotionalGrowth.map((location) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Center(child: Text(location)),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Text(
                                          'لم يتم إضافة بيانات',
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
                                    hint: _data.data()['_attentionAndFocus'] ==
                                            null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_attentionAndFocus'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "الإستيعاب والفهم",
                                    hint: _data.data()[
                                                '_comprehensionAndUnderstanding'] ==
                                            null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()[
                                            '_comprehensionAndUnderstanding'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "الإدراك",
                                    hint: _data.data()['_perception'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_perception'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "التذكر",
                                    hint: _data.data()['_memory'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_memory'],
                                    items: [],
                                    onChanged: (value) {},
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
                                    hint: _data.data()['_moreActive'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_moreActive'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يؤذي نفسه",
                                    hint: _data.data()['_hurtsHimself'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_hurtsHimself'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يؤذي الآخرين",
                                    hint: _data.data()['_hurtsOthers'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_hurtsOthers'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "كثير التخريب",
                                    hint:
                                        _data.data()['_aLotOfSabotage'] == null
                                            ? 'لا يوجد بيانات'
                                            : _data.data()['_aLotOfSabotage'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "كثير الصراخ",
                                    hint:
                                        _data.data()['_aLotOfShouting'] == null
                                            ? 'لا يوجد بيانات'
                                            : _data.data()['_aLotOfShouting'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يتقبل الآخرين بسرعة",
                                    hint: _data.data()[
                                                '_quicklyEmbracesOthers'] ==
                                            null
                                        ? 'لا يوجد بيانات'
                                        : _data
                                            .data()['_quicklyEmbracesOthers'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "تنتابه نوبات غضب",
                                    hint: _data.data()['_hasTantrums'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_hasTantrums'],
                                    items: [],
                                    onChanged: (value) {},
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
                                    hint: _data.data()[
                                                '_selfRelianceInEatingAndDrinking'] ==
                                            null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()[
                                            '_selfRelianceInEatingAndDrinking'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يطلب دخول الحمام",
                                    hint:
                                        _data.data()['_bathIsRequired'] == null
                                            ? 'لا يوجد بيانات'
                                            : _data.data()['_bathIsRequired'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يغير ملابسه",
                                    hint:
                                        _data.data()['_changesClothes'] == null
                                            ? 'لا يوجد بيانات'
                                            : _data.data()['_changesClothes'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يلبس حذائه",
                                    hint: _data.data()['_wearsShoes'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_wearsShoes'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يغسل يديه",
                                    hint: _data.data()['_washesHands'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_washesHands'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "يفرش أسنانه",
                                    hint: _data.data()['_brushingTeeth'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_brushingTeeth'],
                                    items: [],
                                    onChanged: (value) {},
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
                                    hint:
                                        _data.data()['_verbalCommunication'] ==
                                                null
                                            ? 'لا يوجد بيانات'
                                            : _data
                                                .data()['_verbalCommunication'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "التواصل البصري",
                                    hint: _data.data()['_eyeContact'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_eyeContact'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "التواصل الإجتماعي",
                                    hint: _data.data()['_socialMedia'] == null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_socialMedia'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "النمو اللغوي",
                                    hint:
                                        _data.data()['_languageDevelopment'] ==
                                                null
                                            ? 'لا يوجد بيانات'
                                            : _data
                                                .data()['_languageDevelopment'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "القدرة التعبيرية",
                                    hint: _data.data()['_expressiveAbility'] ==
                                            null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_expressiveAbility'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: KDropDownList(
                                    title: "المهارات اللإستقلالية",
                                    hint: _data.data()['_independenceSkills'] ==
                                            null
                                        ? 'لا يوجد بيانات'
                                        : _data.data()['_independenceSkills'],
                                    items: [],
                                    onChanged: (value) {},
                                  ),
                                ),

                                //the last
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'ماهي المراكز أو المدارس التي التحق فيها الطفل قبل ذلك'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: KNormalTextFormFieldLines(
                                        readOnly: true,
                                        hintText: _data.data()[
                                                    '_latestCentersAndSchools'] ==
                                                null
                                            ? 'لم يتم إضافة بيانات'
                                            : _data.data()[
                                                '_latestCentersAndSchools'],
                                        onChanged: (value) {
                                          _data.data()[
                                                  '_latestCentersAndSchools'] =
                                              value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'ماهي الأهداف التي تعبر بالنسبة للوالدين ذات أهمية والتي يريدون وضعها في البرنامج التربوي الفردي',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: KNormalTextFormFieldLines(
                                        readOnly: true,
                                        hintText: _data.data()[
                                                    '_importantGoalsForParents'] ==
                                                null
                                            ? 'لم يتم إضافة بيانات'
                                            : _data.data()[
                                                '_importantGoalsForParents'],
                                        onChanged: (value) {
                                          _data.data()[
                                                  '_importantGoalsForParents'] =
                                              value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'ملاحظات الأسرة الإضافية',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: KNormalTextFormFieldLines(
                                        readOnly: true,
                                        hintText: _data.data()[
                                                    '_extraFamilyNotes'] ==
                                                null
                                            ? ''
                                            : _data.data()['_extraFamilyNotes'],
                                        onChanged: (value) {
                                          _data.data()['_extraFamilyNotes'] =
                                              value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      'اخر تعديل تم بواسطة : $_oldUser',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black54),
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
                })));
  }
}

class KDropDownList extends StatelessWidget {
  final String value;
  final List items;
  final Function onChanged;
  final String hint;
  final String title;

  const KDropDownList(
      {this.value, this.items, this.onChanged, this.hint, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title == null ? '' : title,
              style: kTextPageStyle.copyWith(color: Colors.grey)),
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
