import 'package:flutter/material.dart';
import 'package:hanan/UI/Constance.dart';

class SpecialistMain extends StatefulWidget {
  @override
  _SpecialistMainState createState() => _SpecialistMainState();
}

class _SpecialistMainState extends State<SpecialistMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KAppBarColor,
        title: Text("Parent Page"),
      ),
      body: Container(
        child: Text('This is parent page'),
      ),
    );
  }
}
