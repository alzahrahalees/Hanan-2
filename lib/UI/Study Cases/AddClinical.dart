import 'package:flutter/material.dart';
import '../Constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddClinical extends StatefulWidget {
  final String studentId;
  AddClinical(this.studentId);
  @override
  _AddClinicalState createState() => _AddClinicalState();
}

class _AddClinicalState extends State<AddClinical> {

  User user = FirebaseAuth.instance.currentUser;
  String _suffersOrganicDiseases;
  String _admissionOfHospital;
  String _surgery;
  String _injuriesOrAccidents;
  String _disabilitiesInFamily;
  String _doctorName;
  String _hospitalName ;
  String _doctorPhone ;
  String _doctorWorkPhone ;
  String _hospitalPhone ;
  String _HospitalExtPhone;
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
              title: Text(" معلومات التاريخ الطبي للطالب ", style: kTextAppBarStyle),
              centerTitle: true,
              backgroundColor: kAppBarColor,
            ),
            body: Container(
                padding: EdgeInsets.all(10),
                color: kBackgroundPageColor,
                alignment: Alignment.topCenter,
                child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[new Column(children: <Widget>[
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
                          hintText: 'اسم الطبيب',
                          onChanged: (value){
                            _doctorName=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KNormalTextFormField(
                          hintText: 'اسم المستشفى-العيادة',
                          onChanged: (value){
                            _hospitalName=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KNormalTextFormField(
                          hintText: 'هاتف الطبيب',
                          onChanged: (value){
                            _doctorPhone=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KNormalTextFormField(
                          hintText: 'هاتف العمل',
                          onChanged: (value){
                            _doctorWorkPhone=value;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KNormalTextFormField(
                          hintText: "هاتف المستشفى",
                          onChanged: (value){
                            _hospitalPhone=value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: KNormalTextFormField(
                          hintText: "تحويلة",
                          onChanged: (value){
                            _HospitalExtPhone=value;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment(1, 0),
                          child: DropdownButton(
                            hint: Text( "أمراض عضوية يعاني منها"),
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
                      ),
                       Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment(1, 0),
                          child: DropdownButton(
                            hint: Text(  "هل سبق وأن تم تنويم الحالة في المستشفى"),
                            // Not necessary for Option 1
                            value: _admissionOfHospital,
                            onChanged: (newValue) {
                              setState(() {
                                _admissionOfHospital = newValue;
                              });
                            },
                            items: ['نعم', "لا"]
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
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment(1, 0),
                          child: DropdownButton(
                            hint: Text( "هل سبق وأجري للحالة أي عمليات جراحية"),
                            // Not necessary for Option 1
                            value: _surgery,
                            onChanged: (newValue) {
                              setState(() {
                                _surgery = newValue;
                              });
                            },
                            items: ['نعم', "لا"]
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
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment(1, 0),
                          child: DropdownButton(
                            hint: Text( "هل هناك أي إصابات أو حدوث حوادث"),
                            // Not necessary for Option 1
                            value: _injuriesOrAccidents,
                            onChanged: (newValue) {
                              setState(() {
                                _injuriesOrAccidents = newValue;
                              });
                            },
                            items: ['نعم', "لا"]
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
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment(1, 0),
                          child: DropdownButton(
                            hint: Text( "هل توجد إعاقات في العائلة"),
                            // Not necessary for Option 1
                            value: _disabilitiesInFamily,
                            onChanged: (newValue) {
                              setState(() {
                                _disabilitiesInFamily = newValue;
                              });
                            },
                            items: ['نعم', "لا"]
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
                                .doc(widget.studentId +'clinical')
                                .set({
                             '_suffersOrganicDiseases': _suffersOrganicDiseases,
                             '_admissionOfHospital':_admissionOfHospital,
                             '_surgery':_surgery,
                             '_injuriesOrAccidents':_injuriesOrAccidents,
                             '_disabilitiesInFamily':_disabilitiesInFamily,
                             '_doctorName':_doctorName,
                             '_hospitalName' :_hospitalName,
                             '_doctorPhone' :_doctorPhone,
                             '_doctorWorkPhone':_doctorWorkPhone,
                             '_hospitalPhone':_hospitalPhone,
                             '_HospitalExtPhone':_HospitalExtPhone ,
                             'editBy' :_currentUserName,
                            })
                                .whenComplete(()  {Navigator.pop(context);
                            Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.white70,
                                    content: Text(
                                      'تم إضافة المعلومات',
                                      style: TextStyle(color: Colors.deepPurple, fontSize: 12),
                                    )
                                ));
                                })
                                .catchError((err)  {print(err);
                                Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.red[200],
                                    content: Text(
                                      'يوجد خطأ الرجاء المحاولة في وقت لاحق',
                                      style: TextStyle(color: Colors.deepPurple, fontSize: 12),
                                    )
                                ));});
                          },
                        ),
                      ),

                    ]
                    )
                    ]
                )
            )
        )
    );
  }
}

//
