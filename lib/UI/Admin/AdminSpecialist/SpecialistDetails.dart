import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constance.dart';
import '../AdminMainScreen.dart';

class SpecialistInfo extends StatefulWidget {
  String uid;
  SpecialistInfo(String uid) {
    this.uid=uid;}
  @override
  _SpecialistInfoState createState() => _SpecialistInfoState(uid);
}


class _SpecialistInfoState extends State<SpecialistInfo> {

  String uid;
  _SpecialistInfoState (String uid) {
    this.uid=uid;}

  String gender1;
  List<String> list =["أنثى","ذكر"];
  int selectedIndex;
  void changeIndex(int index) async {
    setState(() {
      selectedIndex = index;
    });}

  Widget RadioButton(String txt, int index) {
    return OutlineButton(
      onPressed: () {
        changeIndex(index);
        selectedIndex == 0 ? gender1 = list[0] : gender1 = list[1];
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(
          color:
          selectedIndex == index ? Colors.deepPurpleAccent : Colors.grey),
      child: Text(txt,
          style: TextStyle(
              color: selectedIndex == index
                  ? Colors.deepPurpleAccent
                  : Colors.grey)),
    );}



  String typeOfSpechalist;
  List<String> items=["أخصائي علاج طبيعي","أخصائي علاج وظيفي","أخصائي نفسي","أخصائي تخاطب"];
  @override
  Widget build(BuildContext context) {
    User userAdmin =  FirebaseAuth.instance.currentUser;
    //Reference
    CollectionReference Specialists = FirebaseFirestore.instance.collection('Specialists');
    CollectionReference Users = FirebaseFirestore.instance.collection('Users');
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Specialists = Admin.doc(userAdmin.email.toLowerCase()).collection('Specialists');

    String gender=gender1;
    String name;
    String age;
    String phone;
    String email;

    final formkey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("معلومات الأخصائي ", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body:
        SafeArea(child:
        StreamBuilder<QuerySnapshot>(
            stream: Admin_Specialists.where('uid' ,isEqualTo:uid ).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              return Container(
                  padding: EdgeInsets.all(10),
                  color: kBackgroundPageColor,
                  alignment: Alignment.topRight,
                  child: Form(
                      key: formkey,
                      // here we add the snapshot from database
                      child:  ListView(shrinkWrap: true, children:
                      snapshot.data.docs.map((DocumentSnapshot document) {
                        name=document.data()['name'];
                        age=document.data()['age'];
                        phone=document.data()['phone'];
                        email=document.data()['email'];
                        //selectedIndex= document.data()['gender']=='ذكر'? 1:0;


                        return Column(children: <Widget>[
                          TextFormField(
                            initialValue: document.data()['name'],

                            decoration: InputDecoration(
                                labelText: "الإسم",
                                labelStyle: TextStyle(color: Colors.deepPurple)
                            ),
                            onChanged: (value){
                              name=value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "لا يمكن تركها فارغة";
                              }
                            },
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          TextFormField(
                            initialValue: document.data()['age'],
                            decoration: InputDecoration(
                                labelText: "العمر"
                            ),
                            onChanged: (value){
                              age=value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "لا يمكن تركها فارغة";
                              }
                            },
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          TextFormField(
                            initialValue: document.data()['email'],
                            readOnly: true,
                            decoration: InputDecoration(
                                helperText: "لا يمكنك تغيير البريد الإلكتروني",
                                labelText: "االبريد الإلكتروني"
                            ),
                            onChanged: (value){
                              email=value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "لا يمكن تركها فارغة";
                              }
                            },
                          ),

                          Padding(padding: EdgeInsets.all(5)),
                          TextFormField(
                            initialValue: document.data()['phone'],
                            decoration: InputDecoration(
                                labelText: "رقم الهاتف"
                            ),
                            onChanged: (value){
                              phone=value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "لا يمكن تركها فارغة";
                              }
                            },
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(children: <Widget>[
                              Text("الجنس",
                                  style: kTextPageStyle.copyWith(
                                      color: Colors.grey)),
                              new Padding(padding: new EdgeInsets.all(5)),
                              Container(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              RadioButton(list[0], 0),
                                              new Padding(padding: new EdgeInsets.all(10)),
                                              RadioButton(list[1], 1),
                                            ],
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(30)),
                                      ]))]),
                          ),
                          new Padding(
                              padding: new EdgeInsets.all(10)),
                          Row(children: <Widget>[
                            new Padding(padding: new EdgeInsets.all(5)),
                            Text("التخصص", style: kTextPageStyle.copyWith(color: Colors.grey)),
                            new Padding(padding: new EdgeInsets.all(7)),
                            Expanded(
                                child: SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: DropdownButton(
                                    hint: Text(document.data()['typeOfSpechalist'],style: TextStyle(color: Colors.black),),
                                    // Not necessary for Option 1
                                    value: typeOfSpechalist,
                                    onChanged: (newValue) {
                                      setState(() {
                                        typeOfSpechalist = newValue;
                                      });
                                    },
                                    items: items.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ))
                          ]),
                          new Padding(
                              padding: new EdgeInsets.all(10)),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(right:90)),
                              RaisedButton(
                                color: kButtonColor,
                                child: Text("تعديل", style: kTextButtonStyle),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                onPressed:() {
                                  if (formkey.currentState.validate()){
                                    Admin_Specialists.doc(uid).update({
                                      'name':name,
                                      'age':age,
                                      'phone':phone,
                                    });
                                    if (gender!=null){
                                      Admin_Specialists.doc(uid).update({
                                        'gender':gender,
                                      });
                                    }
                                    if (typeOfSpechalist!=null){
                                      Admin_Specialists.doc(uid).update({
                                        'typeOfSpechalist':typeOfSpechalist,
                                      });
                                    }
                                    Specialists.doc(uid).update({
                                      'name':name,
                                      'age':age,
                                      'phone':phone,
                                    });
                                    if (gender!=null){
                                      Specialists.doc(uid).update({
                                        'gender':gender,
                                      });
                                    }
                                    if (typeOfSpechalist!=null){
                                      Specialists.doc(uid).update({
                                        'typeOfSpechalist':typeOfSpechalist,
                                      });
                                    }

                                    Users.doc(uid).update({
                                      'name':name,
                                      'age':age,
                                      'phone':phone,
                                    });
                                    if (gender!=null){
                                      Users.doc(uid).update({
                                        'gender':gender,
                                      });
                                    }
                                    if (typeOfSpechalist!=null){
                                      Users.doc(uid).update({
                                        'typeOfSpechalist':typeOfSpechalist,
                                      });
                                    }

                                    Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainAdminScreen(1)));
                                  }
                                },

                              ),

                              Padding(padding: EdgeInsets.all(5)),
                              RaisedButton(
                                  color: kButtonColor,
                                  child: Text("الغاء", style: kTextButtonStyle),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0)),
                                  onPressed:(){
                                    Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainAdminScreen(1)));}


                              )  ],
                          ),
                        ]);
                      }).toList()
                      )
                  )
              );
            } )
        ));
  }
}
