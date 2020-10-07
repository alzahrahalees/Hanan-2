import 'package:flutter/material.dart';
import '../Constance.dart';

class AllAppointmentsScreen extends StatefulWidget {
  @override
  _AllAppointmentsScreenState createState() => _AllAppointmentsScreenState();
}

class _AllAppointmentsScreenState extends State<AllAppointmentsScreen> {
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
