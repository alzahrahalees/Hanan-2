import 'package:flutter/material.dart';
import 'package:hanan/UI/Constance.dart';

class ParentMainScreen extends StatefulWidget {
  @override
  _ParentMainScreenState createState() => _ParentMainScreenState();
}

class _ParentMainScreenState extends State<ParentMainScreen> {
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
