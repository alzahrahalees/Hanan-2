import 'package:flutter/material.dart';
import '../Constance.dart';
import 'Diaries/TeacherDiaries.dart';
import 'TeacherPlans.dart';
import 'TeacherStudentAppointment.dart';
import 'TeacherStudentInfo.dart';

import 'package:flutter/src/widgets/framework.dart';

import '../Study Cases/mainStudyCasesScreen.dart';



class TeacherStudentMain extends StatefulWidget {

  @override
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
  @override
  TeacherStudentMain({this.index,this.centerId,this.name,this.uid,this.teacherName,this.teacherId,
    this.communicationSpecialistId,this.communicationSpecialistName,
    this.physiotherapySpecialistId,this.physiotherapySpecialistName,
    this.psychologySpecialistId,this.psychologySpecialistName,
    this.occupationalSpecialistId,this.occupationalSpecialistName});


  _TeacherStudentMainState createState() => _TeacherStudentMainState();
}

class _TeacherStudentMainState extends State<TeacherStudentMain> {
  int  currentIndex=0;
  @override
  Widget build(BuildContext context) {

    List<Widget> _screens=[DiariesTeacher(uid: widget.uid,name: widget.name,centerId: widget.centerId,teacherName: widget.teacherName,teacherId:widget.teacherName),AppointmentsTeacher(widget.uid),PlansTeacher(),StudyCaseScreen(studentId: widget.uid,centerId: widget.centerId,
      communicationSpecialistName:widget.communicationSpecialistName,
      communicationSpecialistId: widget.communicationSpecialistId,
      physiotherapySpecialistId:widget.physiotherapySpecialistId,
      physiotherapySpecialistName:widget.physiotherapySpecialistName ,
      psychologySpecialistId:widget.psychologySpecialistId ,
      psychologySpecialistName:widget.psychologySpecialistName ,
      occupationalSpecialistId: widget.occupationalSpecialistId,
      occupationalSpecialistName:widget.occupationalSpecialistName ,
        teacherName: widget.teacherName


    )];



    List<String> _titles=['يوميات',"مواعيد ","خطط","معلومات "];


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
              currentIndex=index;
            });
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              title: Text("اليوميات"),
            ),
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
                title: Text('${_titles[currentIndex]} ${widget.name}', style: kTextAppBarStyle),
                elevation: 10,
                centerTitle: true,
                floating: false,
              ),
              SliverFillRemaining(
                child:_screens[currentIndex],
              ),
            ]
        )
      ),
    );
  }
}
