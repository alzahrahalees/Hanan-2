import 'package:flutter/material.dart';
import '../Constance.dart';

class AllAppointmentsSpecialist extends StatefulWidget {
  @override
  _AllAppointmentsSpecialistState createState() => _AllAppointmentsSpecialistState();
}

class _AllAppointmentsSpecialistState extends State<AllAppointmentsSpecialist> {
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
