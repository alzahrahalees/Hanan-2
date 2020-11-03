import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:hanan/UI/Specialists/SpecialistMainScreen.dart';
import 'package:hanan/UI/Parents/ParentMain.dart';
import 'package:hanan/UI/firstLogIn.dart';
import 'Constance.dart';
import 'ForgetPass.dart';
import 'Teachers/TeacherMainScreen.dart';
import 'loading.dart';

class MainLogIn extends StatefulWidget {
  @override
  _MainLogInState createState() => _MainLogInState();
}

class _MainLogInState extends State<MainLogIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();



  FirebaseAuth _auth = FirebaseAuth.instance;
  var result;
  var authReslute;



  final _formKey = GlobalKey<FormState>();
  String warningText = '';
  var resultEmail;
  var valueOfAuth;
  var isInAuth;
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading?  LoadingScreen() :Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kSelectedItemColor),
          elevation: 0,
          backgroundColor: Colors.white70,
          centerTitle: true,
          title: Hero(
            tag: 'login',
            child: Text(
              "تسجيل الدخول",
              textAlign: TextAlign.center,
              style: TextStyle(color: kSelectedItemColor),
            ),
          ),
        ),
        body: SafeArea(
            child: Container(
              //  color: kWolcomeBkg,
              color: Colors.white70,
                alignment: Alignment.center,
                child: Form(
                    key: _formKey,
                    child: ListView(shrinkWrap: true, children: [
                      Column(children: <Widget>[
                        Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 225,
                            height: 225,
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.all(10)),
                        new TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple,width: 2)),
                            hintText: "البريد الإلكتروني",
                            prefixIcon: new IconButton(icon:Icon(Icons.person),focusColor: Colors.deepPurple,),
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
                          controller: _password,
                          obscureText: true,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.deepPurple,width: 2)),
                              prefixIcon: new IconButton(icon:Icon(Icons.lock),focusColor: Colors.deepPurple,),
                              hintText: "كلمة المرور",
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
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading=true;
                                });
                                isInAuth= await isReg();
                                if(!isInAuth){
                               dynamic type = await whoIs(_email.text.toLowerCase());
                                print('inside onPress function $type');
                                if (type == 'Teachers') {
                                  result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email.text.toLowerCase(),
                                      password: _password.text)
                                      .catchError((onError) =>
                                      setState(() {
                                        warningText =
                                        'يوجد خطأ في الايميل أو كلمة السر';
                                      }));
                                  if (result != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>

                                                TeacherMainScreen(0)));
                                  }
                                }
                                else if (type == 'Specialists') {
                                  result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email.text,
                                      password: _password.text.toLowerCase())
                                      .catchError((onError) =>
                                      setState(() {
                                        warningText =
                                        'يوجد خطأ في الايميل أو كلمة السر';
                                      }));
                                  if (result != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpecialistMainScreen(index: 0)));
                                  }
                                }
                                else if (type == 'Students') {
                                  result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email.text.toLowerCase(),
                                      password: _password.text)
                                      .catchError((onError) =>
                                      setState(() {
                                        warningText =
                                        'يوجد خطأ في الايميل أو كلمة السر';
                                      }));
                                  if (result != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ParentMain(0)));
                                  }
                                }
                                else if (type == 'Admin') {
                                  result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email.text.toLowerCase(),
                                      password: _password.text)
                                      .catchError((onError) =>
                                      setState(() {
                                        warningText =
                                        'يوجد خطأ في الايميل أو كلمة السر';
                                      }));
                                  if (result != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainAdminScreen(0)));
                                  }
                                }
                                else {
                                  setState(() {
                                    isLoading=false;
                                    warningText = 'هذا الإيميل غير صالح للاستعمال, حاول مرة أخرى';
                                  });
                                }
                                }
                                else{
                                  setState(() {
                                    isLoading=false;
                                    warningText= 'الرجاء االضغط على التسجيل لأول مره لاستكمال التسجيل وتعيين كلمة سر جديدة';
                                  });
                                }
                              }
                            }
                        ),
                        // Container(
                        //     width: 400,
                        //     height: 500,
                        //     child: MyCard()
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            warningText,
                            textAlign: TextAlign.center,
                            style: kTextPageStyle.copyWith(
                                color: Colors.red,
                            ),
                          ),
                        ),
                         InkWell(
                            child: Text("إذا كنت تسجل الدخول لأول مره اضغط هنا",
                                textAlign: TextAlign.center,
                                style: kTextPageStyle.copyWith(
                                    decoration: TextDecoration.underline)),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => FirstLogIn()));
                            }),

                         Padding(
                           padding: const EdgeInsets.only(top: 8),
                           child: InkWell(
                              child:  Text(" هل نسيت كلمة المرور؟",
                                  style: kTextPageStyle.copyWith(
                                      decoration: TextDecoration.underline)),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ForgetPassScreen()));
                              }),
                         ),
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
      querySnapshot.docs
          .forEach((doc) {
        type = doc.data()['type'];
        print('inside whoIs function $type');
      });
    }).catchError((err) => type = 'Not Valid');
    return type;
  }

  Future<bool> isReg() async{
    String type;
    await FirebaseFirestore.instance
        .collection('Users ')
        .where('email', isEqualTo: _email.text.toLowerCase())
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs
          .forEach((doc) {
        type = doc.data()['type'];
        print('inside whoIs function $type');
      });
    }).catchError((err) => type = 'Not Valid');

    authReslute = await FirebaseFirestore.instance.collection('NoAuth')
        .doc(_email.text.toLowerCase()).get();

    bool isAdminReg = (authReslute.exists) & (type!='Admin') ;
    print ("#### inside isReg function $isAdminReg");
    return isAdminReg ;
  }


}
