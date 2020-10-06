import 'package:flutter/material.dart';
import '../Constance.dart';
import 'TeacherStudentMain.dart';

const kCardColor=Color(0xffc6c6c6);



class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Container(
          padding: EdgeInsets.all(10),
          color: kBackgroundPageColor,
          alignment: Alignment.topCenter,
          // here we add the snapshot from database
          child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  children: [
                    ReusableCard(
                      color: kCardColor,
                      child: ListTile(
                        title:Text( "الزهراء الهليس", style: kTextPageStyle),
                        subtitle: Text( "طالب"),),

                      onPress: () {
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>TeacherStudentMain(0))
                        );
                      }
                    ),

                    ReusableCard(
                        color: kCardColor,
                        child: ListTile(
                          title: Text("غنى الغلاييني", style: kTextPageStyle),
                          subtitle: Text("طالب"),
                        ),
                        onPress: () {
                          print("Tapped on teacher ");
                        }
                    ),

                  ],
                ),

              ]),

        ),
      ),
    );
  }
}
