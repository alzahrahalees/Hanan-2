import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constance.dart';
import 'AddTeacher.dart';
import '../Teacher.dart';
import 'TeacherDetails.dart';

var teacher1 = new Teacher(name: 'الزهراء', age: '22',email: 'zozo',birthday: '22/0',gender: 'f',uid: '123',type: 'teacher',phone: '050');
var teacher2 = new Teacher(name: 'الزهراء', age: '22',email: 'zozo',birthday: '22/0',gender: 'f',uid: '123',type: 'teacher',phone: '050');
var teacher3 = new Teacher(name: 'الزهراء', age: '22',email: 'zozo',birthday: '22/0',gender: 'f',uid: '123',type: 'teacher',phone: '050');
var teacher4 = new Teacher(name: 'الزهراء', age: '22',email: 'zozo',birthday: '22/0',gender: 'f',uid: '123',type: 'teacher',phone: '050');

List<Teacher> teachers = [teacher1, teacher2, teacher3, teacher4];
List<Teacher> FilteringTeachers = [teacher1, teacher2, teacher3, teacher4];

class TeacherScreen extends StatefulWidget {

  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: KBackgroundPageColor,
            padding: EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: Column(children: <Widget>[
              TextField(
                decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "أدخل اسم المعلم ",
                      prefixIcon: Icon(Icons.search),
                    ),
                onChanged: (string) {
                  setState(() {
                    FilteringTeachers = (teachers.where((element) =>
                    element.name.contains(string) ||
                        element.type.contains(string))).toList();
                      });
                    },
                  ),
                Padding(padding: EdgeInsets.all(5),),
                  Row (children: <Widget>[
                    Icon(Icons.person_add),
                    Padding(padding: EdgeInsets.all(3)),
                    GestureDetector(
                      child: Text(" إضافة معلم  ", style: KTextPageStyle),
                      onTap: () {
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>
                              AddTeacherScreen()

                          ),
                        );
                      },
                    )
                  ]
                  ),
                  Expanded(
                      // here we add the snapshot from database
                      child: ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemCount: FilteringTeachers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                borderOnForeground: true,
                                child: ListTile(
                                  title: Text(FilteringTeachers[index].name,
                                      style: KTextPageStyle),
                                  subtitle: Text(
                                      FilteringTeachers[index].type,
                                      style: KTextPageStyle),
                              onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TeacherInfo(
                                                FilteringTeachers[index].name,
                                                FilteringTeachers[index]
                                                    .type)),
                                      );
                                  }
                                  )
                            );
                          }
                          )
                  )
                ]
                )
              ),

    );
  }
}
