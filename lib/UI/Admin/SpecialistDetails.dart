import 'package:flutter/material.dart';
import '../Constance.dart';
import 'AdminMainScreen.dart';

class SpecialistInfo extends StatelessWidget {
  String name;
  String position;

  SpecialistInfo(String name, String position) {
    this.name = name;
    this.position = position;
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[KAppBarTextInkwell(text:"إلغاء",page: MainAdminScreen(1))],
          title: Text("معلومات الأخصائي ", style: KTextAppBarStyle),
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
