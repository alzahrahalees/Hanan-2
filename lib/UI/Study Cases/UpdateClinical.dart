import 'package:flutter/material.dart';
import '../Constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateClinical extends StatefulWidget {
  final String studentId;

  UpdateClinical(this.studentId);

  @override
  _UpdateClinicalState createState() => _UpdateClinicalState();
}

class _UpdateClinicalState extends State<UpdateClinical> {
  User user = FirebaseAuth.instance.currentUser;
  String _suffersOrganicDiseases;
  String _admissionOfHospital;
  String _surgery;
  String _injuriesOrAccidents;
  String _disabilitiesInFamily;
  String _doctorName;
  String _hospitalName;

  String _doctorPhone;

  String _doctorWorkPhone;

  String _hospitalPhone;

  String _HospitalExtPhone;
  String _oldUserName;
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
              iconTheme: IconThemeData(color: kUnselectedItemColor),
              title: Text(" معلومات التاريخ الطبي للطالبـ/ـة ",
                  style: kTextAppBarStyle),
              centerTitle: true,
              backgroundColor: kAppBarColor,
            ),
            body: StreamBuilder<DocumentSnapshot>(
                stream: student.doc(widget.studentId + 'clinical').snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {

                    DocumentSnapshot _data = snapshot.data;

                    if (_data.exists) {

                      _oldUserName = _data.data()['editedBy']==null? 'لا يوجد بيانات': _data.data()['editedBy'] ;

                      return Container(
                          padding: EdgeInsets.all(10),
                          color: kBackgroundPageColor,
                          alignment: Alignment.topCenter,
                          child: ListView(
                              shrinkWrap: true, children: <Widget>[
                             Column(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "معلومات الطبيب المتابع للحالة",
                                  style: kTextPageStyle,
                                ),
                              ),
                              //
                              //
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: false,
                                  hintText:'اسم الطبيب:  ${_data.data()['_doctorName']==null? '':_data.data()['_doctorName']}',
                                  onChanged: (value) {
                                    _doctorName = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: false,
                                  hintText: ' اسم المستشفى:  ${_data.data()['_hospitalName']==null? '':_data.data()['_hospitalName']}',
                                  onChanged: (value) {
                                    _hospitalName = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: false,
                                  hintText: ' رقم هاتف الطبيب:  ${_data.data()['_doctorPhone']==null? '':_data.data()['_doctorPhone']}',
                                  onChanged: (value) {
                                    _doctorPhone = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: false,
                                  hintText: " رقم هاتف عمل الطبيب:  ${_data.data()['_doctorWorkPhone']==null? '':_data.data()['_suffersOrganicDiseases']}",
                                  onChanged: (value) {
                                    _doctorWorkPhone = value;
                                  },
                                ),
                              ),
                              //
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: false,
                                  hintText:' هاتف المستشفى:  ${ _data.data()['_hospitalPhone']==null? '':_data.data()['_hospitalPhone']}',
                                  onChanged: (value) {
                                    _hospitalPhone = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: KNormalTextFormField(
                                  readOnly: false,
                                  hintText: ' تحويله:  ${_data.data()['_HospitalExtPhone']==null? '':_data.data()['_HospitalExtPhone']}',
                                  onChanged: (value) {
                                    _HospitalExtPhone = value;
                                  },
                                ),
                              ),
                              //
                              //
                              // //#####################################
                              // //// all dropDown
                              //
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Text("أمراض عضوية يعاني منها", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: DropdownButton(
                                        hint: Text(_data.data()['_suffersOrganicDiseases']==null? '':_data.data()['_suffersOrganicDiseases']),
                                        // Not necessary for Option 1
                                        value: _suffersOrganicDiseases,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _suffersOrganicDiseases = newValue;
                                          });
                                        },
                                        items: ['أمراض مزمنة', "أمراض غير مزمنة"]
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
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Text("هل سبق وأن تم تنويم الحالة في المستشفى", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: DropdownButton(
                                        hint: Text(
                                            _data.data()['_admissionOfHospital']==null? '':_data.data()['_admissionOfHospital']),
                                        // Not necessary for Option 1
                                        value: _admissionOfHospital,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _admissionOfHospital = newValue;
                                          });
                                        },
                                        items: ['نعم', "لا"].map((location) {
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
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text("هل سبق وأجري للحالة أي عمليات جراحية", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: DropdownButton(
                                        hint: Text(
                                            _data.data()['_surgery']==null? '':_data.data()['_surgery']),
                                        // Not necessary for Option 1
                                        value: _surgery,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _surgery = newValue;
                                          });
                                        },
                                        items: ['نعم', "لا"].map((location) {
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
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text("هل هناك أي إصابات أو حدوث حوادث", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: DropdownButton(
                                        hint:
                                            Text(_data.data()['_injuriesOrAccidents']==null? '':_data.data()['_injuriesOrAccidents']),
                                        // Not necessary for Option 1
                                        value: _injuriesOrAccidents,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _injuriesOrAccidents = newValue;
                                          });
                                        },
                                        items: ['نعم', "لا"].map((location) {
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

                              Row(
                                children: [
                                  Text("هل توجد إعاقات في العائلة", style: kTextPageStyle.copyWith(color: Colors.grey)),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: DropdownButton(
                                      hint: Text(_data.data()['_disabilitiesInFamily']==null? '':_data.data()['_disabilitiesInFamily']),
                                      // Not necessary for Option 1
                                      value: _disabilitiesInFamily,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _disabilitiesInFamily = newValue;
                                        });
                                      },
                                      items: ['نعم', "لا"].map((location) {
                                        return DropdownMenuItem(
                                          child: new Text(location),
                                          value: location,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: RaisedButton(
                                  color: kButtonColor,
                                  child: Text("تعديل", style: kTextButtonStyle),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                  onPressed: () async {
                                    _currentUserName =
                                        await gitCurrentUserName();
                                    student
                                        .doc(widget.studentId + 'clinical')
                                        .update({
                                          '_suffersOrganicDiseases':
                                              _suffersOrganicDiseases==null? _data.data()['_suffersOrganicDiseases']:_suffersOrganicDiseases,
                                          '_admissionOfHospital':
                                              _admissionOfHospital==null? _data.data()['_admissionOfHospital']:_admissionOfHospital,
                                          '_surgery': _surgery==null? _data.data()['_surgery']:_surgery,
                                          '_injuriesOrAccidents':
                                              _injuriesOrAccidents==null? _data.data()['_injuriesOrAccidents']:_injuriesOrAccidents,
                                          '_disabilitiesInFamily':
                                              _disabilitiesInFamily==null? _data.data()['_disabilitiesInFamily']:_disabilitiesInFamily,
                                          '_doctorName': _doctorName==null? _data.data()['_doctorName']:_doctorName,
                                          '_hospitalName': _hospitalName==null? _data.data()['_hospitalName']:_hospitalName,
                                          '_doctorPhone': _doctorPhone==null? _data.data()['_doctorPhone']:_doctorPhone,
                                          '_doctorWorkPhone': _doctorWorkPhone==null? _data.data()['_doctorWorkPhone']:_doctorWorkPhone,
                                          '_hospitalPhone': _hospitalPhone==null? _data.data()['_hospitalPhone']:_hospitalPhone,
                                          '_HospitalExtPhone':
                                              _HospitalExtPhone==null? _data.data()['_HospitalExtPhone']:_HospitalExtPhone,
                                          'editBy': _currentUserName,
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
                                  child: Text('اخر تعديل تم بواسطة : ${_data.data()['editBy']==null? 'لا يوجد بيانات': _data.data()['editBy']}',
                                    style: TextStyle(fontSize: 14, color: Colors.black54),
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

//
