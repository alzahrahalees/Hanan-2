import 'package:flutter/material.dart';
import 'package:hanan/UI/Specialists/student.dart';
import 'package:hanan/UI/Study%20Cases/mainStudyCasesScreen.dart';
import '../Constance.dart';
import 'SpecialistDiaries.dart';
import 'SpecialistPlans.dart';
import 'SpecialistStudentAppointment.dart';
import 'SpecialistStudentInfo.dart';
import 'package:provider/provider.dart';


class SpecialistStudentMain extends StatefulWidget {


  final BuildContext context;
  final String studentId;
  final int index;
  final String name;
  SpecialistStudentMain({this.index,this.name, this.studentId, this.context});
  @override
  _SpecialistStudentMainState createState() => _SpecialistStudentMainState();
}

class _SpecialistStudentMainState extends State<SpecialistStudentMain> {

  int _currentIndex=0;
  String _name='';
  String _studentId='';




  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex=widget.index;
      _name=widget.name;
      _studentId=widget.studentId;
    });

  }

  @override
  Widget build( context) {

    List<String> _titles=["مواعيد ","خطط","معلومات "];
    List<Widget> _screens=[AppointmentsSpecialist(studentId: _studentId),PlansSpecialist(),StudyCaseScreen(widget.studentId)];
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
                title: Text('${_titles[_currentIndex]} $_name', style: kTextAppBarStyle),
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
