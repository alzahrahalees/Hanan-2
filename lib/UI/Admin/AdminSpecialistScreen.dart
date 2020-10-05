import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constance.dart';
import 'AddSpecialis.dart';
import '../Specialist.dart';
import 'SpecialistDetails.dart';

var specialist1 = new Specialist("زهراء الهليس", "أخصائي");
var specialist2 = new Specialist("احمد الغلاييني", "أخصائي");
var specialist3 = new Specialist("غنى الغلاييني", "أخصائي");
var specialist4 = new Specialist("زوزو الغلاييني", "أخصائي");

List<Specialist> specialists  = [specialist1, specialist2, specialist3, specialist4];
List<Specialist> filteringSpecialists = [specialist1, specialist2, specialist3, specialist4];

class SpecialistScreen extends StatefulWidget {
  @override
  _SpecialistScreenState createState() => _SpecialistScreenState();
}

class _SpecialistScreenState extends State<SpecialistScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                color: KBackgroundPageColor,
                padding: EdgeInsets.all(10),
                alignment: Alignment.topCenter,
                child: Column(children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "أدخل اسم الأخصائي ",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (string) {
                      setState(() {
                        filteringSpecialists = (specialists.where((element) =>
                        element.name.contains(string) ||
                            element.position.contains(string))).toList();
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.all(5),),
                  Row (children: <Widget>[
                    Icon(Icons.person_add),
                    Padding(padding: EdgeInsets.all(3)),
                    GestureDetector(
                      child: Text(" إضافة أخصائي  ", style: KTextPageStyle),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                           AddSpecialistScreen()
                          ),);
                      },
                    )
                  ]),
                  Expanded(
                    // here we add the snapshot from database
                      child: ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemCount: filteringSpecialists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                borderOnForeground: true,
                                child: ListTile(
                                  title: Text(filteringSpecialists[index].name,
                                      style: KTextPageStyle),
                                  subtitle: Text(
                                      filteringSpecialists[index].position,
                                      style: KTextPageStyle),
                                  onTap: (){ Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SpecialistInfo(filteringSpecialists[index].name,filteringSpecialists[index].position)),
                                  );} ,
                                ));
                          }))
                ]))));
  }
}
