import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'addAppointment.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


CollectionReference specialist= FirebaseFirestore.instance.collection('Specialists')
    .doc(FirebaseAuth.instance.currentUser.email).collection('Appointments');
int _currentIndex=0;

class AllAppointmentsSpecialist extends StatefulWidget {
  @override
  _AllAppointmentsSpecialistState createState() => _AllAppointmentsSpecialistState();
}

class _AllAppointmentsSpecialistState extends State<AllAppointmentsSpecialist> {
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



class SundayStream extends StatelessWidget {
  var studentName='';
  int hour=0;
  int min=0;
  String time='ص';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: specialist.where('sun',isEqualTo: true).snapshots(),
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
                              child: Text(studentName, style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$min : $hour    $time', style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  color: Colors.black54
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
                                          day: 'sun',
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
        });
  }
}

class MondayStream extends StatelessWidget {
  var studentName='';
  int hour=0;
  int min=0;
  String time='ص';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: specialist.where('mon',isEqualTo: true).snapshots(),
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
                              child: Text(studentName, style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$min : $hour    $time', style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),),
                            ),
                            GestureDetector(
                              child: Icon(Icons.delete,color: kUnselectedItemColor),
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
                                        onPressed: () {
                                          deleteFromDB(
                                          day: 'mon',
                                          sudentId:  document.data()['studentId'],
                                          teacherId: document.data()['teacherId'],
                                          appointmentId: document.id,
                                        );
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
        });
  }
}

class TuesdayStream extends StatelessWidget {
  var studentName='';
  int hour=0;
  int min=0;
  String time='ص';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: specialist.where('tue',isEqualTo: true).snapshots(),
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
                              child: Text(studentName, style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold,
                                color: Colors.black54
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$min : $hour    $time', style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),),
                            ),
                            GestureDetector(
                              child: Icon(Icons.delete, color: kUnselectedItemColor),
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
                                        onPressed: ()   {
                                          deleteFromDB(
                                          day: 'tue',
                                          sudentId:  document.data()['studentId'],
                                          teacherId: document.data()['teacherId'],
                                          appointmentId: document.id,
                                        );
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
        });
  }
}

class WednesdayStream extends StatelessWidget {
  var studentName='';
  int hour=0;
  int min=0;
  String time='ص';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: specialist.where('wed',isEqualTo: true).snapshots(),
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
                              child: Text(studentName, style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$min : $hour    $time', style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),),
                            ),
                            GestureDetector(
                              child: Icon(Icons.delete,color: kUnselectedItemColor),
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
                                        onPressed: ()  {
                                          deleteFromDB(
                                          day: 'wed',
                                          sudentId:  document.data()['studentId'],
                                          teacherId: document.data()['teacherId'],
                                          appointmentId: document.id,
                                        );
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
        });
  }
}

class ThursdayStream extends StatelessWidget {
  var studentName='';
  int hour=0;
  int min=0;
  String time='ص';
  var teacherId;
  var studentId;
  var appoinId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: specialist.where('thu',isEqualTo: true).snapshots(),
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
                  time= dayOrNight(document.data()['hour']);
                  teacherId=document.data()['teacherId'];
                  studentId=document.data()['studentId'];
                  appoinId=document.id;
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
                              child: Text(studentName, style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$min : $hour    $time', style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),),
                            ),
                            GestureDetector(
                              child: Icon(Icons.delete, color: kUnselectedItemColor,),
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
                                        onPressed: ()  {
                                          deleteFromDB(
                                          day: 'thu',
                                          sudentId:  document.data()['studentId'],
                                          teacherId: document.data()['teacherId'],
                                          appointmentId: document.id,
                                        );
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
        });
  }
}
