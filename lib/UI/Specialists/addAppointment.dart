import 'package:flutter/material.dart';
import 'package:weekday_selector_formfield/weekday_selector_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Constance.dart';
import 'dart:math';

class AddAppointment extends StatefulWidget {
  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {


  User user = FirebaseAuth.instance.currentUser;
  bool _sun= false;
  bool _mon= false;
  bool _tue= false;
  bool _wed= false;
  bool _thu= false;

  String _studentName;
  String _studentId = '';
  String _teacherId;
  String _specialistName;
  String _specialistType;
  String _centerId;
  int _hour=DateTime.now().hour;
  int _min= DateTime.now().minute;
  Color _color= Colors.black54;
  String warningText = '';


  //function for days picker
  _onChangeDays(daysList) {
    setState(() {
      _sun= daysList.contains(days.sunday);
      _mon=daysList.contains(days.monday);
      _tue=daysList.contains(days.tuesday);
      _wed=daysList.contains(days.wednesday);
      _thu=daysList.contains(days.thursday);
    });
  }

  // to get the teacher Id from the student
  Future<String> _teacherUID(String uid) async{
    String teacherId;
    await FirebaseFirestore.instance.collection('Students')
        .doc(uid).get()
        .then((doc)  {
      teacherId= doc.data()['teacherId'];
      print('insid get function : $teacherId');
    });
    return teacherId;

  }
  Future<String> _getSpecialistName() async{
    String name;
    await FirebaseFirestore.instance.collection('Specialists')
        .doc(user.email).get()
        .then((doc)  {
      name= doc.data()['name'];

    });
    return name;

  }
  Future<String> _getSpecialistType() async{
    String type;
    await FirebaseFirestore.instance.collection('Specialists')
        .doc(user.email).get()
        .then((doc)  {
      type= doc.data()['typeOfSpechalist'];
      print('insid get function : $type');
    });
    return type;

  }
  Future<String> _getCenterID() async{
    String centerId;
    await FirebaseFirestore.instance.collection('Specialists')
        .doc(user.email).get()
        .then((doc)  {
      centerId= doc.data()['center'];
      print('insid get center Id function : $centerId');
    });
    return centerId;

  }

  //add the appointment to DB
  _addToDB(String teacherId, String specialistName, String specialistType, String _centerId){
    Random ran=Random();
    int num=ran.nextInt(100000000);
    String docId= _studentId+num.toString();


    //add to Specialists
    FirebaseFirestore.instance.collection('Specialists')
        .doc(user.email).collection('Appointments').doc(docId).set({
      'name': _studentName,
      'studentId': _studentId,
      'specialistId': user.email,
      'teacherId': teacherId,
      'specialistName':specialistName,
      'specialistType':specialistType,
      'hour': _hour,
      'min':_min,
      'sun': _sun,
      'mon': _mon,
      'tue': _tue,
      'wed': _wed,
      'thu': _thu,
      'sunIsChecked': false,
      'monIsChecked': false,
      'tueIsChecked': false,
      'wedIsChecked': false,
      'thuIsChecked': false,
    }).whenComplete(() => print('appointment added to specialist'))
        .catchError((err)=> print('### Err : $err ###'));

    //add to Students
    FirebaseFirestore.instance.collection('Students')
        .doc(_studentId).collection('Appointments').doc(docId).set({
      'name': _studentName,
      'studentId': _studentId,
      'specialistId': user.email,
      'teacherId': teacherId,
      'specialistName':specialistName,
      'specialistType':specialistType,
      'hour': _hour,
      'min':_min,
      'sun': _sun,
      'mon': _mon,
      'tue': _tue,
      'wed': _wed,
      'thu': _thu,
      'sunIsChecked': false,
      'monIsChecked': false,
      'tueIsChecked': false,
      'wedIsChecked': false,
      'thuIsChecked': false,
    }).whenComplete(() => print('appointment added to student'))
        .catchError((err)=> print('### Err : $err ###'));

    //add to Teachers
    FirebaseFirestore.instance.collection('Teachers')
        .doc(teacherId).collection('Appointments').doc(docId).set({
      'name': _studentName,
      'studentId': _studentId,
      'specialistId': user.email,
      'teacherId': teacherId,
      'specialistName':specialistName,
      'specialistType':specialistType,
      'hour': _hour,
      'min':_min,
      'sun': _sun,
      'mon': _mon,
      'tue': _tue,
      'wed': _wed,
      'thu': _thu,
      'sunIsChecked': false,
      'monIsChecked': false,
      'tueIsChecked': false,
      'wedIsChecked': false,
      'thuIsChecked': false,
    }).whenComplete(() {print('appointment added to teacher');
    })
        .catchError((err)=> print('### Err : $err ###'));

    // add To Student In Center
    FirebaseFirestore.instance.collection('Centers')
        .doc(_centerId).collection('Students')
        .doc(_studentId).collection('Appointments').doc(docId).set({
      'name': _studentName,
      'studentId': _studentId,
      'specialistId': user.email,
      'teacherId': teacherId,
      'specialistName':specialistName,
      'specialistType':specialistType,
      'hour': _hour,
      'min':_min,
      'sun': _sun,
      'mon': _mon,
      'tue': _tue,
      'wed': _wed,
      'thu': _thu,
      'sunIsChecked': false,
      'monIsChecked': false,
      'tueIsChecked': false,
      'wedIsChecked': false,
      'thuIsChecked': false,
    }).whenComplete(() => print('appointment added to teacher'))
        .catchError((err)=> print('### Err : $err ###'));

  }


  // call all functions



  @override
  Widget build(BuildContext context) {
    List<String> _theDays=[];


    _addAppointment()async{
      _teacherId = await _teacherUID(_studentId);
      _specialistName= await _getSpecialistName();
      _specialistType= await _getSpecialistType();
      _centerId = await _getCenterID();
      _addToDB(_teacherId,_specialistName,_specialistType,_centerId);
      print('Before:  $_theDays');
      _theDays=[];
      print(_theDays);
      Navigator.pop(context);

    }
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: kAppBarColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text('إضافة موعد جديد', style: kTextPageStyle.copyWith(fontSize:16,color: kUnselectedItemColor),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' اسم الطالبـ/ـة:',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 16, color:_color),
                        ),
                      ),
                      SizedBox(width: 50,),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('Specialists')
                              .doc(user.email).collection('Students').snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){

                            if(snapshot.hasData){
                              Center(child: const CupertinoActivityIndicator());
                              return DropdownButton<String>(
                                value:_studentName ,
                                onChanged: (value){
                                  setState(() {
                                    _studentName=value;
                                    print(_studentName);
                                  });
                                },
                                isDense: true,
                                hint: Text('إختر'),
                                items: snapshot.data.docs.map((DocumentSnapshot document){
                                  return DropdownMenuItem<String>(
                                    value: document.data()["name"],
                                    child: new Container(
                                        height: 25,
                                        child:Text(
                                          document.data()["name"],)),
                                    onTap: (){
                                      _studentId=document.data()["uid"];
                                    },
                                  );
                                }).toList(),
                              );
                            }
                            else{
                              return Text('');
                            }
                          }
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'الوقت:',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16,color: _color),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                  width: 250,
                  child: CupertinoDatePicker(
                    initialDateTime:DateTime.now(),
                    use24hFormat: false ,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (dateTime) {
                      setState(() {
                        _hour=dateTime.hour;
                        _min=dateTime.minute;
                        print('hour: $_hour, min: $_min');
                      });
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'الأيام:',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16,color:_color ),
                      ),
                    ),
                  ],
                ),
                WeekDaySelectorFormField(
                  displayDays: [days.sunday, days.monday,days.tuesday, days.wednesday,days.thursday],
                  borderRadius: 20,
                  fillColor: kWolcomeBkg,
                  selectedFillColor: kUnselectedItemColor,
                  borderSide: BorderSide(color: kUnselectedItemColor, width: 2),
                    language: lang.ar,
                  onChange: _onChangeDays,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    color: kUnselectedItemColor,
                    child: Text("إضافة موعد", style: kTextButtonStyle),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    onPressed: () async{
                      if(_sun){_theDays.add('sunday');}
                      if(_mon){_theDays.add('monday');}
                      if(_tue){_theDays.add('tuesday');}
                      if(_wed){_theDays.add('wednesday');}
                      if(_thu){_theDays.add('thursday');}

                      if(_studentName==null)  {
                        setState(() {
                          warningText='الرجاء اختيار اسم';
                          // print(_theDays);
                        });
                      }
                      else if (_theDays.isEmpty){

                        setState(() {
                          warningText='الرجاء اختيار الأيام';});
                      }
                      else{
                        _addAppointment();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(warningText, style: TextStyle(color: Colors.red), textAlign: TextAlign.center,),
                )
              ],
            )
        ),
      ),
    );
  }


}
