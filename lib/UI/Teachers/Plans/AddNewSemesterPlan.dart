import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Constance.dart';

class AddNewSemesterPlan extends StatefulWidget {
  final String studentId;
  AddNewSemesterPlan(this.studentId);

  @override
  _AddNewSemesterPlanState createState() => _AddNewSemesterPlanState();}

class _AddNewSemesterPlanState extends State<AddNewSemesterPlan> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedMajorValue ='special';
  String _semesterValue='first';
  var _physiotherapySpecialistId;
  var _psychologySpecialistId;
  var _occupationalSpecialistId;
  var _communicationSpecialistId;

  List<String> subjects=[];

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
  Future <bool> checkTitle1(String newTitle) async {
    bool isExit=false;
  var s1= await FirebaseFirestore.instance.collection('Students')
        .doc(widget.studentId).collection("Plans").where('planTitle',isEqualTo: newTitle).where('semester',isEqualTo: "first").get();
  if (s1.docs.isEmpty==true){
    isExit=true;
  }
//  print(s.docs.isEmpty);
return isExit;
  }
  Future <bool> checkTitle2(String newTitle) async {
    bool isExit=false;
    var s1= await FirebaseFirestore.instance.collection('Students')
        .doc(widget.studentId).collection("Plans").where('planTitle',isEqualTo: newTitle).where('semester',isEqualTo: "second").get();
    if (s1.docs.isEmpty==true){
      isExit=true;
    }
//  print(s.docs.isEmpty);
    return isExit;
  }


  @override
  void initState() {
    super.initState();
    _selectedMajorValue= 'special';
    _semesterValue = 'first';
  }

  @override
  Widget build(BuildContext context) {
    String  _titleSmester1='الخطة الدراسية لعام ${DateTime.now().year.toString()}'+"-"+"${(DateTime.now().year+1).toString()}";
    String _titleSmester2= 'الخطة الدراسية لعام ${(DateTime.now().year-1).toString()}'+"-"+"${DateTime.now().year.toString()}";


    int _beginYear= DateTime.now().year;
    int _beginMonth=DateTime.now().month;
    int _beginDay=DateTime.now().day;
    int _endYear=DateTime.now().year;
    int _endMonth=DateTime.now().month;
    int _endDay=DateTime.now().day;

    User _teacherUser = FirebaseAuth.instance.currentUser;
    TextEditingController subjectController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('إضافة خطة جديدة', style: TextStyle(color: kUnselectedItemColor),),
          backgroundColor: kAppBarColor,
          elevation: 10,
          centerTitle: true,
          automaticallyImplyLeading: true,
          toolbarHeight: 40,
        ),
        body: Container(
          color: kBackgroundPageColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Padding(padding: EdgeInsets.all(8)),
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
                        width: 200,
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
                        width: 200,
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
             Padding(padding: EdgeInsets.all(10),
               child:  Text('تحتوي هذه الخطة على أقسام المجالات الخاصة وهي : مجال التواصل، المجال الإدراكي، المجال الحركي الدقيق، '
                   'المجال الاجتماعي، والمجال الاستقلالي'),
             ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: RaisedButton(
                    color: kButtonColor,
                    child: Text("إضافة", style: kTextButtonStyle),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () async {
                       subjects =  subjectController.text==null? []: subjectController.text.split(
                          ',');
                      print(subjects);
                      Random ran = Random();
                       String titlePlan= _semesterValue == 'first'? _titleSmester1:_titleSmester2;
                       String semester= _semesterValue == 'first'? "الفصل الدراسي الأول":"الفصل الدراسي الثاني";
                      String docId= widget.studentId+DateTime.now().year.toString()+_semesterValue+ran.nextInt(10000000).toString();
                      bool checkT= _semesterValue == 'first'? await  checkTitle1( titlePlan): await checkTitle2( titlePlan);
                       bool isDone = await setUIds();
                      if (checkT==true) {
                        //Add to data base
                        await FirebaseFirestore.instance.collection('Students')
                            .doc(widget.studentId).collection('Plans')
                            .doc(docId).set({
                          'planId':docId,
                          'planTitle':   _semesterValue == 'first'? _titleSmester1:_titleSmester2,
                          'major': _selectedMajorValue,
                          'semester': _semesterValue,
                          'beginYear': _beginYear,
                          'beginMonth': _beginMonth,
                          'beginDay': _beginDay,
                          'endYear': _endYear,
                          'endMoth': _endMonth,
                          'endDay': _endDay,
                          'subjects': subjects,
                          'createdAt':Timestamp.now(),
                          'psychologySpecialistId':_psychologySpecialistId != null?_psychologySpecialistId:null,
                          'occupationalSpecialistId':_occupationalSpecialistId != null?_occupationalSpecialistId:null,
                          'communicationSpecialistId':_communicationSpecialistId != null?_communicationSpecialistId:null,
                          'physiotherapySpecialistId':_physiotherapySpecialistId != null?_physiotherapySpecialistId :null,
                        });
                        Navigator.pop(context);}
                      else{
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(" لقد تم إضافة $titlePlan $semester ",style: TextStyle(color: Colors.deepPurple,fontSize: 12)),
                 backgroundColor: Colors.white70,
                 duration: Duration(seconds: 3),
                      ));}
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
