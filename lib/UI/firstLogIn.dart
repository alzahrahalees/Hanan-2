import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hanan/UI/Specialists/SpecialistMainScreen.dart';
import 'package:hanan/UI/Parents/ParentMain.dart';
import 'package:hanan/UI/loading.dart';
import 'Teachers/TeacherMainScreen.dart';
import 'Constance.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirstLogIn extends StatefulWidget {
  final String type;
  final String email;

  FirstLogIn({this.type, this.email});

  @override
  _FirstLogInState createState() => _FirstLogInState();
}

class _FirstLogInState extends State<FirstLogIn> {


  TextEditingController _password = TextEditingController();
  TextEditingController _secondPassword = TextEditingController();
  Color textColor = Colors.black54;
  var isLoading = false;

  final _formKey = GlobalKey<FormState>();
  Icon _icon = Icon(Icons.lock);



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
                              });
                            }
                            else {
                              setState(() {
                                textColor = Colors.red;
                                _icon = Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                );
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
                        Padding(
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

  Future<void> editIsAuthInDB() async {
    String centerId;

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: widget.email.toLowerCase(), password: _password.text)
        .catchError((err) => print('### Account Not created Err :$err'))
        .then((value) async {

      //get centerId
      centerId = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.email)
          .get()
          .then((value) => centerId = value.data()['center']);
    }).whenComplete(() async {

      //delete from isAuth collection
      await FirebaseFirestore.instance
          .collection('NoAuth')
          .doc(widget.email.toLowerCase())
          .delete();

      //edit isAuth fields
      await FirebaseFirestore.instance
          .collection(widget.type)
          .doc(widget.email.toLowerCase())
          .update({"isAuth": true});
      await FirebaseFirestore.instance
          .collection('Centers')
          .doc(centerId)
          .collection(widget.type)
          .doc(widget.email.toLowerCase())
          .update({'isAuth': true});
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.email.toLowerCase())
          .update({"isAuth": true});


      //which page to enter
      if (widget.type == 'Teachers') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TeacherMainScreen(0)));
      } else if (widget.type == 'Specialists') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SpecialistMainScreen(index: 0)));
      } else if (widget.type == 'Students') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ParentMain(0)));
      }

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
