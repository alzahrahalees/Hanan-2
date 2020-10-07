import 'package:flutter/material.dart';
import '../../Constance.dart';
import '../AdminMainScreen.dart';

class TeacherInfo extends StatelessWidget {
  String name;
  String position;

  TeacherInfo(String name, String position) {
    this.name = name;
    this.position = position;
    bool DisplayNameValid = true;
    bool bioValid = true;
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("معلومات المعلم", style: kTextAppBarStyle),
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
