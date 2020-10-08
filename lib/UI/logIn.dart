import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hanan/UI/Admin/AdminMainScreen.dart';
import 'package:hanan/UI/Specialists/SpecialistMain.dart';
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
          backgroundColor: kWolcomeBkg,
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
                color: kWolcomeBkg,
                alignment: Alignment.center,
                child: Form(
                    key: _formKey,
                    child: ListView(shrinkWrap: true, children: [
                      Column(children: <Widget>[
                        Hero(

                          tag: 'logo',
                          child: Image.asset(
                            'assets/images/testLogo.jpg',
                            width: 150,
                            height: 150,
                          ),
                        ),
                        new Padding(padding: new EdgeInsets.all(10)),
                        new TextFormField(
                          controller: _email,
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
                          controller: _password,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: new Icon(Icons.lock),
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
                               dynamic type = await whoIs(
                                    _email.text);
                                print('inside onPress function $type');
                                if (type == 'Teacher') {
                                  result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email.text,
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
                                                MainTeacherScreen(0)));
                                  }
                                }
                                else if (type == 'Specialist') {
                                  result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email.text,
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
                                                SpecialistMain()));
                                  }
                                }
                                else if (type == 'Student') {
                                  result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email.text,
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
                                                ParentMainScreen()));
                                  }
                                }
                                else if (type == 'Admin') {
                                  result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email.text,
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
                                  isLoading=false;
                                  setState(() {
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
                        Text(
                          warningText,
                          style: kTextPageStyle.copyWith(
                              color: Colors.red
                          ),
                        ),
                         InkWell(
                            child: Text("إذا كنت تسجل الدخول لأول مره اضغط هنا",
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
    authReslute = await FirebaseFirestore.instance.collection('NoAuth')
        .doc(_email.text).get();
    bool isAdminReg =  (authReslute.exists)? true :false;
    print ("#### inside isReg function $isAdminReg");
    return isAdminReg ;
  }

}


// void subCollection()async{
//   String name;
//     // await FirebaseFirestore.instance
//     //     .collection('Users')
//     //     .doc().collection('subStudent').doc().set({'name':'SaharS'})
//     //     .catchError((onError)=> print('####inside subcollectio $onError ####'));
//         // .get()
//       //   .then((QuerySnapshot querySnapshot) {
//       // querySnapshot.docs.forEach((doc) {
//       //   type = doc.data()['type'];
//       //   print('subCollection Function $type');
//   // await FirebaseFirestore.instance.collection('Users')
//   //     .doc('MlU83kmD78g7mVJsGLrkThQfAp92')
//   //     .collection('users-teachers')
//   //     .doc()
//   //     .snapshots();
//
//
//       }

//
//   StreamBuilder<QuerySnapshot> subCollection2(){
//     CollectionReference Teachers = FirebaseFirestore.instance.collection('Users')
//         .doc()
//         .collection('TeachersInAdmin');
//     // CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
//
//     return StreamBuilder<QuerySnapshot>(
//       stream:
//       Teachers.snapshots(),
//       builder: (BuildContext context,
//           AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) return Text('Loading');
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return Text('Loading..');
//           default:return new ListView(
//                 children:
//                 snapshot.data.docs.map((DocumentSnapshot document) {
//                   return Text(document.data()['name'], style: kTextPageStyle);
//
//                     // Card(
//                     //   borderOnForeground: true,
//                     //   child: ListTile(
//                     //     title: new ,
//                     //   ));
//                 }).toList());
//         }
//       },
//     );
//   }
//
// }

  // class MyCard extends StatelessWidget {
  //
  // @override
  // Widget build(BuildContext context) {
  // CollectionReference subCollectionVar = FirebaseFirestore.instance.collection('Users')
  //     .doc('QRrwxezYrVkcTKfOEMkN')
  //     .collection('TeachersInAdmin');
  //
  // return StreamBuilder<QuerySnapshot>(
  // stream:
  // subCollectionVar.snapshots(),
  // builder: (BuildContext context,
  // AsyncSnapshot<QuerySnapshot> snapshot) {
  // if (!snapshot.hasData) return Text('Loading');
  // switch (snapshot.connectionState) {
  // case ConnectionState.waiting:
  // return Text('Loading..');
  // default:return new ListView(
  // children:
  // snapshot.data.docs.map((DocumentSnapshot document) {
  // return Card(
  // borderOnForeground: true,
  // child: ListTile(
  // title: new Text(document.data()['name'], style: kTextPageStyle),
  // subtitle: new Text("معلم", style: kTextPageStyle),
  // ));
  // }).toList());
  // }
  // },
  // );
  // }
  // }
