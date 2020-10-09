import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/loading.dart';
import 'package:hanan/UI/logIn.dart';
import '../Constance.dart';
import 'package:hanan/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddAdminScreen extends StatefulWidget {
  @override
  _AddAdminScreenState createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends State<AddAdminScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;

  final AuthService _auth = AuthService();
  String _name;
  String _city;
  String _email;
  String _phone;
  String _password;
  String _password2;
  Color textColor = Colors.black54;
  bool isItValid=false;
  Icon icon = Icon(Icons.lock);

  bool isValid(){

    bool isSame= _password==_password2;
    bool hasDigits = _password.contains( RegExp(r'[0-9]'));
    bool hasLowercase = _password.contains( RegExp(r'[a-z]')) || _password.contains( RegExp(r'[A-Z]'));
    bool hasMinLength = _password.length > 6;
    return  hasDigits  & hasLowercase & hasMinLength & isSame;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kUnselectedItemColor),
          elevation: 0,
          title: Hero(tag: 'newReg',child: Text("إضافة مركز ", style: kTextAppBarStyle)),
          centerTitle: true,
          backgroundColor: kBackgroundPageColor,),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10),
                color: kBackgroundPageColor,
                alignment: Alignment.topCenter,
                child: Form(
                    key: _formkey,
                    // here we add the snapshot from database
                    child: ListView(shrinkWrap: true, children: <Widget>[
                      new Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: KNormalTextFormField(

                            validatorText: '#مطلوب',
                            hintText: 'الاسم',
                            onChanged: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: KNormalTextFormField(

                            validatorText: '#مطلوب',
                            hintText: 'المدينة',
                            onChanged: (value) {
                              setState(() {
                                _city = value;
                              });
                            },
                          ),
                        ),//name //age
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: KNormalTextFormField(

                            validatorText: "#مطلوبة",
                            hintText: "البريد الاكتروني",
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
                        ), //email
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: KNormalTextFormField(

                            validatorText: "#مطلوبة",
                            hintText: "الهاتف",
                            onChanged: (value) {
                              setState(() {
                                _phone = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.lock),
                                hintText: " كلمة المرور",
                                helperStyle: TextStyle(fontSize: 10)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return " الرجاء إدخال كلمة المرور";
                              }
                              else
                                return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:  TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: icon,
                                hintText: "إعادة كلمة المرور",
                                helperStyle: TextStyle(fontSize: 10)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return " الرجاء إدخال كلمة المرور";
                              }
                              else
                                return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _password2 = value;
                              });
                            },
                        ),
                        ),

                        isItValid? new Padding(
                          padding: new EdgeInsets.all(15),
                          child: AddAdmin(
                            formKey: _formkey,
                              name: _name,
                              city: _city,
                              email: _email,
                              phone: _phone,
                              password:_password,
                              password2: _password2,
                              type: "Admin",
                          ) //phone num
                        ):  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                              color: kButtonColor,
                              child: Text("تحقق من صلاحية الرقم السري", style: kTextButtonStyle.copyWith(fontSize: 20)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              onPressed:() {
                                if(isValid()){
                                  setState(() {
                                    isItValid=isValid();
                                    icon = Icon(Icons.done,color: Colors.green,);
                                  });
                                }
                                else{
                                  setState(() {
                                    textColor=Colors.red;
                                    icon = Icon(Icons.clear,color: Colors.red,);
                                  });
                                }
                              }

                          ),
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
                                  " - يجب أن يكون طول كلمة المرور أكثر من 6 أحرف \n "
                                  "بعد الانتهاء من كتابة رقم المرور اضغط على زر تحقق من رقم المرور، إن كان رقم المرور يستوفي جميع الشروط يمكنك الضغط على زر التسجيل "
                              ,
                              style: kTextPageStyle.copyWith(color:textColor  ,fontSize: 18),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        )
                      ]),
                    ])
                )
            )
        )
    );


  }




}


class AddAdmin extends StatelessWidget {
  final String name ;
  final String city  ;
  final String email;
  final String  phone;
  final String  type;
  final String password;
  final String password2;
  final formKey;

  AddAdmin({this.password2,this.password,this.formKey,this.name,this.city,this.email,this.phone,this.type});



  @override
  Widget  build(BuildContext context) {
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');


    Future<void> addAdmin() async{

        var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
        var user = result.user;



      //problem:the document must be have the same ID



      var addToAdmin=Admin.doc(user.email.toLowerCase())
          .set({
        'uid':user.email,
        'name': name,
        'city': city,
        'email': email,
        'phone': phone,
        "type": type,
      })
          .then((value) => print("User Added in Admin Collection"))
          .catchError((error) => print("Failed to add Admin: $error"));

      var addToUsers=Users.doc(user.email.toLowerCase())
          .set({
        'uid':user.email,
        'name': name,
        'email': email,
        'phone': phone,
        "type": type,
      })
          .then((value) => print("User Added in Users Collection"))
          .catchError((error) => print("Failed to add user: $error"));
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> MainLogIn()));
    }


    return RaisedButton(
        color: kButtonColor,
        child: Text("تسجيل", style: kTextButtonStyle.copyWith(fontSize: 20)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)),
        onPressed:() {
          if (formKey.currentState.validate()) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoadingScreen()));
            addAdmin();
          }
        }
    );
  }
}