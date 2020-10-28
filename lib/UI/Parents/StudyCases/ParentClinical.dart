import 'package:flutter/material.dart';
import '../../Constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParentClinicalStudy extends StatefulWidget {
  @override
  _ParentClinicalStudyState createState() => _ParentClinicalStudyState();
}

class _ParentClinicalStudyState extends State<ParentClinicalStudy> {
  TextStyle textStyle = TextStyle(
      fontSize: 17, fontWeight: FontWeight.w100, color: Colors.black87);
  User user = FirebaseAuth.instance.currentUser;

  String _oldUserName;

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
        .doc(user.email)
        .collection('StudyCases');
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(" معلومات التاريخ الطبي للطالبـ/ـة ",
                  style: kTextAppBarStyle),
              centerTitle: true,
              backgroundColor: kAppBarColor,
            ),
            body: StreamBuilder<DocumentSnapshot>(
                stream: student.doc(user.email + 'clinical').snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    DocumentSnapshot _data = snapshot.data;
                    if (_data.exists) {
                      _oldUserName = _data.data()['_editedBy'] == null
                          ? 'لا يوجد بيانات'
                          : _data.data()['_editedBy'];

                      return Container(
                          padding: EdgeInsets.all(10),
                          color: kBackgroundPageColor,
                          alignment: Alignment.topCenter,
                          child: ListView(shrinkWrap: true, children: <Widget>[
                            new Column(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "معلومات الطبيب المتابع للحالة",
                                  style: kTextPageStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: true,
                                  hintText:'اسم الطبيب:  ${_data.data()['_doctorName']==null? 'لا يوجد بيانات':_data.data()['_doctorName']}',

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: true,
                                  hintText: ' اسم المستشفى:  ${_data.data()['_hospitalName']==null?'لا يوجد بيانات':_data.data()['_hospitalName']}',

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: true,
                                  hintText: ' رقم هاتف الطبيب:  ${_data.data()['_doctorPhone']==null? 'لا يوجد بيانات':_data.data()['_doctorPhone']}',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: true,
                                  hintText: " رقم هاتف عمل الطبيب:  ${_data.data()['_doctorWorkPhone']==null? 'لا يوجد بيانات':_data.data()['_suffersOrganicDiseases']}",

                                ),
                              ),
                              //
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: true,
                                  hintText:' هاتف المستشفى:  ${ _data.data()['_hospitalPhone']==null?'لا يوجد بيانات':_data.data()['_hospitalPhone']}',

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: true,
                                  hintText: ' تحويله:  ${_data.data()['_HospitalExtPhone']==null? 'لا يوجد بيانات':_data.data()['_HospitalExtPhone']}',
                                ),
                              ),
                              //#####################################
                              //// all dropDown
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Text("أمراض عضوية يعاني منها", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: DropdownButton(
                                        hint: Text(_data.data()['_suffersOrganicDiseases']==null? 'لا يوجد بيانات':_data.data()['_suffersOrganicDiseases']),
                                        // Not necessary for Option 1
                                        onChanged: (newValue) {},
                                        items: []
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Text("هل سبق وأن تم تنويم الحالة في المستشفى", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: DropdownButton(
                                        hint: Text(
                                            _data.data()['_admissionOfHospital']==null? 'لا يوجد بيانات':_data.data()['_admissionOfHospital']),
                                        // Not necessary for Option 1
                                        onChanged: (newValue) {},
                                        items: []
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text("هل سبق وأجري للحالة أي عمليات جراحية", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: DropdownButton(
                                        hint: Text(
                                            _data.data()['_surgery']==null? 'لا يوجد بيانات':_data.data()['_surgery']),
                                        // Not necessary for Option 1
                                        onChanged: (newValue) {},
                                        items: []
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text("هل هناك أي إصابات أو حدوث حوادث", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: DropdownButton(
                                        hint:
                                        Text(_data.data()['_injuriesOrAccidents']==null? 'لا يوجد بيانات':_data.data()['_injuriesOrAccidents']),
                                        // Not necessary for Option 1
                                        onChanged: (newValue) {},
                                        items: []
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Row(
                                children: [
                                  Text("هل توجد إعاقات في العائلة", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: DropdownButton(
                                      hint: Text(_data.data()['_disabilitiesInFamily']==null? 'لا يوجد بيانات':_data.data()['_disabilitiesInFamily']),
                                      // Not necessary for Option 1
                                      onChanged: (newValue) { },
                                      items: []
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.all(50),
                                child: Center(
                                  child:Text(
                                    'اخر تعديل تم بواسطة : ${_data.data()['editBy']==null? 'لا يوجد بيانات': _data.data()['editBy']}',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                ),
                              )
                            ])
                          ]));
                    } else {
                      return Text('');
                    }
                  } else {
                    return Text('');
                  }
                })));
  }
}
