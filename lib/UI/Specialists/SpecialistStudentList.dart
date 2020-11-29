import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Specialists/readStudents.dart';


const kCardColor=Color(0xfff4f4f4);

class SpecialistStudentList extends StatefulWidget {
  @override
  _SpecialistStudentListState createState() => _SpecialistStudentListState();
}

class _SpecialistStudentListState extends State<SpecialistStudentList> {

  @override
  Widget build(BuildContext context) {
    return ReadStudents();
  }



}