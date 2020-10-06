import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'Constance.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPassScreen extends StatefulWidget {
  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  @override
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();

  String done='';
  dynamic result;

  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text("إعادة تعيين كلمة المرور", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kBackgroundPageColor,
          elevation: 0,
          iconTheme: IconThemeData(color: kUnselectedItemColor),
        ),
        body: SafeArea(
            child: Container(
                padding: new EdgeInsets.all(25),
                color: kBackgroundPageColor,
                alignment: Alignment.topCenter,
                child: Form(
                    key: _formkey,
                    child: ListView(shrinkWrap: true, children: [
                      Column(children: <Widget>[
                        Text("أدخل بريدك الإلكتروني ",
                            style: kTextPageStyle.copyWith(fontSize: 17)),
                        new Padding(padding: new EdgeInsets.all(10)),
                        KCircularTextFormField(
                          _emailcontroller,
                          ' الرجاء إدخال البريد الإلكتروني  ',
                        ),
                        Padding(padding: new EdgeInsets.all(10)),
                        RaisedButton(
                          color: kButtonColor,
                          child: Text("إرسال", style: kTextButtonStyle),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () async {
                            if (_formkey.currentState.validate()){
                              await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailcontroller.text);
                             setState(() {
                               done=' تم إرسال رابط لإعادة تعيين كلمة المرور على بريدك اإلكتروني ';
                             });
                            }
                          },
                        ),
                        Text(
                          done,
                          style: kTextButtonStyle.copyWith(color: Colors.green),
                          textAlign: TextAlign.center,
                        )
                      ])
                    ]))))
    );
  }

  Future<dynamic> resetPassword() async{
    var result = await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailcontroller.text);
    return result;

  }

}

//
//
// if (_formkey.currentState.validate()) {
// return showDialog(
// context: context,
// builder: (context) {
// return AlertDialog(
// title: Text("تم الإرسال",
// style: kTextPageStyle),
// content: Text("الرجاء إدخال رمز التأكيد",
// style: kTextPageStyle),
// actions: <Widget>[
// KCircularTextFormField(
// _confirmpass, "*"),
// new Row(
// children: <Widget>[
// FlatButton(
// child: Text(
// "تأكيد",
// style: kTextPageStyle.copyWith(
// color: Colors
//     .deepPurpleAccent),
// ),
// onPressed: () {
// //if to confirm the code number
// Navigator.pop(context);
// },
// ),
// FlatButton(
// child: Text(
// "إلغاء",
// style: kTextPageStyle.copyWith(
// color: Colors
//     .deepPurpleAccent),
// ),
// onPressed: () {
// //if to confirm the code number
// Navigator.pushReplacement(
// context,
// MaterialPageRoute(
// builder: (context) =>
// ForgetPassScreen()));
// },
// ),
// Text(
// done,
// style: kTextButtonStyle.copyWith(color: Colors.green),
// )
// ],
// )
// ],
// );
// });
// }