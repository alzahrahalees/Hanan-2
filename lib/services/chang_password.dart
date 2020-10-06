import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanan/UI/Constance.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _secondNewPasswordController = TextEditingController();

  Color textColor= Colors.black54;
  String warningText='';

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        iconTheme: IconThemeData(color:kSelectedItemColor ),
        title: Text("تغيير كلمة السر", style: kTextAppBarStyle.copyWith(color:kSelectedItemColor),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: kBackgroundPageColor,
          child: Form(
            key:  _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('لنغيير كلمة المرور الرجاء إدخال ما يلي:', textAlign: TextAlign.right,style: TextStyle(fontSize: 18),),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "البريد الإلكتروني",
                      prefixIcon: new Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return ' البريد الإلكتروني';
                      }
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
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
                  Padding(padding:EdgeInsets.all(25) ),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.lock),
                        hintText: "كلمة المرور الجديدة",
                        helperStyle: TextStyle(fontSize: 10)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return " الرجاء إدخال كلمة المرور الجديدة ";
                      }
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    controller: _secondNewPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.lock),
                        hintText:"إعادة إدخال كلمة المرور الجديدة",
                        helperStyle: TextStyle(fontSize: 10)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return " الرجاء إعادة إدخال كلمة المرور الجديدة";
                      }
                      else
                        return null;
                    },
                  ),
                  Padding(padding:EdgeInsets.all(25) ),
                  RaisedButton(
                      color: kButtonColor,
                      child: Text("تغيير كلمة المرور", style: kTextButtonStyle),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                      onPressed: ()  {
                        dynamic result;
                        if (_formkey.currentState.validate()) {
                        if (_newPasswordController.text==_secondNewPasswordController.text) {
                          if(isValid()){
                            result = authEmailandPassword();
                            if (result != null){
                              print('##### user Authenticated ######');
                              changPassword();
                              print('##### password must be changed ######');
                          }
                        else {
                          setState(() {
                            warningText= 'يوجد خطأ في الإيميل او كلمة السر, الرجاء المحاولة مرة أخرى';
                      });
                    }
                  }
                      else{
                        setState(() {
                          textColor=Colors.red;
                          warningText='الرجاء اتباع القوانين لكلمة السر';
                    });
                  }}
                        else{
                          setState(() {
                            warningText='كلمتي السر مختلفتين';
                          });
                        }
                }
                }
              ),
                  Text(
                    warningText,
                      style: kTextPageStyle.copyWith(color: Colors.red),
                      textAlign: TextAlign.right
                  ),
                  ReusableCard(
                    width: 400,
                    color: Colors.white10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                       "يجب أن تحتوي كلمة المرور على كل مما يلي: \n "
                           "- حرف انجليزي كبير واحد على الأقل \n "
                           "- حرف انجليزي صغير واحد على الأقل \n "
                           "- رقم واحد على الأقل \n"
                           " - يجب أن يكون طول كلمة المرور أكثر من 6 أحرف ",
                        style: kTextPageStyle.copyWith(color: textColor,fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> authEmailandPassword() async{
  EmailAuthCredential credential = EmailAuthProvider.credential(
      email: _emailController.text, password: _passwordController.text);

  var result= await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential);
  print('inside Auth function $result');
  return result;
  }

  void changPassword() async{
    await FirebaseAuth.instance.currentUser.updatePassword(_newPasswordController.text).catchError((e)=> print('#### Errr : $e'));
    print('inside changPass function, it is executed');
  }


  bool isValid(){

    bool hasUppercase = _newPasswordController.text.contains( RegExp(r'[A-Z]'));
    bool hasDigits = _newPasswordController.text.contains( RegExp(r'[0-9]'));
    bool hasLowercase = _newPasswordController.text.contains( RegExp(r'[a-z]'));
    bool hasMinLength = _newPasswordController.text.length > 6;

    return  hasDigits & hasUppercase & hasLowercase & hasMinLength;
  }

}