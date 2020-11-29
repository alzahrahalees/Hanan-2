import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hanan/UI/Specialists/SpecialistMainScreen.dart';
import 'package:hanan/UI/Parents/ParentMain.dart';
import 'package:hanan/UI/loading.dart';
import 'package:hanan/UI/logIn.dart';
import 'Teachers/TeacherMainScreen.dart';
import 'Constance.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirstLogIn extends StatefulWidget {


  @override
  _FirstLogInState createState() => _FirstLogInState();
}

class _FirstLogInState extends State<FirstLogIn> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _secondPassword = TextEditingController();
  Color textColor = Colors.black54;
  var isLoading = false;

  final _formKey = GlobalKey<FormState>();
  Icon _icon = Icon(Icons.lock);
  bool _isValid = false;


  Future<String> whoIs(String email) async {
    String type;
    //get type
    await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        type = doc.data()['type'];
        print('inside whoIs function $type');
      });
    }).catchError((err) => type = 'Not Valid');
    return type;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? LoadingScreen() : Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: kWolcomeBkg,
          centerTitle: true,
          title: Text(
            "تعيين كملة المرور",
            textAlign: TextAlign.center,
            style: TextStyle(color: kSelectedItemColor),
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
                        Padding(padding: EdgeInsets.all(10)),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: _email,
                            decoration: InputDecoration(

                                prefixIcon: new Icon(Icons.mail),
                                hintText: "الإيميل",
                                helperStyle: TextStyle(fontSize: 10)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return " الرجاء إدخال البريد الإلكتروني ";
                              } else
                                return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: _password,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.lock),
                                hintText: "كلمة المرور",
                                helperStyle: TextStyle(fontSize: 10)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return " الرجاء إدخال كلمة المرور ";
                              } else
                                return null;
                            },
                          ),
                        ),
                        TextFormField(
                          onChanged: (value){
                            if ( isValid() && _password.text  ==_secondPassword.text){
                              setState(() {
                                textColor = Colors.grey;
                                _icon = Icon(
                                  Icons.check,
                                  color: Colors.green,
                                );
                                _isValid = true;
                              });
                            }
                            else {
                              setState(() {
                                textColor = Colors.red;
                                _icon = Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                );
                                _isValid= false;
                              });
                            }
                          },
                          controller: _secondPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: _icon,
                              hintText: "الرجاء إدخال كلمة المرور مرة أخرى",
                              helperStyle: TextStyle(fontSize: 10)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return " الرجاء إدخال كلمة المرور";
                            } else
                              return null;
                          },
                        ),
                        _isValid? Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 5,right: 10,left: 10),
                          child: RaisedButton(
                              color: kButtonColor,
                              child: Text("استكمال التسجيل",
                                  style: kTextButtonStyle),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              onPressed: () async {
                                if (isValid()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await editIsAuthInDB();
                                  Fluttertoast.showToast(
                                      msg: 'تم تعيين كلمة السر بنجاح',
                                    textColor: Colors.white70,
                                    backgroundColor: Colors.black45,
                                  );

                                } else {
                                  setState(() {
                                    isLoading = false;
                                    textColor = Colors.red;
                                    _icon = Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    );
                                  });
                                }
                              }),
                        ):
                        RaisedButton(
                            color: Colors.black26,
                            child: Text("استكمال التسجيل",
                                style: kTextButtonStyle),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            onPressed: () {}
                            ),
                        ReusableCard(
                          width: 400,
                          color: Colors.white10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "يجب إدخال كلمة المرور نفسها بالخانتين و"
                              "يجب أن تحتوي كلمة المرور على كل مما يلي: \n "
                              "- حرف انجليزي واحد على الأقل \n "
                              "- رقم واحد على الأقل \n"
                              " - يجب أن يكون طول كلمة المرور أكثر من 6 أحرف \n ",
                              style: kTextPageStyle.copyWith(
                                  color: textColor, fontSize: 18),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        )
                      ]),
                    ])))));
  }

  void editIsAuthInDB() async {
    String centerId;
    String type = await whoIs(_email.text.toLowerCase());

     FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: _email.text.toLowerCase(), password: _password.text)
        .catchError((err) => print('### Account Not created Err :$err'))
        .then((value)  {
      //get centerId
       FirebaseFirestore.instance
          .collection('Users')
          .doc(_email.text.toLowerCase())
          .get()
          .then((value) => centerId = value.data()['center'])
          .whenComplete(()  {
        print(type);
        print(_email.text);
        print(centerId);
        //delete from isAuth collection
         FirebaseFirestore.instance
            .collection('NoAuth')
            .doc(_email.text.toLowerCase())
            .delete();
        //
        // //edit isAuth fields
         FirebaseFirestore.instance
            .collection(type)
            .doc(_email.text.toLowerCase())
            .update({"isAuth": true});
         FirebaseFirestore.instance
            .collection('Centers')
            .doc(centerId)
            .collection(type)
            .doc(_email.text.toLowerCase())
            .update({'isAuth': true});
         FirebaseFirestore.instance
            .collection('Users')
            .doc(_email.text.toLowerCase())
            .update({"isAuth": true});


        //which page to enter
        if (type == 'Teachers') {

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => TeacherMainScreen(0)));
        }
        else if (type == 'Specialists') {

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SpecialistMainScreen(index: 0)));
        }
        else if (type == 'Students') {

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ParentMain(0)));
        }

        //
        // Navigator.pushReplacement(context, MaterialPageRoute(
        //     builder: (context) => MainLogIn()
        // Navigator.pop(context);
      }).catchError((err) =>
          print('****######### Err: $err ###########*********'));
    });
  }

  bool isValid() {
    bool hasDigits = _password.text.contains(RegExp(r'[0-9]'));
    bool hasLowercase = _password.text.contains(RegExp(r'[a-z]')) ||
        _password.text.contains(RegExp(r'[A-Z]'));
    bool hasMinLength = _password.text.length > 6;
    return hasDigits & hasLowercase & hasMinLength;
  }
}
