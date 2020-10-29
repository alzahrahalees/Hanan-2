import 'package:flutter/material.dart';
import '../Constance.dart';
import '../Study Cases/AddCase.dart';
class TeacherStudentInfo extends StatefulWidget {
  @override
  _TeacherStudentInfoState createState() => _TeacherStudentInfoState();
}

class _TeacherStudentInfoState extends State<TeacherStudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
   child: new Column(children: <Widget>[
     GestureDetector(
        onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => AddCase()),
     );
        },
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Row(children: <Widget>[
           Icon(Icons.person_add),
           Padding(
             padding: const EdgeInsets.all(5.0),
             child: Text(" إضافة دراسة الحالة  ", style: kTextPageStyle.copyWith(fontSize: 18)),
           )
         ]),
       ),
     ),


   ],

   ) ,
      ),
    );
  }
}
