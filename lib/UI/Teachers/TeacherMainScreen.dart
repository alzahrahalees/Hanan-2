import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/chang_password.dart';
import 'package:hanan/UI/logIn.dart';
import 'package:hanan/UI/selfProfile.dart';

import '../Constance.dart';
import 'TeacherAllAppointments.dart';
import 'TeacherStudentList.dart';
import 'notifications.dart';

class TeacherMainScreen extends StatefulWidget {
  final int index;
  TeacherMainScreen(this.index);
  @override
  _TeacherMainScreenState createState() => _TeacherMainScreenState();
}

class _TeacherMainScreenState extends State<TeacherMainScreen> {
  User user = FirebaseAuth.instance.currentUser;
  int _currentIndex = 0;
  List<Widget> _screens = [TeacherStudentList(), AllAppointmentsTeacher()];
  List<String> _titles = ["قائمة الطلاب", "جميع المواعيد"];

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = widget.index;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text('هل أنت متأكد؟'),
            content: new Text('هل تريدد تسجيل الخروج من التطبيق؟'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child:
                    new Text('لا', style: TextStyle(color: kSelectedItemColor)),
              ),
              new FlatButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop(true);
                },
                child: new Text(
                  'نعم',
                  style: TextStyle(color: kSelectedItemColor),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 50,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            backgroundColor: Colors.white60,
            selectedItemColor: kSelectedItemColor,
            unselectedItemColor: kUnselectedItemColor,
            selectedIconTheme: IconThemeData(size: 35),
            unselectedIconTheme: IconThemeData(size: 25),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
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
          drawer: Drawer(
            child: Container(
              width: 225,
              color: kAppBarColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser.email
                              .toLowerCase())
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        DocumentSnapshot _userData = snapshot.data;
                        return Center(
                          child: Text(
                            _userData.data()['name'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: kSelectedItemColor,
                              fontSize: 30,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.black54,
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text(
                      'الملف الشخصي',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.phonelink_lock),
                    title:
                        Text('تغيير كلمة السر', style: TextStyle(fontSize: 18)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.clear),
                    title: Text('تسجيل الخروج', style: TextStyle(fontSize: 18)),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MainLogIn()));
                    },
                  ),
                ],
              ),
            ),
          ),

          body: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.black54),
              backgroundColor: kAppBarColor,
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Color(0xfff7e876),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => notifications()));
                    }),
              ],
              title: Text(_titles[_currentIndex], style: kTextAppBarStyle),
              centerTitle: true,
              floating: false,
            ),
            SliverFillRemaining(
              child: _screens[_currentIndex],
            ),
          ]),
        ),
      ),
    );
  }
}
