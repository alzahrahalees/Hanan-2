import 'package:flutter/material.dart';
import 'UI/Constance.dart';
import 'UI/Admin/AdminTeacherScreen.dart';
import 'UI/Admin/AdminLogin.dart';


class EmployeesScreen extends StatefulWidget {
  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(title: Text("حنان",
            style: KTextAppBarStyle,),
          centerTitle: true,
          backgroundColor: KAppBarColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.power_settings_new,),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminLoginScreen()));
              },)],),
        body: Container(
            color: KBackgroundPageColor,
            alignment: Alignment.topCenter,
            child: ListView(shrinkWrap: true, children: [
              Column(children: <Widget>[
                new Container(alignment: Alignment.center,
                  width: 200, height: 180, color: KBackgroundPageColor, child: Image.asset(
                    'assets/images/Teacher-female.ico',
                    width: 200, height: 180,),),
                new InkWell(child: Text("المعلمين", style: KTextPageStyle.copyWith(fontSize: 30)), onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherScreen()));},), new Padding(padding: new EdgeInsets.all(5)), new Container(
                  alignment: Alignment.center, width: 200, height: 180, color: KBackgroundPageColor, child: Image.asset(
                    'assets/images/Spichalist.ico', width: 160, height: 160,),),
                new InkWell(child: Text("الأخصائيين", style: KTextPageStyle.copyWith(fontSize: 30)), onTap: () {print ("Clicked Specialist");
                  },),])])),);}}
