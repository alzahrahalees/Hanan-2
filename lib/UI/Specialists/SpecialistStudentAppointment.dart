import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Specialists/student.dart';
import '../Constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class AppointmentsSpecialist extends StatefulWidget {

  final String studentId;

  AppointmentsSpecialist({this.studentId});

  @override
  _AppointmentsSpecialistState createState() => _AppointmentsSpecialistState();
}
int _currentIndex=0;
class _AppointmentsSpecialistState extends State<AppointmentsSpecialist> {


  String sDay = 'sunday';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }

  String whatDay(int index){
    String day;
    switch(index) {
      case 0: { setState(() {day= 'sunday'; });}
      break;

      case 1: { setState(() {day= 'monday'; }); }
      break;

      case 2: {setState(() {day= 'tuesday';});}
      break;

      case 3: {setState(() {day= 'wednesday';});}
      break;

      case 4: {setState(() {day= 'thursday';});}
      break;

      default: {setState(() {day= 'sunday';});}
      break;
    }

    return day;
  }

  Widget whatPage(int index){
    switch(index) {
      case 0: { return SundayStream(widget.studentId); }
      break;

      case 1: { return MondayStream(widget.studentId); }
      break;

      case 2: { return TuesdayStream(widget.studentId); }
      break;

      case 3: { return WednesdayStream(widget.studentId); }
      break;

      case 4: { return ThursdayStream(widget.studentId); }
      break;

      default: { return SundayStream(widget.studentId); }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {


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

User user = FirebaseAuth.instance.currentUser;


class SundayStream extends StatelessWidget {

  final String _studentId;

  SundayStream(this._studentId);

  var _studentName='';
  int _hour=0;
  int _min=0;
  String _time='ص';


  @override
  Widget build(BuildContext context) {


    CollectionReference student=FirebaseFirestore.instance.collection('Students')
        .doc(_studentId).collection('Appointments');


    return StreamBuilder<QuerySnapshot>(
        stream: student.where('sun',isEqualTo: true).where('specialistId',isEqualTo: user.email).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child:Text('لا يوجد أي مواعيد هنا',style: TextStyle(fontSize: 18, color: Colors.black38),),);
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

  final String _studentId;

  MondayStream(this._studentId);

  var _studentName='';
  int _hour=0;
  int _min=0;
  String _time='ص';

  @override
  Widget build(BuildContext context) {



    CollectionReference student=FirebaseFirestore.instance.collection('Students')
        .doc(_studentId).collection('Appointments');


    return StreamBuilder<QuerySnapshot>(
        stream: student.where('mon',isEqualTo: true).where('specialistId',isEqualTo: user.email).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child:Text('لا يوجد أي مواعيد هنا',style: TextStyle(fontSize: 18, color: Colors.black38),),);
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

  final String _studentId;

  TuesdayStream(this._studentId);

  var _studentName='';
  int _hour=0;
  int _min=0;
  String _time='ص';

  @override
  Widget build(BuildContext context) {



    CollectionReference student=FirebaseFirestore.instance.collection('Students')
        .doc(_studentId).collection('Appointments');

    return StreamBuilder<QuerySnapshot>(
        stream: student.where('tue',isEqualTo: true).where('specialistId',isEqualTo: user.email).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child:Text('لا يوجد أي مواعيد هنا',style: TextStyle(fontSize: 18, color: Colors.black38),),);
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

  final String _studentId;

  WednesdayStream(this._studentId);

  var _studentName='';
  int _hour=0;
  int _min=0;
  String _time='ص';

  @override
  Widget build(BuildContext context) {

    CollectionReference student=FirebaseFirestore.instance.collection('Students')
        .doc(_studentId).collection('Appointments');


    return StreamBuilder<QuerySnapshot>(
        stream: student.where('wed',isEqualTo: true).where('specialistId',isEqualTo: user.email).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child:Text('لا يوجد أي مواعيد هنا',style: TextStyle(fontSize: 18, color: Colors.black38),),);
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

  final String _studentId;

  ThursdayStream(this._studentId);

  var _studentName='';
  int _hour=0;
  int _min=0;
  String _time='ص';


  @override
  Widget build(BuildContext context) {

    CollectionReference student=FirebaseFirestore.instance.collection('Students')
        .doc(_studentId).collection('Appointments');

    return StreamBuilder<QuerySnapshot>(
        stream: student.where('thu',isEqualTo: true).where('specialistId',isEqualTo: user.email).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child:Text('لا يوجد أي مواعيد هنا',style: TextStyle(fontSize: 18, color: Colors.black38),),);
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
                  _hour= hourEditor(document.data()['hour']);
                  _min=document.data()['min'];
                  _time= dayOrNight(document.data()['hour']);

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
