import 'package:flutter/material.dart';
import '../Constance.dart';
import 'ParentDiaries.dart';
import 'ParentPlans.dart';
import 'ParentStudentAppointment.dart';
import 'ParentStudentInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hanan/services/chang_password.dart';
import 'package:hanan/UI/selfProfile.dart';
import 'package:hanan/UI/logIn.dart';
import 'ParentCaretakerInformation.dart';


class ParentMain extends StatefulWidget {


  final int index;

  ParentMain(this.index);
  @override
  _ParentMainState createState() => _ParentMainState();
}

class _ParentMainState extends State<ParentMain> {


  int _currentIndex=0;



  @override
  void initState() {
    super.initState();
    setState(() {

      _currentIndex=widget.index;

    });

  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens=[ParentDiaries(),ParentAppointments(),PlansTeacher(),ParentStudyCaseScreen()];
    List<String> _titles=['اليوميات',"المواعيد ","الخطط","المعلومات "];
    String _name='';
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
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
              label: "اليوميات",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "المواعيد",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "الخطط",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: "معلومات الطالب",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_rounded),
              title: Text("المسؤوليين"),
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
                            .collection('Students')
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
                          _name=_userData.data()['name'];
                          return Center(
                            child: Text (
                              _name,
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
