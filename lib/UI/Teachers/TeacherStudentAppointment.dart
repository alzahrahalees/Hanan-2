import 'package:flutter/material.dart';
import '../Constance.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
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
