import 'package:flutter/material.dart';
import '../Constance.dart';
import 'AddCase.dart';
class StudentInfo extends StatefulWidget {
  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
   child: new Column(children: <Widget>[
     Row(children: <Widget>[
       Icon(Icons.person_add),
       Padding(padding: EdgeInsets.all(3)),
       GestureDetector(
         child: Text(" إضافة دراسة الحالة  ", style: KTextPageStyle),
         onTap: () {
           Navigator.pushReplacement(
             context,
             MaterialPageRoute(
                 builder: (context) => AddCase()),
           );
         },
       )
     ]),


   ],

   ) ,
      ),
    );
  }
}
