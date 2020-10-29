import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'addAppointment.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Timer.dart';




class AllAppointmentsSpecialist extends StatefulWidget {


  const AllAppointmentsSpecialist({Key key}) : super(key: key);
  @override
  _AllAppointmentsSpecialistState createState() => _AllAppointmentsSpecialistState();
}

class _AllAppointmentsSpecialistState extends State<AllAppointmentsSpecialist> with TickerProviderStateMixin{


  CollectionReference specialist= FirebaseFirestore.instance.collection('Specialists')
      .doc(FirebaseAuth.instance.currentUser.email).collection('Appointments');



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

  deleteFromDB({var appointmentId, var teacherId, var sudentId, var day})async{

    await FirebaseFirestore.instance.collection('Specialists')
        .doc(FirebaseAuth.instance.currentUser.email).collection('Appointments')
        .doc(appointmentId).update({day: false}).catchError((error)=> print(error));
    await FirebaseFirestore.instance.collection('Teachers')
        .doc(teacherId).collection('Appointments')
        .doc(appointmentId).update({day: false}).catchError((error)=> print(error));
    await FirebaseFirestore.instance.collection('Students')
        .doc(sudentId).collection('Appointments')
        .doc(appointmentId).update({day: false}).catchError((error)=> print(error));

    bool allDelete = await deleteAll(appointmentId: appointmentId);
    if(allDelete==false) {
      await FirebaseFirestore.instance.collection('Specialists')
          .doc(FirebaseAuth.instance.currentUser.email).collection('Appointments')
          .doc(appointmentId).delete();
      await FirebaseFirestore.instance.collection('Teachers')
          .doc(teacherId).collection('Appointments')
          .doc(appointmentId).delete();
      await FirebaseFirestore.instance.collection('Students')
          .doc(sudentId).collection('Appointments')
          .doc(appointmentId).delete();
    }

  }

  Future<bool> deleteAll({ var appointmentId })async{
    bool sun;bool mon;bool tue;bool wed;bool thu;
    await FirebaseFirestore.instance.collection('Specialists')
        .doc(FirebaseAuth.instance.currentUser.email).collection('Appointments')
        .doc(appointmentId)
        .get().then((doc) {
      sun=doc.data()['sun'];mon=doc.data()['mon']
      ;tue=doc.data()['tue'];wed=doc.data()['wed'];
      thu=doc.data()['thu'];
    });
    if ((sun==false) & (mon==false) &(tue==false) &(wed==false) &(thu==false) )  return false;
    else return true;
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


  int _currentIndex;
  String whatDay(int index){
    String day;
    switch(index) {
      case 0: { setState(() {day= 'sun'; }); }
      break;

      case 1: { setState(() {day= 'mon'; }); }
      break;

      case 2: {setState(() {day= 'tue';});}
      break;

      case 3: {setState(() {day= 'wed';});}
      break;

      case 4: {setState(() {day= 'thu';});}
      break;

      default: {setState(() {day= 'sunday';});}
      break;
    }

    return day;
  }



  @override
  Widget build(BuildContext context) {

    DaysTimer _daysTimer = DaysTimer();
    var studentName='';
    int hour=0;
    int min=0;
    String time='ص';

    bool _isChecked ;

    void _updateIsChecked(String teacherId, String studentId, appointmentId) async{

      //update in teacher
       await FirebaseFirestore.instance.collection('Teachers')
           .doc(teacherId).collection('Appointments').doc(appointmentId)
           .update({'isChecked': _isChecked,})
           .whenComplete(() => print('isChecked updated in teachers'))
           .catchError((e)=> print('### Err: $e ####'));

       //update in specialist
      await FirebaseFirestore.instance.collection('Specialists')
          .doc(FirebaseAuth.instance.currentUser.email)
          .collection('Appointments').doc(appointmentId)
          .update({'isChecked': _isChecked,})
          .whenComplete(() => print('isChecked updated in Specialists'))
          .catchError((e)=> print('### Err: $e ####'));

      //update in student
      await FirebaseFirestore.instance.collection('Students')
          .doc(studentId).collection('Appointments').doc(appointmentId)
          .update({'isChecked': _isChecked,})
          .whenComplete(() => print('isChecked updated in Students'))
          .catchError((e)=> print('### Err: $e ####'));

    }



    return DefaultTabController(
      length: 5,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 25, bottom: 10),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                enableDrag: false,
                isScrollControlled: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                context: context,
                builder: (BuildContext buildContext) => AddAppointment(),
              );
            },
            backgroundColor: kAppBarColor,
          ),
        ),
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
          child:StreamBuilder<QuerySnapshot>(
              stream: specialist.where(whatDay(_currentIndex),isEqualTo: true).snapshots(),
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
                        studentName= document.data()['name'];
                        hour= hourEditor(document.data()['hour']);
                        min=document.data()['min'];
                        time= dayOrNight(hour);
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
                                    child: Checkbox(
                                      activeColor: kUnselectedItemColor,
                                      checkColor: Colors.white70 ,
                                      value: _isChecked,
                                      onChanged: (check)  {

                                        setState(() {
                                          _isChecked = check;
                                          print(_isChecked);
                                        });

                                       _updateIsChecked( document.data()['teacherId'],
                                          document.data()['studentId'],
                                          document.id);

                                        _daysTimer.startTimer(document.data()['teacherId'],
                                            document.data()['studentId'],
                                            FirebaseAuth.instance.currentUser.email,
                                            document.id);

                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(studentName, style: TextStyle(
                                        decoration: _isChecked? TextDecoration.lineThrough : null,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: _isChecked? Colors.black38 : Colors.black54
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('$min : $hour    $time', style: TextStyle(
                                        decoration: _isChecked? TextDecoration.lineThrough : null,
                                        fontSize: 18, fontWeight: FontWeight.bold,
                                        color: _isChecked? Colors.black38 : Colors.black54
                                    ),),
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.delete,color: kUnselectedItemColor,),
                                    onTap: () {
                                      return Alert(
                                          context: context,
                                          type: AlertType.error,
                                          title: " هل أنت مـتأكد من حذف الموعد ؟ ",
                                          desc: "",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "لا",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              onPressed: () => Navigator.pop(context),
                                              color: kButtonColor,
                                            ),
                                            DialogButton(
                                              child: Text(
                                                "نعم",
                                                style: TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              onPressed: () {  deleteFromDB(
                                                  day: whatDay(_currentIndex),
                                                  sudentId:  document.data()['studentId'],
                                                  teacherId: document.data()['teacherId'],
                                                  appointmentId: document.id);
                                              Navigator.pop(context);
                                              },

                                              color: kButtonColor,
                                            ),
                                          ]
                                      ).show();
                                    },
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
              }
              ),
        ),
      ),

    );
  }
}

