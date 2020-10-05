import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:hanan/UI/Specialists/SpecialistMain.dart';
import 'package:hanan/UI/Parents/ParentMain.dart';
import 'UI/Constance.dart';
import 'UI/ForgetPass.dart';
import 'UI/Teachers/TeacherMainScreen.dart';
import 'services/auth.dart';


class MainLogIn extends StatefulWidget {
  @override
  _MainLogInState createState() => _MainLogInState();
}

class _MainLogInState extends State<MainLogIn> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  AuthService _auth =  AuthService();

  final _formkey = GlobalKey<FormState>();
  String warningText ='';
  var resultEmail;


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
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              dynamic type= await whoIs(_emailcontroller.text);
                              print('inside onpress function $type');
                              if(signIn()) {
                                  if(type =='Teacher') {
                                    _auth.signInWithEmailAndPassword(_emailcontroller.text, '12345678');
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MainTeacherScreen(0)));
                                  }
                                  else if(type == 'Specialist'){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpecialistMain()));
                                  }
                                  else if( type== 'Student' ){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ParentMainScreen()));
                                  }
                                  else if ( type == 'Admin'){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainAdminScreen(0)));
                                  }
                                  else{
                                    setState(() {
                                      warningText = 'هذا الإيميل غير صالحو حاول مرة أخرى';
                                    });
                                  }
                              }
                            }
                          }
                        ),
                        Text(
                          warningText,
                          style: KTextPageStyle.copyWith(
                            color: Colors.red
                          ),
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

  Future<String> whoIs(String email) async{
    String type;
    await FirebaseFirestore.instance
        .collection('Users')
        .where('email',isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot){
          querySnapshot.docs.forEach((doc) {type= doc.data()['type'];
          print('iside wois function $type');});
    });
    return type;
  }

  bool signIn() {
   try {dynamic result = _auth.signInWithEmailAndPassword(
        _emailcontroller.text, _passwordcontroller.text);
    if (result!=null){
      print('User signed in');
      return true;
    }
    else { print('User not signed in'); return false;}}
    catch(e){print('Err: $e');}
  }
}

