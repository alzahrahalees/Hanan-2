import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UI/Constance.dart';
import 'UI/Admin/AdminLogin.dart';
import 'UI/Teachers/TeacherLogin.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         backgroundColor: KBackgroundPageColor,
       appBar: AppBar(
         elevation: 0.0,
         title: Padding(
           padding: const EdgeInsets.only(top: 15.0),
           child: Text(
             "تسجيل الدخول",
             style: KTextAppBarStyle.copyWith(fontSize: 25),
           ),
         ),
         backgroundColor: KBackgroundPageColor,
         centerTitle: true,
       ),
         body: Column(
           mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Teacher
                ReusableCard(
                  alignment: Alignment.center,
                  width: 150,
                  height: 180,
                  color: KButtonColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                          Icons.person,
                        size: 70,
                        color: Colors.white70,
                      ),
                      Text("المعلمين",
                          style: KTextPageStyle.copyWith(fontSize: 30, color:Colors.white70 )),
                    ],
                  ),
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeacherLoginScreen()));
            },
                ),

                //specialist
                ReusableCard(
                  color: KButtonColor,
                  alignment: Alignment.center,
                  width: 150,
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Icon(
                        Icons.person_add,
                        size: 70,
                        color: Colors.white70,
                      ),
                      Text("الأخصائيين",
                          style: KTextPageStyle.copyWith(fontSize: 30, color:Colors.white70 )),
                    ],
                  ),
//                  onPress: () {
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => TeacherScreen()));
//                  },
                ),
              ],
            ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   // Admin
                   ReusableCard(
                     color: KButtonColor,
                     alignment: Alignment.center,
                     width: 150,
                     height: 180,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Icon(
                           Icons.computer,
                           size: 70,
                           color: Colors.white70,
                         ),
                         Text("الأدمن",
                             style: KTextPageStyle.copyWith(fontSize: 30, color:Colors.white70 )),
                       ],
                     ),
                     onPress: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => AdminLoginScreen()));
                       },
                   ),

                   //Parent
                   ReusableCard(
                     color: KButtonColor,
                     alignment: Alignment.center,
                     width: 150,
                     height: 180,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[

                         Icon(
                           Icons.star,
                           size: 70,
                           color: Colors.white70,
                         ),
                         Text("أولياء الأمور",
                             style: KTextPageStyle.copyWith(fontSize: 30, color:Colors.white70 )),
                       ],
                     ),
//                  onPress: () {
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => ParentScreen()));
//                  },
                   ),
                 ],
               ),

         ]),
       ),
     );
  }
}
