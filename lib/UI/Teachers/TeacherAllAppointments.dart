import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';


CollectionReference teacher= FirebaseFirestore.instance.collection('Teachers')
    .doc(FirebaseAuth.instance.currentUser.email).collection('Appointments');
int _currentIndex=0;

class AllAppointmentsTeacher extends StatefulWidget {
  @override
  _AllAppointmentsTeacherState createState() => _AllAppointmentsTeacherState();
}

class _AllAppointmentsTeacherState extends State<AllAppointmentsTeacher> {
  @override



  String whatDay(int index){
    String day;
    switch(index) {
      case 0: { setState(() {day= 'sunday'; print(day);});}
      break;

      case 1: { setState(() {day= 'monday'; print(day);}); }
      break;

      case 2: {setState(() {day= 'tuesday';print(day);});}
      break;

      case 3: {setState(() {day= 'wednesday';print(day);});}
      break;

      case 4: {setState(() {day= 'thursday';print(day);});}
      break;

      default: {setState(() {day= 'sunday';print(day);});}
      break;
    }

    return day;
  }

  Widget whatPage(int index){
    switch(index) {
      case 0: { return SundayStream(); }
      break;

      case 1: { return MondayStream(); }
      break;

      case 2: { return TuesdayStream(); }
      break;

      case 3: { return WednesdayStream(); }
      break;

      case 4: { return ThursdayStream(); }
      break;

      default: { return SundayStream(); }
      break;
    }
  }

  Widget build(BuildContext context) {

    String sDay = 'sunday';

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
                sDay = whatDay(index);
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
          child: whatPage(_currentIndex),
        ),
      ),

    );
  }
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



class SundayStream extends StatelessWidget {
  var _studentName='';
  var _specialistName='';
  var _specialistType='';
  int _hour=0;
  int _min=0;
  String _time='ص';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: teacher.where('sun',isEqualTo: true).snapshots(),
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
        });
  }
}

class MondayStream extends StatelessWidget {
  var _studentName='';
  var _specialistName='';
  var _specialistType='';
  int _hour=0;
  int _min=0;
  String _time='ص';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: teacher.where('mon',isEqualTo: true).snapshots(),
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
        });
  }
}

class TuesdayStream extends StatelessWidget {
  var _studentName='';
  var _specialistName='';
  var _specialistType='';
  int _hour=0;
  int _min=0;
  String _time='ص';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: teacher.where('tue',isEqualTo: true).snapshots(),
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
        });
  }
}

class WednesdayStream extends StatelessWidget {
  var _studentName='';
  var _specialistName='';
  var _specialistType='';
  int _hour=0;
  int _min=0;
  String _time='ص';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: teacher.where('wed',isEqualTo: true).snapshots(),
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
        });
  }
}

class ThursdayStream extends StatelessWidget {
  var _studentName='';
  var _specialistName='';
  var _specialistType='';
  int _hour=0;
  int _min=0;
  String _time='ص';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: teacher.where('thu',isEqualTo: true).snapshots(),
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
        });
  }
}