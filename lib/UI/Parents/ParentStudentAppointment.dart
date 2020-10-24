import 'package:flutter/material.dart';
import '../Constance.dart';

class ParentAppointments extends StatefulWidget {
  @override
  _ParentAppointmentsState createState() => _ParentAppointmentsState();
}

class _ParentAppointmentsState extends State<ParentAppointments> {
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
