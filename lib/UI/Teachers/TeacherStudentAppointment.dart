import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';


int _currentIndex=0;

class AppointmentsTeacher extends StatefulWidget {

  final String studentId;

  AppointmentsTeacher(this.studentId);

  @override
  _AppointmentsTeacherState createState() => _AppointmentsTeacherState();
}

class _AppointmentsTeacherState extends State<AppointmentsTeacher> {
  @override




  String whatDay(int index){
    String day;
    switch(index) {
      case 0: { setState(() {day= 'sun'; print(day);});}
      break;

      case 1: { setState(() {day= 'mon'; print(day);}); }
      break;

      case 2: {setState(() {day= 'tue';print(day);});}
      break;

      case 3: {setState(() {day= 'wed';print(day);});}
      break;

      case 4: {setState(() {day= 'thu';print(day);});}
      break;

      default: {setState(() {day= 'sun';print(day);});}
      break;
    }

    return day;
  }


  int hourEditor(int hour){
    int newHour;
    if(hour!= null){
      if(hour>12) newHour= hour-12;
      else newHour = hour;
      return newHour;
    }
    else return 0;
  }

  String dayOrNight(int hour){
    String time;
    if(hour!= null) {
      if(hour>=12) time='م';
      else time = 'ص';
      return time;
    }
    else return 'ص';
  }



  Widget build(BuildContext context) {


    var _studentName='';
    var _specialistName='';
    var _specialistType='';
    int _hour=0;
    int _min=0;
    String _time='ص';


    CollectionReference teacher= FirebaseFirestore.instance.collection('Students')
        .doc(widget.studentId).collection('Appointments');


    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          automaticallyImplyLeading: false,
          toolbarHeight: 48,
          bottom: TabBar(
            labelColor: kSelectedItemColor,
            indicatorColor: kSelectedItemColor,
            unselectedLabelColor: kUnselectedItemColor,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                print(_currentIndex);
              });
            },
            tabs: [
              Tab(text: 'الأحد'),
              Tab(text: 'الأثنين'),
              Tab(text: 'الثلاثاء'),
              Tab(text: 'الأربعاء'),
              Tab(text: 'الخميس'),
            ],
          ),
        ),

        body: Container(
          color: kBackgroundPageColor,
          child: StreamBuilder<QuerySnapshot>(
              stream: teacher.where(whatDay(_currentIndex),isEqualTo: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: SpinKitFoldingCube(
                    color: kUnselectedItemColor, size: 60,),);
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: SpinKitFoldingCube(
                      color: kUnselectedItemColor,
                      size: 60,
                    )
                      ,);
                  default:
                    return ListView(
                      children: snapshot.data.docs.map((DocumentSnapshot document){
                        _studentName= document.data()['name'];
                        _specialistName= document.data()['specialistName'];
                        _specialistType= document.data()['specialistType'];
                        _hour= hourEditor(document.data()['hour']);
                        _min=document.data()['min'];
                        _time= dayOrNight(_hour);
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_studentName, style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold,
                                        color: Colors.black54
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('$_min : $_hour    $_time', style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold,
                                        color: Colors.black54
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(_specialistName,style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_specialistType,style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w100,
                                              color: Colors.black54
                                          ),),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      ).toList(),
                    );
                }
              }),
        ),
      ),

    );
  }
}

