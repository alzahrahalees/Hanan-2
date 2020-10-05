
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Constance.dart';
import '../ForgetPass.dart';
import 'TeacherMainScreen.dart';
import '../../services/auth.dart';

class TeacherLoginScreen extends StatefulWidget {
  @override
  _TeacherLoginScreenState createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  AuthService _auth = new AuthService();

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
                          onPressed: ()  async {
                            if (_formkey.currentState.validate()) {
                              dynamic type= await canLogin(_emailcontroller.text);
                              print('$type inside onpress function');
                              if(type=='Teacher'){
                                _auth.signInWithEmailAndPassword(_emailcontroller.text, '1234567');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainTeacherScreen(0)));
                              }
                              else {
                                setState(() {
                                  warningText='هذا ليس ايميل معلم، يرجى المحاولة مرة أخرى';
                                });
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
  
  Future<String> canLogin(String email) async{

    String type;

    await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: _emailcontroller.text)
        .get()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) => type = doc.data()['type']);
          print("$type inside canLog Function");
        }
        );
    return type;

  }
  
  
}



//if (_formkey.currentState.validate()) { // done
//                                FirebaseFirestore.instance
//                                   .collection('teachersEmail')
//                                   .where(
//                                   'email', isEqualTo: _emailcontroller.text)
//                                   .get()
//                                   .then((QuerySnapshot querySnapshot)  {
//                                     querySnapshot.docs.forEach((doc) => resultEmail = doc.data()['email']);
//                                 if (resultEmail == _emailcontroller.text)  {
//                                   final result =  _auth.signInWithEmailAndPassword(
//                                       _emailcontroller.text,
//                                       _passwordcontroller.text);
//                                   print(result);
//                                   }
//                                   //
//                                   // else {
//                                   //   setState(() {
//                                   //     warningText =
//                                   //     "يوجد خطأ فيالايميل او الباسوورد حاول مرة أخرى";
//                                   //   });
//                                   // }
//
//                                 else {
//                                   setState(() {
//                                     warningText =
//                                     "هذا الايميل غير ليس ايميل معلم ، حاول مره أخرى";
//                                   });
//                                   print('email not exist');
//                                 }
//                               });
//                             }
//                             }