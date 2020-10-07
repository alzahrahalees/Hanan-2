import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constance.dart';
import '../../Teacher.dart';
import 'AddTeacher.dart';


class TeacherScreen extends StatefulWidget {
  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  List<Teacher> teachers= [];
  List<Teacher> FilteringTeachers = [];

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
              color: kBackgroundPageColor,
              padding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: Column(children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "أدخل اسم المعلم",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (string) {
                    setState(() {
                      FilteringTeachers= (teachers.where((element) =>
                      element.name.contains(string) ||
                          element.position.contains(string))).toList();
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                ),
                Row(children: <Widget>[
                  Icon(Icons.person_add),
                  Padding(padding: EdgeInsets.all(3)),
                  GestureDetector(
                    child: Text(" إضافة معلم", style: kTextPageStyle),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddTeacherScreen()),
                      );
                    },
                  )
                ]),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child:
                        TeacherCards())) // here we add the snapshot from database
              ])),
        ));

  }
}
