import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constance.dart';
import 'AddStudent.dart';
import '../Student.dart';
import 'StudentDetails.dart';

var student1 = new Student("زهراء الهليس", "طالب");
var student2 = new Student("احمد الغلاييني", "طالب");
var student3 = new Student("غنى الغلاييني", "طالب");
var student4 = new Student("زوزو الغلاييني", "طالب");

List<Student> students = [student1, student2, student3, student4];
List<Student> FiltringStudents = [student1, student2, student3, student4];

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
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
                      hintText: "أدخل اسم الطالب ",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (string) {
                      setState(() {
                        FiltringStudents = (students.where((element) =>
                            element.name.contains(string) ||
                            element.position.contains(string))).toList();
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Row(children: <Widget>[
                    Icon(Icons.person_add),
                    Padding(padding: EdgeInsets.all(3)),
                    GestureDetector(
                      child: Text(" إضافة طالب  ", style: KTextPageStyle),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddStudentScreen()),
                        );
                      },
                    )
                  ]),
                  Expanded(
                      // here we add the snapshot from database
                      child: ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemCount: FiltringStudents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                borderOnForeground: true,
                                child: ListTile(
                                  title: Text(FiltringStudents[index].name,
                                      style: KTextPageStyle),
                                  subtitle: Text(
                                      FiltringStudents[index].position,
                                      style: KTextPageStyle),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StudentInfo(
                                              FiltringStudents[index].name,
                                              FiltringStudents[index]
                                                  .position)),
                                    );
                                  },
                                ));
                          }))
                ]))));
  }
}
