import 'package:flutter/material.dart';
import '../Constance.dart';

class AllAppointmentsTeacher extends StatefulWidget {
  @override
  _AllAppointmentsTeacherState createState() => _AllAppointmentsTeacherState();
}

class _AllAppointmentsTeacherState extends State<AllAppointmentsTeacher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundPageColor,
      child: Text(
        "This is Appointments Screen",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
