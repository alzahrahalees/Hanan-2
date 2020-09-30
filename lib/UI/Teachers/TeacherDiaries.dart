import 'package:flutter/material.dart';
import '../Constance.dart';

class DiariesScreen extends StatefulWidget {
  @override
  _DiariesScreenState createState() => _DiariesScreenState();
}

class _DiariesScreenState extends State<DiariesScreen> {
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
