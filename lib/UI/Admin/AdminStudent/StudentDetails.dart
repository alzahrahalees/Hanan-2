import 'package:flutter/material.dart';
import '../../Constance.dart';
import '../AdminMainScreen.dart';

class StudentInfo extends StatelessWidget {
  String name;


  StudentInfo(String name);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("معلومات الطالب ", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10),
                color: kBackgroundPageColor,
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
                          style: kTextPageStyle,
                        ),
                      ])
                    ])))));
  }
}
