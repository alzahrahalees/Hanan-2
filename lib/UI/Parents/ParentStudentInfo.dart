import 'package:flutter/material.dart';
import '../Constance.dart';


class ParentStudentInfo extends StatefulWidget {
  @override
  _ParentStudentInfoState createState() => _ParentStudentInfoState();
}

class _ParentStudentInfoState extends State<ParentStudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
   child: new Column(children: <Widget>[
     GestureDetector(
        onTap: () {
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
