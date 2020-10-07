import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/logIn.dart';
import '../Constance.dart';
import 'AdminTeacher/AdminTeacherScreen.dart';
import 'AdminSpecialist/AdminSpecialistScreen.dart';
import 'AdminStudent/AdminStudentsScreen.dart';




class MainAdminScreen extends StatefulWidget {
  final int index;
  MainAdminScreen(this.index);
  @override
  _MainAdminScreenState createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {

  int _currentIndex=0;
  List<Widget> _screens=[TeacherScreen(),SpecialistScreen(),StudentScreen()];
  List<String> _titles=["المعلمين", "الأخصائيين", "الطلاب"];

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
            backgroundColor: kBackgroundPageColor,
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
                icon: Icon(Icons.person),
                title: Text("المعلمين"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_add),
                title: Text("الأخصائيين"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text("الطلاب"),
              ),
            ],
          ),

          body: CustomScrollView(
            slivers:<Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.power_settings_new,
                    color: kUnselectedItemColor,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainLogIn()));
                  },
                ),
                backgroundColor: kAppBarColor,
                title: Text(_titles[_currentIndex], style: kTextAppBarStyle),
                centerTitle: true,
                floating: false,
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: _screens[_currentIndex],
              ),
            ]
            )
        )
    );
  }
}
