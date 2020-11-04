import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Constance.dart';



class AddNewSemesterPlan extends StatefulWidget {
  final String studentId;

  AddNewSemesterPlan(this.studentId);

  @override
  _AddNewSemesterPlanState createState() => _AddNewSemesterPlanState();
}

class _AddNewSemesterPlanState extends State<AddNewSemesterPlan> {

  String _selectedMajorValue ='special';
  String _semesterValue='first';

  var _physiotherapySpecialistId;
  var _psychologySpecialistId;
  var _occupationalSpecialistId;
  var _communicationSpecialistId;


  // String specialistId

  onMajorChange (value){
    setState(() {
      _selectedMajorValue=value;
    });
  }

  onSemesterChange (value){
    setState(() {
      _semesterValue=value;
    });
  }



  Future<bool> setUIds() async {
    bool isDone= false;
    await FirebaseFirestore.instance.collection('Students')
        .doc(widget.studentId).get().then((data){
      _physiotherapySpecialistId= data.data()['physiotherapySpecialistId'];
      _psychologySpecialistId= data.data()['psychologySpecialistId'];
      _occupationalSpecialistId= data.data()['occupationalSpecialistId'];
      _communicationSpecialistId= data.data()['communicationSpecialistId'];
    }).whenComplete(() => isDone=true);
    return isDone;
  }


  @override
  void initState() {
    super.initState();
    _selectedMajorValue= 'special';
    _semesterValue = 'first';
  }

  // snackBarErr(){
  //   Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //           backgroundColor: Colors.red[200],
  //           content: Text(
  //             'يوجد خطأ الرجاء المحاولة في وقت لاحق',
  //             style: TextStyle(color: Colors.deepPurple, fontSize: 12),
  //           )
  //       ));
  // }
  //
  // snackBarDone(){
  //   Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //           backgroundColor: Colors.white70,
  //           content: Text(
  //             'تم إضافة الخطة',
  //             style: TextStyle(color: Colors.deepPurple, fontSize: 12),
  //           )
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    String _title='الخطة الدراسية لعام ${DateTime.now().year.toString()}';
    int _beginYear= DateTime.now().year;
    int _beginMonth=DateTime.now().month;
    int _beginDay=DateTime.now().day;
    int _endYear=DateTime.now().year;
    int _endMonth=DateTime.now().month;
    int _endDay=DateTime.now().day;

    User _user = FirebaseAuth.instance.currentUser;
    TextEditingController subjectController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('إضافة خطة جديدة', style: TextStyle(color: kUnselectedItemColor),),
          backgroundColor: kAppBarColor,
          elevation: 10,
          centerTitle: true,
          automaticallyImplyLeading: true,
          toolbarHeight: 40,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            color: kBackgroundPageColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: KNormalTextFormField(
                      title: _title,
                      hintText: 'عنوان الخطة' ,
                      onChanged: (value){
                        setState(() {
                          _title=value;
                        });
                      },
                      validatorText: '#مطلوب',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                        "الفصل الدراسي : ",
                        textAlign: TextAlign.start,
                        style: kTextPageStyle.copyWith(color: Colors.grey)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: RadioListTile(
                      selected: false,
                      toggleable: true,
                      title: Text('الأول'),
                      activeColor:  kSelectedItemColor,
                      value: 'first' ,
                      groupValue: _semesterValue,
                      onChanged: (value){

                        onSemesterChange(value);

                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: RadioListTile(
                      toggleable: true,
                      title: Text('الثاني'),
                      activeColor:  kSelectedItemColor,
                      value: 'second',
                      groupValue: _semesterValue,
                      onChanged: (value){
                        onSemesterChange(value);
                      },
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.all(15),
                      child:
                      Row(children: <Widget>[
                        Text("تاريخ البداية", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(10)),
                        SizedBox(
                          height: 30,
                          width: 250,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (dateTime) {
                              setState(() {
                                _beginYear = dateTime.year;
                                _beginMonth = dateTime.month;
                                _beginDay = dateTime.day;
                              });
                            },
                          ),
                        )
                      ])
                  ),

                  Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                      Row(children: <Widget>[
                        Text("تاريخ النهاية", style: kTextPageStyle.copyWith(color: Colors.grey)),
                        new Padding(padding: new EdgeInsets.all(10)),
                        SizedBox(
                          height: 30,
                          width: 250,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (dateTime) {
                              setState(() {
                                _endYear = dateTime.year;
                                _endMonth = dateTime.month;
                                _endDay= dateTime.day;
                              });
                            },
                          ),
                        )
                      ])
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "مجالات الخطة: ",
                      textAlign: TextAlign.start,
                      style: kTextPageStyle.copyWith(color: Colors.grey)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: RadioListTile(
                      selected: false,
                      toggleable: true,
                      title: Text('المجالات الخاصة'),
                      activeColor:  kSelectedItemColor,
                      subtitle: Text('يحتوي هذا المجال على أقسام المجالات الخاصة وهي : مجال التواصل، المجال الإدراكي، المجال الحركي الدقيق، '
                          'المجال الاجتماعي، والمجال الاستقلالي'),
                      value: 'special' ,
                      groupValue: _selectedMajorValue,
                      onChanged: (value){

                        onMajorChange(value);

                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: RadioListTile(
                      toggleable: true,
                      title: Text('المواد العامة'),
                      activeColor:  kSelectedItemColor,
                      subtitle: Text('يحتوي هذا المجال على أقسام المواد العامة مثل : القرآن والحديث وغيرها من المواد العامة '),
                      value: 'general',
                      groupValue: _selectedMajorValue,
                      onChanged: (value){
                        onMajorChange(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("في حال اختيارك المجالات المواد العامة، الرجاء إدخال المواد متبوعة بفاصلة، مثل: القرآن، الحديث، العلوم", style: kTextPageStyle.copyWith(color: Colors.black54)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: KNormalTextFormField(
                      readOnly:_selectedMajorValue== 'general'? false: true,
                      hintText: 'الرجاء إدخال المواد هنا',
                      controller: subjectController,
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
                        List<String> subjects = subjectController.text.split(
                            ',');
                        print(subjects);

                        String docId= widget.studentId+DateTime.now().year.toString()+_semesterValue;
                        bool isDone = await setUIds();
                        if (isDone) {

                          //Add to data base

                          if(_occupationalSpecialistId != null)
                          await FirebaseFirestore.instance.collection('Specialists')
                              .doc(_occupationalSpecialistId).collection('Students')
                              .doc(widget.studentId).collection('Plans')
                              .doc(docId).set({
                            'planTitle': _title,
                            'major': _selectedMajorValue,
                            'semester': _semesterValue,
                            'beginYear': _beginYear,
                            'beginMonth': _beginMonth,
                            'beginDay': _beginDay,
                            'endYear': _endYear,
                            'endMoth': _endMonth,
                            'endDay': _endDay,
                            'subjects': subjects,
                          });
                          if(_communicationSpecialistId != null)
                            await FirebaseFirestore.instance.collection('Specialists')
                                .doc(_communicationSpecialistId).collection('Students')
                                .doc(widget.studentId).collection('Plans')
                                .doc(docId).set({
                              'planTitle': _title,
                              'major': _selectedMajorValue,
                              'semester': _semesterValue,
                              'beginYear': _beginYear,
                              'beginMonth': _beginMonth,
                              'beginDay': _beginDay,
                              'endYear': _endYear,
                              'endMoth': _endMonth,
                              'endDay': _endDay,
                              'subjects': subjects,
                            });
                          if(_physiotherapySpecialistId != null)
                            await FirebaseFirestore.instance.collection('Specialists')
                                .doc(_physiotherapySpecialistId).collection('Students')
                                .doc(widget.studentId).collection('Plans')
                                .doc(docId).set({
                              'planTitle': _title,
                              'major': _selectedMajorValue,
                              'semester': _semesterValue,
                              'beginYear': _beginYear,
                              'beginMonth': _beginMonth,
                              'beginDay': _beginDay,
                              'endYear': _endYear,
                              'endMoth': _endMonth,
                              'endDay': _endDay,
                              'subjects': subjects,
                            });
                          if(_psychologySpecialistId != null)
                            await FirebaseFirestore.instance.collection('Specialists')
                                .doc(_psychologySpecialistId).collection('Students')
                                .doc(widget.studentId).collection('Plans')
                                .doc(docId).set({
                              'planTitle': _title,
                              'major': _selectedMajorValue,
                              'semester': _semesterValue,
                              'beginYear': _beginYear,
                              'beginMonth': _beginMonth,
                              'beginDay': _beginDay,
                              'endYear': _endYear,
                              'endMoth': _endMonth,
                              'endDay': _endDay,
                              'subjects': subjects,
                            });

                          await FirebaseFirestore.instance.collection('Students')
                              .doc(widget.studentId).collection('Plans')
                              .doc(docId).set({
                            'planTitle': _title,
                            'major': _selectedMajorValue,
                            'semester': _semesterValue,
                            'beginYear': _beginYear,
                            'beginMonth': _beginMonth,
                            'beginDay': _beginDay,
                            'endYear': _endYear,
                            'endMoth': _endMonth,
                            'endDay': _endDay,
                            'subjects': subjects,
                          });

                          await FirebaseFirestore.instance.collection('Teachers')
                              .doc(_user.email).collection('Students')
                              .doc(widget.studentId).collection('Plans')
                              .doc(docId).set({
                            'planTitle': _title,
                            'major': _selectedMajorValue,
                            'semester': _semesterValue,
                            'beginYear': _beginYear,
                            'beginMonth': _beginMonth,
                            'beginDay': _beginDay,
                            'endYear': _endYear,
                            'endMoth': _endMonth,
                            'endDay': _endDay,
                            'subjects': subjects,
                          }).whenComplete(() => Navigator.pop(context))
                              .catchError((err) => print(err));

                        }
                      }

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
