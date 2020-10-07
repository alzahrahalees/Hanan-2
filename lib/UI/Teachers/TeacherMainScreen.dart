import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/logIn.dart';
import 'package:hanan/services/auth.dart';
import 'package:hanan/services/chang_password.dart';
import '../Constance.dart';
import 'TeacherAllAppointments.dart';
import 'TeacherStudentList.dart';


class MainTeacherScreen extends StatefulWidget {
  AuthService _auth = AuthService();
  final int index;
  MainTeacherScreen(this.index);
  @override
  _MainTeacherScreenState createState() => _MainTeacherScreenState();
}

class _MainTeacherScreenState extends State<MainTeacherScreen> {

  User user = FirebaseAuth.instance.currentUser;
  AuthService _authService= AuthService();
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
              icon: Icon(Icons.accessibility),
              title: Text("الطلاب"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text("المواعيد"),
            ),
          ],
        ),
        // drawerEnableOpenDragGesture: true,
        drawer: Container(
          width:225,
          child: Drawer(
            child: Container(
              color: kAppBarColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children:  <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 20,right: 10),
                    child: Container(
                      child: Text(
                      'المعلمة فلانة',
                      style: TextStyle(
                        color: kSelectedItemColor,
                        fontSize: 30,
                      ),
                    ),
                    ),
                  ),
                  // DrawerHeader(
                  //   child: Text(
                  //     'المعلمة فلانة',
                  //     style: TextStyle(
                  //       color: kSelectedItemColor,
                  //       fontSize: 30,
                  //     ),
                  //   ),
                  // ),
                  Divider(
                    color: Colors.black54,
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('الملف الشخصي', style: TextStyle(fontSize: 18),),
                  ),
                  ListTile(
                    leading: Icon(Icons.phonelink_lock),
                    title: Text('تغيير كلمة السر', style: TextStyle(fontSize: 18)),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePassword()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.clear),
                    title: Text('تسجيل الخروج', style: TextStyle(fontSize: 18)),
                    onTap: (){
                      // _authService.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> MainLogIn()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: CustomScrollView(
            slivers:<Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.black54),
                backgroundColor: kAppBarColor,
                title: Text(_titles[_currentIndex], style: kTextAppBarStyle),
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
