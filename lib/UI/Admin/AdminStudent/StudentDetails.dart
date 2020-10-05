import 'package:flutter/material.dart';
import '../../Constance.dart';
import '../AdminMainScreen.dart';

class StudentInfo extends StatelessWidget {
  String name;
  String position;

  StudentInfo(String name, String position) {
    this.name = name;
    this.position = position;
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("معلومات الطالب ", style: KTextAppBarStyle),
          centerTitle: true,
          backgroundColor: KAppBarColor,
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10),
                color: KBackgroundPageColor,
                alignment: Alignment.topRight,
                child: Form(
                    key: _formkey,
                    // here we add the snapshot from database
                    child: ListView(shrinkWrap: true, children: <Widget>[
                      new Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5),
                        ),
                        Text(
                          " الإسم  $name ",
                          style: KTextPageStyle,
                        ),
                      ])
                    ])))));
  }
}
