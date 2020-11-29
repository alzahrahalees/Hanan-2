import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'SpecialistStudentMain.dart';
import '../Constance.dart';

class ReadStudents extends StatefulWidget {
  @override
  _ReadStudentsState createState() => _ReadStudentsState();
}

class _ReadStudentsState extends State<ReadStudents> {
  @override
  String _searchString ='';
  CollectionReference students = FirebaseFirestore.instance.collection('Students');
  String specialistTypeId='communicationSpecialistId';
  User userSpecialist = FirebaseAuth.instance.currentUser;
  void getType() async {
    await FirebaseFirestore.instance
        .collection('Specialists')
        .doc(userSpecialist.email)
        .get()
        .then((data) {
      if (data.data()['typeOfSpechalist'] == 'أخصائي تخاطب') {
        setState(() {
          specialistTypeId = 'communicationSpecialistId';
        });
      }
      if (data.data()['typeOfSpechalist'] == "أخصائي نفسي") {
        setState(() {
          specialistTypeId = 'psychologySpecialistId';
        });
      }
      if (data.data()['typeOfSpechalist'] == "أخصائي علاج وظيفي") {
        setState(() {
          specialistTypeId = 'occupationalSpecialistId';
        });
      }
      if (data.data()['typeOfSpechalist'] == "أخصائي علاج طبيعي") {
        setState(() {
          specialistTypeId = 'physiotherapySpecialistId';
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getType();
  }
  Widget build(BuildContext context) {

    return Container(
      color: kBackgroundPageColor,
      child: Column(
        children: [
          TextField(
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple,width: 2)),
                contentPadding: EdgeInsets.all(10),
                hintText: "أدخل اسم الطالب",
                prefixIcon: Icon(Icons.search,color: Colors.deepPurple,),
              ),
              onChanged: (string) async {
                setState(() {
                  _searchString = string;
                });
              }),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(stream:
                students.where(specialistTypeId,isEqualTo: userSpecialist.email).snapshots(),
                builder: ( context, snapshot) {
                  if (!snapshot.hasData){
                    return Center(
                      child: SpinKitFoldingCube(
                        color: kUnselectedItemColor,
                        size: 60,
                      ),
                    );}
                    else {
                      return ListView.builder(
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            DocumentSnapshot document =snapshot.data.docs[index];
                            String name = document.data()['name'];
                            String _gender= document.data()['gender'];

                            if(name.toLowerCase().contains(_searchString) || name.toUpperCase().contains(_searchString.toUpperCase())){
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      color: kCardColor,
                                      borderOnForeground: true,
                                      child: ListTile(
                                          leading: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.star,
                                                color:_gender=='ذكر'?Color(0xff7e91cc):Color(0xffdb9bd2)),
                                          ),
                                          onTap: (){Navigator.push(context,
                                              MaterialPageRoute(builder: (context)=>
                                                  SpecialistStudentMain(uid:document.data()['uid'],centerId: document.data()['center'],name: document.data()['name'],index: 0,teacherName: document.data()['teacherName'],teacherId: document.data()['teacherId'],
                                                    communicationSpecialistName:document.data()['communicationSpecialistName'] ,
                                                    communicationSpecialistId: document.data()['communicationSpecialistId'],
                                                    physiotherapySpecialistId:document.data()['physiotherapySpecialistId'] ,
                                                    physiotherapySpecialistName:document.data()['physiotherapySpecialistName'] ,
                                                    psychologySpecialistId:document.data()['psychologySpecialistId'] ,
                                                    psychologySpecialistName:document.data()['psychologySpecialistName'] ,
                                                    occupationalSpecialistId: document.data()['occupationalSpecialistId'],
                                                    occupationalSpecialistName:document.data()['occupationalSpecialistName'] ,)));},
                                          title: Text(document.data()['name'] , style: kTextPageStyle))
                                  )
                              );
                            }
                            else return SizedBox();

                          }
                      );
                  }} ),

          ),
        ],
      ),
    );


  }
}
