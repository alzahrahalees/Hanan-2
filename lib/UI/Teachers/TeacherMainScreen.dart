import 'package:flutter/material.dart';
import '../Constance.dart';
import 'TeacherAllAppointments.dart';
import 'TeacherStudentList.dart';
import 'TeacherLogin.dart';


class MainTeacherScreen extends StatefulWidget {
  final int index;
  MainTeacherScreen(this.index);
  @override
  _MainTeacherScreenState createState() => _MainTeacherScreenState();
}

class _MainTeacherScreenState extends State<MainTeacherScreen> {

  int _currentIndex=0;
  List<Widget> _screens=[StudentList(),AllAppointmentsScreen()];
  List<String> _titles=[ "قائمة الطلاب", "جميع المواعيد"];

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex=widget.index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 50,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          backgroundColor: KBackgroundPageColor,
          selectedItemColor:kSelectedItemColor,
          unselectedItemColor:kUnselectedItemColor,
          selectedIconTheme: IconThemeData(size: 35),
          unselectedIconTheme: IconThemeData(size: 25),
          onTap: (index){
            setState(() {
              _currentIndex=index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.accessibility),
              title: Text("الطلاب"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text("المواعيد"),
            ),
          ],
        ),
        body: CustomScrollView(
            slivers:<Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: KAppBarColor,
                title: Text(_titles[_currentIndex], style: KTextAppBarStyle),
                centerTitle: true,
                floating: false,
              ),
              SliverFillRemaining(
                child:_screens[_currentIndex],
              ),
            ]
        ),
      ),
    );
  }
}
