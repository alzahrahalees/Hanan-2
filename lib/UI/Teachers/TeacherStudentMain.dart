import 'package:flutter/material.dart';
import '../Constance.dart';
import 'TeacherDiaries.dart';
import 'TeacherPlans.dart';
import 'TeacherStudentAppointment.dart';
import 'TeacherStudentInfo.dart';


class TeacherStudentMain extends StatefulWidget {

  final String centerId;
  final int index;
  final String name;
  TeacherStudentMain({this.index,this.centerId,this.name});
  @override
  _TeacherStudentMainState createState() => _TeacherStudentMainState();
}

class _TeacherStudentMainState extends State<TeacherStudentMain> {

  String _centerId= '';
  int _currentIndex=0;
  String _name='';

  List<Widget> _screens=[DiariesScreen(),AppointmentsScreen(),PlansScreen(),StudentInfo()];
  List<String> _titles=['يوميات',"مواعيد ","خطط","معلومات "];

  @override
  void initState() {
    super.initState();
    setState(() {
      _centerId=widget.centerId;
      _currentIndex=widget.index;
      _name=widget.name;
    });

  }

  @override
  Widget build(BuildContext context) {
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
              _currentIndex=index;
            });
          },
          currentIndex: _currentIndex,
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
