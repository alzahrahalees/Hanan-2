import 'package:flutter/material.dart';
import '../Constance.dart';

class AppointmentsSpecialist extends StatefulWidget {
  @override
  _AppointmentsSpecialistState createState() => _AppointmentsSpecialistState();
}

class _AppointmentsSpecialistState extends State<AppointmentsSpecialist> {
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
