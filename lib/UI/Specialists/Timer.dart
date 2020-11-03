import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class DaysTimer {
  Timer _timer;
  int _counter;
  bool _isChecked;

  startTimer (String teacherId, String studentId,String specialistId, appointmentId, String day) {
    print('start timer is called');
    _counter = 6;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(days: 1), (timer) {
        if (_counter > 0) {
          --_counter;
          print(_counter);
        } else {
          _timer.cancel();
          _isChecked = false;
          _updateIsChecked(teacherId, studentId,specialistId ,appointmentId, day);

        }
    });
  }

  void _updateIsChecked(String teacherId, String studentId,String specialistId, appointmentId, String day) async{

    //update in teacher
    await FirebaseFirestore.instance.collection('Teachers')
        .doc(teacherId).collection('Appointments').doc(appointmentId)
        .update({'${day}isChecked': _isChecked,})
        .whenComplete(() => print('isChecked updated in teachers'))
        .catchError((e)=> print('### Err: $e ####'));

    //update in specialist
    await FirebaseFirestore.instance.collection('Specialists')
        .doc(specialistId)
        .collection('Appointments').doc(appointmentId)
        .update({'${day}isChecked': _isChecked,})
        .whenComplete(() => print('isChecked updated in Specialists'))
        .catchError((e)=> print('### Err: $e ####'));

    //update in student
    await FirebaseFirestore.instance.collection('Students')
        .doc(studentId).collection('Appointments').doc(appointmentId)
        .update({'${day}isChecked': _isChecked,})
        .whenComplete(() => print('isChecked updated in Students'))
        .catchError((e)=> print('### Err: $e ####'));

  }


}