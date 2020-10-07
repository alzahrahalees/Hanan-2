import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Specialist.dart';
import '../../Constance.dart';
import 'AddSpecialis.dart';

class SpecialistScreen extends StatefulWidget {
  @override

  _SpecialistScreenState createState() => _SpecialistScreenState();
}
class _SpecialistScreenState extends State<SpecialistScreen> {
  List<Specialist> specialists= [];
  List<Specialist> FilteringSpecialists = [];

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
                    hintText: "أدخل اسم الأخصائي",
                    prefixIcon: Icon(Icons.search),
                  ),

                  onChanged: (string) {
                    setState(() {
                      FilteringSpecialists  = (specialists .where((element) =>
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
                    child: Text(" إضافة أخصائي", style: kTextPageStyle),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddSpecialistScreen()),
                      );
                    },
                  )
                ]),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child:
                       SpecialistCards())) // here we add the snapshot from database
              ])),
        ));
  }
}
