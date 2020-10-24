import 'package:flutter/material.dart';
import '../Constance.dart';
import 'TeacherDiaries.dart';
import 'TeacherPlans.dart';
import 'TeacherStudentAppointment.dart';
import 'TeacherStudentInfo.dart';
import 'package:flutter/src/widgets/framework.dart';

class TeacherStudentMain extends StatefulWidget {
  @override
  final  String centerId;
  final int index;
  final String name;
  final String uid;
  final String teacherName;

  TeacherStudentMain({this.index,this.centerId,this.name,this.uid,this.teacherName});


  _TeacherStudentMainState createState() => _TeacherStudentMainState(centerId,index,name, uid,teacherName);
}

class _TeacherStudentMainState extends State<TeacherStudentMain> {
   String centerId;
   int index;
   String name;
  String uid;
  int  currentIndex=0;
  String teacherName;

  _TeacherStudentMainState( String centerId,int index,String name,String uid,String teacherName){
    this.centerId=centerId;
    this.index=index;
    this.name=name;
    this.uid=uid;
    this.teacherName=teacherName;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens=[DiariesTeacher(uid: uid,name: name,centerId: centerId,teacherName: teacherName,),AppointmentsTeacher(),PlansTeacher(),TeacherStudentInfo()];
    List<String> _titles=['يوميات',"مواعيد ","خطط","معلومات "];
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: kAppBarColor,
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
                title: Text('${_titles[currentIndex]} $name', style: kTextAppBarStyle),
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
