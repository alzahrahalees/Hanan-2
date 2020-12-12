import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Admin/AdminRegistration.dart';
import 'package:hanan/UI/Constance.dart';
import 'package:hanan/UI/logIn.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kWolcomeBkg,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 400,
                  height: 400,
                ),
              ),
              // Image.asset(
              //   'assets/images/logoName.png',
              //   width: 100,
              //   height: 100,
              // ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: 'login',
                  child: RaisedButton(
                      color: kUnselectedItemColor,
                      elevation: 10,
                      child: Text("تسجيل الدخول",
                          style: kTextButtonStyle.copyWith(fontSize: 30)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      onPressed: () {
                        // Navigator.popAndPushNamed(context, routeName)
                        // Navigator.pushReplacementNamed(context, routeName)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainLogIn()));
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Hero(
                  tag: 'newReg',
                  child: RaisedButton(
                      elevation: 10,
                      color: kUnselectedItemColor,
                      child: Text("تسجيل مركز جديد",
                          style: kTextButtonStyle.copyWith(fontSize: 30)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddAdminScreen()));
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
