import 'package:flutter/material.dart';
import '../Constance.dart';

class AppointmentsTeacher extends StatefulWidget {
  @override
  _AppointmentsTeacherState createState() => _AppointmentsTeacherState();
}

class _AppointmentsTeacherState extends State<AppointmentsTeacher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "This is Appointments Screen",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
