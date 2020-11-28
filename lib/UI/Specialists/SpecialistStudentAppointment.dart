import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Specialists/Timer.dart';
import 'package:hanan/UI/Specialists/addAppointmentInStudent.dart';

import '../Constance.dart';

class AppointmentsSpecialist extends StatefulWidget {
  final String studentId;

  AppointmentsSpecialist({this.studentId});

  @override
  _AppointmentsSpecialistState createState() => _AppointmentsSpecialistState();
}

int _currentIndex = 0;

class _AppointmentsSpecialistState extends State<AppointmentsSpecialist>
    with TickerProviderStateMixin {
  int whatDayIndex() {
    int weekday;
    int index = DateTime.now().weekday;
    switch (index) {
      case 1:
        {
          setState(() {
            weekday = 1;
          });
        }
        break;

      case 2:
        {
          setState(() {
            weekday = 2;
          });
        }
        break;

      case 3:
        {
          setState(() {
            weekday = 3;
          });
        }
        break;

      case 4:
        {
          setState(() {
            weekday = 4;
          });
        }
        break;

      case 5:
        {
          setState(() {
            weekday = 0;
          });
        }
        break;

      case 6:
        {
          setState(() {
            weekday = 0;
          });
        }
        break;

      case 7:
        {
          setState(() {
            weekday = 0;
          });
        }
        break;

      default:
        {
          setState(() {
            weekday = 0;
          });
        }
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
      _currentIndex = whatDayIndex();
      _tabController =
          TabController(vsync: this, length: 5, initialIndex: whatDayIndex());
    });
  }

  String whatDay(int index) {
    String day;
    switch (index) {
      case 0:
        {
          setState(() {
            day = 'sun';
          });
        }
        break;

      case 1:
        {
          setState(() {
            day = 'mon';
          });
        }
        break;

      case 2:
        {
          setState(() {
            day = 'tue';
          });
        }
        break;

      case 3:
        {
          setState(() {
            day = 'wed';
          });
        }
        break;

      case 4:
        {
          setState(() {
            day = 'thu';
          });
        }
        break;

      default:
        {
          setState(() {
            day = 'sun';
          });
        }
        break;
    }

    return day;
  }

  int hourEditor(int hour) {
    int newHour;
    if (hour != null) {
      if (hour > 12)
        newHour = hour - 12;
      else
        newHour = hour;
      return newHour;
    } else
      return 0;
  }

  String dayOrNight(int hour) {
    String time;
    if (hour != null) {
      if (hour >= 12)
        time = 'م';
      else
        time = 'ص';
      return time;
    } else
      return 'ص';
  }

  @override
  Widget build(BuildContext context) {
    String _sDay = whatDay(_currentIndex);
    User _user = FirebaseAuth.instance.currentUser;
    DaysTimer _daysTimer = DaysTimer();
    var _studentName = '';
    int _hour = 0;
    int _min = 0;
    String _time = 'ص';
    String studentName;
    bool _isChecked;

    CollectionReference student = FirebaseFirestore.instance
        .collection('Students')
        .doc(widget.studentId)
        .collection('Appointments');

    void _updateIsChecked(
        String teacherId, String studentId, appointmentId) async {
      //update in teacher
      await FirebaseFirestore.instance
          .collection('Teachers')
          .doc(teacherId)
          .collection('Appointments')
          .doc(appointmentId)
          .update({
            '${_sDay}IsChecked': _isChecked,
          })
          .whenComplete(() => print('isChecked updated in teachers'))
          .catchError((e) => print('### Err: $e ####'));

      //update in specialist
      await FirebaseFirestore.instance
          .collection('Specialists')
          .doc(FirebaseAuth.instance.currentUser.email)
          .collection('Appointments')
          .doc(appointmentId)
          .update({
            '${_sDay}IsChecked': _isChecked,
          })
          .whenComplete(() => print('isChecked updated in Specialists'))
          .catchError((e) => print('### Err: $e ####'));

      //update in student
      await FirebaseFirestore.instance
          .collection('Students')
          .doc(studentId)
          .collection('Appointments')
          .doc(appointmentId)
          .update({
        '${_sDay}IsChecked': _isChecked,
      }).whenComplete(() {
        print('isChecked updated in Students');
      }).catchError((e) => print('### Err: $e ####'));
    }

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 25, bottom: 10),
          child: FloatingActionButton(
            backgroundColor: kAppBarColor,
            child: Icon(Icons.add),
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('Students')
                  .doc(widget.studentId)
                  .get()
                  .then((value) => studentName = value.data()['name']);
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
                builder: (BuildContext buildContext) => AddAppointmentInStudent(
                  studentName: studentName,
                  studentId: widget.studentId,
                ),
              );
            },
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
                _sDay = whatDay(_currentIndex);
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
              stream: student
                  .where(whatDay(_currentIndex), isEqualTo: true)
                  .where('specialistId', isEqualTo: _user.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: Text(
                      'لا يوجد أي مواعيد هنا',
                      style: TextStyle(fontSize: 18, color: Colors.black38),
                    ),
                  );
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: SpinKitFoldingCube(
                        color: kUnselectedItemColor,
                        size: 60,
                      ),
                    );
                  default:
                    return ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        _studentName = document.data()['name'];
                        _hour = hourEditor(document.data()['hour']);
                        _min = document.data()['min'];
                        _time = dayOrNight(_hour);
                        _isChecked = document.data()['${_sDay}IsChecked'];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            color: _isChecked ? Colors.white24 : Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Checkbox(
                                      activeColor: kUnselectedItemColor,
                                      checkColor: Colors.white70,
                                      value: _isChecked,
                                      onChanged: (check) {
                                        setState(() {
                                          _isChecked = check;
                                          print(_isChecked);
                                        });

                                        _updateIsChecked(
                                            document.data()['teacherId'],
                                            document.data()['studentId'],
                                            document.id);

                                        _daysTimer.startTimer(
                                            document.data()['teacherId'],
                                            document.data()['studentId'],
                                            FirebaseAuth
                                                .instance.currentUser.email,
                                            document.id,
                                            _sDay);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _studentName,
                                      style: TextStyle(
                                          decoration: _isChecked
                                              ? TextDecoration.lineThrough
                                              : null,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '$_min : $_hour    $_time',
                                      style: TextStyle(
                                          decoration: _isChecked
                                              ? TextDecoration.lineThrough
                                              : null,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                }
              }),
        ),
      ),
    );
  }
}
