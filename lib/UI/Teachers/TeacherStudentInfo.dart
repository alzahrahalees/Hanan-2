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
             child: Text(" إضافة دراسة الحالة  ", style: KTextPageStyle.copyWith(fontSize: 18)),
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
