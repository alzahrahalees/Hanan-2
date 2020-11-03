import 'package:flutter/material.dart';
import 'package:hanan/UI/Specialists/SmainStudyCasesScreen.dart';
import 'package:hanan/UI/Specialists/student.dart';
import 'package:hanan/UI/Study%20Cases/mainStudyCasesScreen.dart';
import '../Constance.dart';
import 'SpecialistDiaries.dart';
import 'SpecialistPlans.dart';
import 'SpecialistStudentAppointment.dart';
import 'SpecialistStudentInfo.dart';
import 'package:provider/provider.dart';


class SpecialistStudentMain extends StatefulWidget {

  final  String centerId;
  final int index;
  final String name;
  final String uid;
  final String teacherName;
  final String teacherId;
  final String psychologySpecialistName;//نفسي
  final String psychologySpecialistId;
  final String communicationSpecialistName;//تخاطب
  final String communicationSpecialistId;
  final String occupationalSpecialistName; //,ظيفي
  final String occupationalSpecialistId;
  final String physiotherapySpecialistName;//علاج طبيعي
  final String physiotherapySpecialistId;

  SpecialistStudentMain({this.index,this.centerId,this.name,this.uid,this.teacherName,this.teacherId,
    this.communicationSpecialistId,this.communicationSpecialistName,
    this.physiotherapySpecialistId,this.physiotherapySpecialistName,
    this.psychologySpecialistId,this.psychologySpecialistName,
    this.occupationalSpecialistId,this.occupationalSpecialistName});
  @override
  _SpecialistStudentMainState createState() => _SpecialistStudentMainState();
}

class _SpecialistStudentMainState extends State<SpecialistStudentMain> {

  int _currentIndex=0;

  @override
  Widget build( context) {

    List<String> _titles=["مواعيد ","خطط","معلومات "];
    List<Widget> _screens=[AppointmentsSpecialist(studentId: widget.uid),PlansSpecialist(),SpechalistStudyCaseScreen(studentId: widget.uid,centerId: widget.centerId,
        communicationSpecialistName:widget.communicationSpecialistName,
        communicationSpecialistId: widget.communicationSpecialistId,
        physiotherapySpecialistId:widget.physiotherapySpecialistId,
        physiotherapySpecialistName:widget.physiotherapySpecialistName ,
        psychologySpecialistId:widget.psychologySpecialistId ,
        psychologySpecialistName:widget.psychologySpecialistName ,
        occupationalSpecialistId: widget.occupationalSpecialistId,
        occupationalSpecialistName:widget.occupationalSpecialistName ,
        teacherName: widget.teacherName,
        teacherId: widget.teacherId
    )];
    StudentSp studentInfo= StudentSp();


    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: kBackgroundPageColor,
          selectedItemColor:kSelectedItemColor,
          unselectedItemColor:kUnselectedItemColor,
          selectedFontSize: 20,
          unselectedFontSize: 17,
//          selectedIconTheme: IconThemeData(size: 35),
//          unselectedIconTheme: IconThemeData(size: 25),
          onTap: (index){
            setState(() {
              _currentIndex=index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text("المواعيد"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("الخطط"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text("معلومات الطالب"),
            ),
          ],
        ),
        body:CustomScrollView(
            slivers:<Widget>[
              SliverAppBar(
                backgroundColor: kAppBarColor,
                title: Text('${_titles[_currentIndex]} ${widget.name}', style: kTextAppBarStyle),
                centerTitle: true,
                floating: false,
              ),
              SliverFillRemaining(
                child:_screens[_currentIndex],
              ),
            ]
        )
      ),
    );
  }
}
