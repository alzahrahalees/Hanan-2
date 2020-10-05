import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'Constance.dart';
import 'Admin/AdminLogin.dart';
import '../EmployeesScreenOld.dart';

class ForgetPassScreen extends StatefulWidget {
  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  @override
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _confirmpass = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("إعادة تعيين كلمة المرور", style: KTextAppBarStyle),
          centerTitle: true,
          backgroundColor: KAppBarColor,
          actions: <Widget>[KAppBarTextInkwell(
              text: "إلغاء",
              page:AdminLoginScreen()
          )
          ],
        ),
        body: SafeArea(
            child: Container(
                padding: new EdgeInsets.all(25),
                color: KBackgroundPageColor,
                alignment: Alignment.topCenter,
                child: Form(
                    key: _formkey,
                    child: ListView(shrinkWrap: true, children: [
                      Column(children: <Widget>[
                        Text("أدخل بريدك الإلكتروني ",
                            style: KTextPageStyle.copyWith(fontSize: 17)),
                        new Padding(padding: new EdgeInsets.all(10)),
                        KCircularTextFormField(
                          _emailcontroller,
                          ' الرجاء إدخال البريد الإلكتروني  ',
                        ),
                        Padding(padding: new EdgeInsets.all(10)),
                        RaisedButton(
                          color: KButtonColor,
                          child: Text("إرسال", style: KTextButtonStyle),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("تم الإرسال",
                                          style: KTextPageStyle),
                                      content: Text("الرجاء إدخال رمز التأكيد",
                                          style: KTextPageStyle),
                                      actions: <Widget>[
                                        KCircularTextFormField(
                                            _confirmpass, "*"),
                                        new Row(
                                          children: <Widget>[
                                            FlatButton(
                                              child: Text(
                                                "تأكيد",
                                                style: KTextPageStyle.copyWith(
                                                    color: Colors
                                                        .deepPurpleAccent),
                                              ),
                                              onPressed: () {
                                                //if to confirm the code number
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EmployeesScreen()));
                                              },
                                            ),
                                            FlatButton(
                                              child: Text(
                                                "إلغاء",
                                                style: KTextPageStyle.copyWith(
                                                    color: Colors
                                                        .deepPurpleAccent),
                                              ),
                                              onPressed: () {
                                                //if to confirm the code number
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ForgetPassScreen()));
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            }
                          },
                        ),
                      ])
                    ])))));
  }
}
