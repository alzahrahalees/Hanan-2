import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                        new Padding(
                          padding: new EdgeInsets.all(15),
                          child: AddAdmin(
                            formKey: _formkey,
                              name: _name,
                              city: _city,
                              email: _email,
                              phone: _phone,
                              type: "Admin",
                          )//phone num
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
  final formKey;

  AddAdmin({this.formKey,this.name,this.city,this.email,this.phone,this.type});

  @override
  Widget  build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');

    Future<void> addAdmin() async{
      var result= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: "123456");
      var user=result.user;
      //problem:the document must be have the same ID
      var addToAdmin=Admin.doc(user.uid)
          .set({
        'uid':user.uid,
        'name': name,
        'city': city,
        'email': email,
        'phone': phone,
        "type": type,
      })
          .then((value) => print("User Added in Admin Collection"))
          .catchError((error) => print("Failed to add Admin: $error"));
      var addToUsers=Users.doc(user.uid)
          .set({
        'name': name,
        'email': email,
        'phone': phone,
        "type": type,
      })
          .then((value) => print("User Added in Users Collection"))
          .catchError((error) => print("Failed to add user: $error"));
      Navigator.pop( context);
    }

    return RaisedButton(
        color: kButtonColor,
        child: Text("تسجيل", style: kTextButtonStyle.copyWith(fontSize: 20)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)),
        onPressed:(){
          if (formKey.currentState.validate()){
            addAdmin();
          }
        }
    );
  }
}