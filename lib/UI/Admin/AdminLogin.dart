import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Constance.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import '../ForgetPass.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                color: KBackgroundPageColor,
                alignment: Alignment.center,
                child: Form(
                    key: _formkey,
                    child: ListView(shrinkWrap: true, children: [
                      Column(children: <Widget>[
                        Text("تسجيل الدخول",
                            style: KTextPageStyle.copyWith(fontSize: 30)),
                        Image.asset(
                          'assets/images/testLogo.jpg',
                          width: 200,
                          height: 180,
                        ),
                        new Padding(padding: new EdgeInsets.all(10)),
                        new TextFormField(
                          controller: _emailcontroller,
                          decoration: InputDecoration(
                            hintText: "البريد الإلكتروني",
                            prefixIcon: new Icon(Icons.person),
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return ' الرجاء إدخال البريد الإلكتروني';
                            }
                          },
                        ),
                        TextFormField(
                          controller: _passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: new Icon(Icons.lock),
                              hintText: "كلمة المرور",
                              helperText:
                                  " إذا كنت تسجل الدخول للمرة الأولى، أدخل الرقم رقم الهاتف في حقل كلمة المرور",
                              helperStyle: TextStyle(fontSize: 10)),
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return " الرجاء إدخال كلمة المرور";
                            }
                          },
                        ),
                        new Padding(padding: new EdgeInsets.all(10)),
                        RaisedButton(
                          color: KButtonColor,
                          child: Text("تسجيل الدخول", style: KTextButtonStyle),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainAdminScreen(0)));
                            }
                          },
                        ),
                        new InkWell(
                            child: new Text(" هل نسيت كلمة المرور؟",
                                style: KTextPageStyle.copyWith(
                                    decoration: TextDecoration.underline)),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPassScreen()));
                            }),
                      ])
                    ])))));
  }
}
