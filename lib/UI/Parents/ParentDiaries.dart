import 'package:flutter/material.dart';
import '../Constance.dart';

class ParentDiaries extends StatefulWidget {
  @override
  _ParentDiariesState createState() => _ParentDiariesState();
}

class _ParentDiariesState extends State<ParentDiaries> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "This is Diaries Screen",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
