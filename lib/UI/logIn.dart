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

    List<int> list= [5,7,4,6,3,2];
    int i =0 ;
    int counter =0 ;
    int item = list[0];

    return isLoading?  LoadingScreen() :Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Text('اختبار'),
      //   onPressed: (){
      //     while (counter < list.length){
      //         if (list[i]<item) {
      //         list[i]= item - list[i];
      //         i = list.indexOf(item);
      //         item = list[list.indexOf(item)+1];
      //         counter++;
      //         continue;
      //       }
      //       if (i== list.length-1){
      //         i = 0;
      //       }
      //       else i++;
      //     }
      //     print(list);
      //   },
      // ),
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
              // color: Colors.white70,
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
                            prefixIcon: new IconButton(
                              onPressed: (){},
                              icon:Icon(Icons.person),focusColor: Colors.deepPurple,),
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
                              prefixIcon: new IconButton(icon:Icon(Icons.lock),focusColor: Colors.deepPurple,
                                onPressed: (){},
                              ),
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
                              dynamic type = await whoIs(_email.text.toLowerCase());
                              isInAuth= await isReg();
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading=true;
                                });

                                if(!isInAuth){
                                print('inside onPress function $type');
                                if (type == 'Teachers') {
                                  try{
                                          result = await _auth
                                              .signInWithEmailAndPassword(
                                                  email:
                                                      _email.text.toLowerCase(),
                                                  password: _password.text);
                                        }
                                   on FirebaseAuthException catch  (e) {
                                    print('Failed with error code: ${e.code}');
                                    print(e.message);
                                    setState(() {
                                      isLoading=false;
                                      warningText = 'يوجد خطأ في الإيميل أو كلمة السر';
                                    });
                                  }
                                  if (result != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>

                                                TeacherMainScreen(0)));
                                  }
                                }
                                else if (type == 'Specialists') {
                                  try{
                                    result = await _auth
                                        .signInWithEmailAndPassword(
                                        email:
                                        _email.text.toLowerCase(),
                                        password: _password.text);
                                  }
                                  on FirebaseAuthException catch  (e) {
                                    print('Failed with error code: ${e.code}');
                                    print(e.message);
                                    setState(() {
                                      isLoading=false;
                                      warningText = 'يوجد خطأ في الإيميل أو كلمة السر';
                                    });
                                  }
                                  if (result != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SpecialistMainScreen(index: 0)));
                                  }
                                }
                                else if (type == 'Students') {
                                  try{
                                    result = await _auth
                                        .signInWithEmailAndPassword(
                                        email:
                                        _email.text.toLowerCase(),
                                        password: _password.text);
                                  }
                                  on FirebaseAuthException catch  (e) {
                                    print('Failed with error code: ${e.code}');
                                    print(e.message);
                                    setState(() {
                                      isLoading=false;
                                      warningText = 'يوجد خطأ في الإيميل أو كلمة السر';
                                    });
                                  }
                                  if (result != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ParentMain(0)));
                                  }
                                }
                                else if (type == 'Admin') {
                                  try{
                                    result = await _auth
                                        .signInWithEmailAndPassword(
                                        email:
                                        _email.text.toLowerCase(),
                                        password: _password.text);
                                  }
                                  on FirebaseAuthException catch  (e) {
                                    print('Failed with error code: ${e.code}');
                                    print(e.message);
                                    setState(() {
                                      isLoading=false;
                                      warningText = 'يوجد خطأ في الإيميل أو كلمة السر';
                                    });
                                  }
                                  if (result != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainAdminScreen(0)));
                                  }
                                }
                                else if(type == 'null'){
                                  setState(() {
                                    isLoading=false;
                                    warningText = 'يوجد خطأ في الإيميل أو كلمة السر';
                                  });
                                }

                                else {
                                  setState(() {
                                    isLoading=false;
                                    warningText = 'يوجد خطأ في الإيميل أو كلمة السر';
                                  });
                                }
                                }
                                else{
                                  setState(() {
                                    isLoading=false;
                                  });
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => FirstLogIn(type: type,email: _email.text,)));
                                }
                              }
                            }
                        ),

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
                            child: Text("إذا كنت تسجل الدخول لأول مره ادخل كلمة مرور عشوائية",
                                textAlign: TextAlign.center,
                                style: kTextPageStyle
                            ),
                            ),

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

  Future<bool> isReg() async{
     String type = await whoIs(_email.text);

    //get document from isAuth collection
    authReslute = await FirebaseFirestore.instance.collection('NoAuth')
        .doc(_email.text.toLowerCase()).get();

    // check if document exist
    bool isAdminReg = (authReslute.exists) & (type!='Admin') ;
    print ("#### inside isReg function $isAdminReg");
    return isAdminReg ;

  }


}
