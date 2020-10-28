import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ParentAppointments extends StatefulWidget {



  @override
  _ParentAppointmentsState createState() => _ParentAppointmentsState();
}

class _ParentAppointmentsState extends State<ParentAppointments>  with TickerProviderStateMixin{
  @override


  int _currentIndex=0;

  String whatDay(int index){
    String day;
    switch(index) {
      case 0: { print(' inside what day $index'); setState(() {day= 'sun'; }); print(day);}
      break;

      case 1: { print(' inside what day $index');  setState(() {day= 'mon'; }); print(day);}
      break;

      case 2: { print(' inside what day $index');  setState(() {day= 'tue';});print(day);}
      break;

      case 3: {print(' inside what day $index'); setState(() {day= 'wed';});print(day);}
      break;

      case 4: {print(' inside what day $index');  setState(() {day= 'thu';});print(day);}
      break;

      default: {print(' inside what day $index');  setState(() {day= 'sun';});print(day);}
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

  int whatDayIndex(){
    int weekday;
    int index= DateTime.now().weekday;
    switch(index) {
      case 1: { setState(() {weekday=1; }); }
      break;

      case 2: { setState(() {weekday= 2; }); }
      break;

      case 3: {setState(() {weekday=3 ;});}
      break;

      case 4: {setState(() {weekday=4 ;});}
      break;

      case 5: {setState(() {weekday=0 ;});}
      break;

      case 6: {setState(() {weekday=0 ;});}
      break;

      case 7: {setState(() {weekday=0 ;});}
      break;

      default: {setState(() {weekday=0 ;});}
      break;
    }

    return weekday;
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex=whatDayIndex();
      _tabController = TabController(vsync: this, length: 5, initialIndex: whatDayIndex());
    });
  }


  @override
  Widget build(BuildContext context) {

    User user = FirebaseAuth.instance.currentUser;
    CollectionReference teacher= FirebaseFirestore.instance.collection('Students')
        .doc(user.email).collection('Appointments');
    var _studentName='';
    var _specialistName='';
    var _specialistType='';
    int _hour=0;
    int _min=0;
    String _time='ص';
    bool _isChecked;


    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          automaticallyImplyLeading: false,
          toolbarHeight: 48,
          bottom: TabBar(
            controller: _tabController,
            labelColor: kSelectedItemColor,
            indicatorColor: kSelectedItemColor,
            unselectedLabelColor: kUnselectedItemColor,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
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
                        _isChecked= document.data()['isChecked'];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            color: _isChecked? Colors.white24 : Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_studentName, style: TextStyle(
                                        decoration: _isChecked? TextDecoration.lineThrough : null,
                                        fontSize: 18, fontWeight: FontWeight.bold,
                                        color: Colors.black54
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('$_min : $_hour  $_time', style: TextStyle(
                                        decoration: _isChecked? TextDecoration.lineThrough : null,
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
                                            decoration: _isChecked? TextDecoration.lineThrough : null,
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
