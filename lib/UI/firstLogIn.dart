import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/logIn.dart';
import 'Constance.dart';
import 'package:firebase_auth/firebase_auth.dart';



class FirstLogIn extends StatefulWidget {

  @override
  _FirstLogInState createState() => _FirstLogInState();
}

class _FirstLogInState extends State<FirstLogIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _2ndPassword = TextEditingController();
  Color textColor= Colors.black54;


  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        iconTheme: IconThemeData(color: kSelectedItemColor),
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
                Padding(padding:  EdgeInsets.all(10)),
                TextFormField(
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
                      }
                      else return null;
                      },
                  ),
                ),
                TextFormField(
                  controller: _2ndPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: new Icon(Icons.lock),
                      hintText: "الرجاء إدخال كلمة المرور مرة أخرى",
                      helperStyle: TextStyle(fontSize: 10)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return " الرجاء إدخال كلمة المرور";
                    }
                    else return null;
                  },
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  color: kButtonColor,
                  child: Text(
                      "استكمال التسجيل", style: kTextButtonStyle),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  onPressed: ()async{

                    if(isValid()) {
                      editisAuthInDB();
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context)=> MainLogIn()
                    )
                    );
                    }
                    else{setState(() {
                      textColor=Colors.red;
                    }); }
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
                          ,
                      style: kTextPageStyle.copyWith(color: textColor,fontSize: 18),
                      textAlign: TextAlign.right,
                    ),
                  ),
                )
              ]) ,
            ])
        )
        )
    )
    );
}

//var docRef = db.collection("cities").doc("SF");
//
// docRef.get().then(function(doc) {
//     if (doc.exists) {
//         console.log("Document data:", doc.data());
//     } else {
//         // doc.data() will be undefined in this case
//         console.log("No such document!");
//     }
// }).catch(function(error) {
//     console.log("Error getting document:", error);
// });

   editisAuthInDB() async {
    String type;
    var centerEmail;
    await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: _email.text)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs
          .forEach((doc) {
        type = doc.data()['type'];
        print('inside whoIs function $type');
      });
    }).catchError((err) => type = 'Not Valid')
        .whenComplete(() async {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email.text, password: _password.text);
      await FirebaseFirestore.instance.collection(type).doc(_email.text)
          .get().then((doc){
            if(doc.exists){centerEmail= doc.data()['center'];}
      } );
      await FirebaseFirestore.instance.collection('NoAuth').doc(_email.text.toLowerCase()).delete();
      await FirebaseFirestore.instance.collection(type).doc(_email.text.toLowerCase()).update({"isAuth":true});
      await FirebaseFirestore.instance.collection('Centers').doc(centerEmail)
          .collection(type).doc(_email.text.toLowerCase()).update({'isAuth':true});
      await FirebaseFirestore.instance.collection('Users').doc(_email.text.toLowerCase()).update({"isAuth":true});
    });
  }

  bool isValid(){

    bool hasDigits = _password.text.contains( RegExp(r'[0-9]'));
    bool hasLowercase = _password.text.contains( RegExp(r'[a-z]')) || _password.text.contains( RegExp(r'[A-Z]'));
    bool hasMinLength = _password.text.length > 6;
    return  hasDigits  & hasLowercase & hasMinLength;
  }
}
