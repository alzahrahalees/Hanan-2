import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Constance.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Profile extends StatefulWidget {
  final String uid;
  Profile({this.uid});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid= widget.uid;

  }

  //all Path
  //get type

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: kUnselectedItemColor),
          backgroundColor: kAppBarColor,
          title: Text('الصفحة الشخصية', style: kTextAppBarStyle,textAlign: TextAlign.center,),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          color: kBackgroundPageColor,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser.email.toLowerCase())
                .snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return SpinKitFoldingCube(
                  color: kUnselectedItemColor,
                  size: 60,
                );
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return SpinKitFoldingCube(
                  color: kUnselectedItemColor,
                  size: 60,
                );
              }
              DocumentSnapshot document= snapshot.data;
              var type = document.data()['type'];

               String arabicTypeF(){
                 var arabicType;
                if(document.data()['type']=='Admin'){
                  arabicType='مدير/ة الحساب';
                }
                else if(document.data()['type']=='Teachers'){
                  arabicType='معلم/ـة';
                }
                else if(document.data()['type']=='Specialists'){
                  arabicType= 'اخصائي/ـة';
                }
                else if(document.data()['type']=='Students'){
                  arabicType='طالب/ـة';
                }
                return arabicType;
              };
               String currentEmail = FirebaseAuth.instance.currentUser.email;
              CollectionReference users = FirebaseFirestore.instance.collection('Users');
              CollectionReference admin = FirebaseFirestore.instance.collection('Centers');
              String name =document.data()['name'];
              String phone = document.data()['phone'];
              String newName;
              String newPhone;

              bool isAdmin= type=='Admin';

              return Form(
                key: formkey,
                child: ListView(
                  children: [
                    ProfileTile(
                      readOnly: isAdmin? false:true ,
                      color: kWolcomeBkg,
                      icon: Icons.person,
                      hintTitle: 'الاسم',
                      title:document.data()['name'],
                      onChanged: (value){
                        newName= value;
                      },
                    ),
                    ProfileTile(
                      readOnly: true,
                      color: kWolcomeBkg,
                      icon: Icons.email,
                      hintTitle: 'الإيميل',
                      title:document.data()['email'],
                    ),
                    ProfileTile(
                      readOnly: isAdmin? false:true,
                      color: kWolcomeBkg,
                      icon: Icons.phone,
                      hintTitle: 'رقم الهاتف',
                      title:document.data()['phone'],
                      onChanged: (value){
                        newPhone=value;
                      },
                    ),

                    (isAdmin)? SizedBox() : ProfileTile(
                      readOnly: true,
                      color: kWolcomeBkg,
                      icon: Icons.assistant_outlined,
                      hintTitle: 'العمر',
                      title:document.data()['age'],
                    ),
                    (isAdmin)? SizedBox() : ProfileTile(
                      readOnly: true,
                      color: kWolcomeBkg,
                      icon: Icons.accessibility,
                      hintTitle: 'الجنس',
                      title:document.data()['gender'],
                    ),
                    ProfileTile(
                      readOnly: true,
                      color: kWolcomeBkg,
                      icon: Icons.info,
                      hintTitle: 'الوظيفة',
                      title:arabicTypeF(),
                    ),
                    type=="Specialists"? ProfileTile(
                      readOnly:true,
                      color: kWolcomeBkg,
                      icon: Icons.info,
                      hintTitle: 'التخصص',
                      title:document.data()['typeOfSpechalist'],
                    ):Text(""),

                    isAdmin? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 20),
                        child: Container(
                          width: 100,
                          child: RaisedButton(
                            color: kButtonColor,
                            child: Text("تعديل", style: kTextButtonStyle),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            onPressed: (){
                              if (formkey.currentState.validate()){
                                users.doc(currentEmail).update({
                                  'name': newName==null? name: newName,
                                  'phone': newPhone==null? phone: newPhone,
                                });
                                admin.doc(currentEmail).update({
                                  'name': newName==null? name: newName,
                                  'phone': newPhone==null? phone: newPhone,
                                });
                                Navigator.pop(context);
                              }
                            },

                          ),
                        ),
                      ),
                    ):SizedBox(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}

// final Icon icon;
//   final String hintTitle;
//   final String title;
//   final Color color;