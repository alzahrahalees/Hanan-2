import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hanan/UI/logIn.dart';
import '../Constance.dart';
import 'AdminTeacher/AdminTeacherScreen.dart';
import 'AdminSpecialist/AdminSpecialistScreen.dart';
import 'AdminStudent/AdminStudentsScreen.dart';
import '../chang_password.dart';
import '../../UI/selfProfile.dart';


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
  void initState()  {
    super.initState();
    setState(()  {
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
                label: "المعلمين"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_add),
                label: "الأخصائيين",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: "الطلاب",
              ),
            ],
          ),
          drawer: Container(
            width:225,
            child: Drawer(
              child:Container(
                color: kAppBarColor,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children:  <Widget>[
                    DrawerHeader(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser.email.toLowerCase())
                            .snapshots(),
                        builder: (context, snapshot){
                          if(!snapshot.hasData){
                            return CircularProgressIndicator();
                          }
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return CircularProgressIndicator();
                          }
                          DocumentSnapshot _userData= snapshot.data;
                          return Center(
                            child: Text (
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

                        ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text('الملف الشخصي', style: TextStyle(fontSize: 18),),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
                          },
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
                            FirebaseAuth.instance.signOut();
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
                toolbarHeight: 40,
                iconTheme: IconThemeData(color: kUnselectedItemColor),
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


