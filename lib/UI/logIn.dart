import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:hanan/UI/Admin/AdminRegistration.dart';
import 'package:hanan/UI/Specialists/SpecialistMain.dart';
import 'package:hanan/UI/Parents/ParentMain.dart';
import 'Constance.dart';
import 'ForgetPass.dart';
import 'Teachers/TeacherMainScreen.dart';
import '../services/auth.dart';


class MainLogIn extends StatefulWidget {
  @override
  _MainLogInState createState() => _MainLogInState();
}

class _MainLogInState extends State<MainLogIn> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  // AuthService _auth = AuthService();

  FirebaseAuth _auth= FirebaseAuth.instance;
  var result;


  final _formkey = GlobalKey<FormState>();
  String warningText = '';
  var resultEmail;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kSelectedItemColor),
          elevation: 0,
          backgroundColor: kWolcomeBkg,
          centerTitle: true,
          title: Text(
            "تسجيل الدخول",
            textAlign: TextAlign.center,
            style: TextStyle(color: kSelectedItemColor),
          ),
        ),
        body: SafeArea(
            child: Container(
                color: kWolcomeBkg,
                alignment: Alignment.center,
                child: Form(
                    key: _formkey,
                    child: ListView(shrinkWrap: true, children: [
                      Column(children: <Widget>[

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
                          validator: (value) {
                            if (value.isEmpty) {
                              return ' الرجاء إدخال البريد الإلكتروني';
                            }
                            else
                              return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: new Icon(Icons.lock),
                              hintText: "كلمة المرور",
                              helperText:
                              " إذا كنت تسجل الدخول للمرة الأولى، أدخل الرقم 123456 في حقل كلمة المرور",
                              helperStyle: TextStyle(fontSize: 10)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return " الرجاء إدخال كلمة المرور";
                            }
                            else
                              return null;
                          },
                        ),
                        new Padding(padding: new EdgeInsets.all(10)),
                        RaisedButton(
                            color: kButtonColor,
                            child: Text(
                                "تسجيل الدخول", style: kTextButtonStyle),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                dynamic type = await whoIs(
                                    _emailcontroller.text);
                                print('inside onpress function $type');
                                if (type == 'Teacher') {
                                result= await _auth.signInWithEmailAndPassword(email: _emailcontroller.text, password: _passwordcontroller.text);
                                if(result!= null){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MainTeacherScreen(0)));
                                }
                                else {
                                  setState(() {
                                    warningText =
                                    'هذا الإيميل غير صالحو حاول مرة أخرى';
                                  });
                                }
                                }
                                else if (type == 'Specialist') {
                                  result= await _auth.signInWithEmailAndPassword(email: _emailcontroller.text, password: _passwordcontroller.text);
                                  if(result!= null){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpecialistMain()));
                                  }
                                  else {
                                    setState(() {
                                      warningText =
                                      'هذا الإيميل غير صالحو حاول مرة أخرى';
                                    });
                                  }
                                }
                                else if (type == 'Student') {
                                  result= await _auth.signInWithEmailAndPassword(email: _emailcontroller.text, password: _passwordcontroller.text);
                                  if(result!= null){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ParentMainScreen()));
                                  }
                                  else {
                                    setState(() {
                                      warningText =
                                      'هذا الإيميل غير صالحو حاول مرة أخرى';
                                    });
                                  }
                                }
                                else if (type == 'Admin') {
                                  result= await _auth.signInWithEmailAndPassword(email: _emailcontroller.text, password: _passwordcontroller.text);
                                  if(result!= null){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainAdminScreen(0)));

                                  }
                                  else
                                    {
                                    setState(() {
                                      warningText =
                                      'هذا الإيميل غير صالحو حاول مرة أخرى';
                                    });
                                  }
                                }
                                else {
                                  setState(() {
                                    warningText =
                                    'هذا الإيميل غير صالحة حاول مرة أخرى';
                                  });
                                }
                              }
                            }
                        ),
                        Text(
                          warningText,
                          style: kTextPageStyle.copyWith(
                              color: Colors.red
                          ),
                        ),
                        new InkWell(
                            child: new Text(" هل نسيت كلمة المرور؟",
                                style: kTextPageStyle.copyWith(
                                    decoration: TextDecoration.underline)),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ForgetPassScreen()));
                            }),
                      ])
                    ])))));
  }

  Future<String> whoIs(String email) async {
    String type;
    await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        type = doc.data()['type'];
        print('iside wois function $type');
      });
    });
    return type;
  }

//
//   bool signIn() {
//    try {
//      dynamic result = _auth.signInWithEmailAndPassword(
//          _emailcontroller.text, _passwordcontroller.text).then((value) => print("Inside fun"));
//      print('$result inside');
//      return false;
//    }
//
//     catch(e){print('Err: $e');}
//   }
// }

}