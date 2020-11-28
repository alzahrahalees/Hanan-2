import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constance.dart';
import 'SpecialistStudentMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const kCardColor=Color(0xfff4f4f4);

class SpecialistStudentList extends StatefulWidget {
  @override
  _SpecialistStudentListState createState() => _SpecialistStudentListState();
}

class _SpecialistStudentListState extends State<SpecialistStudentList> {

  String _searchString ='';

  @override
  Widget build(BuildContext context) {
    var _gender='';
    User user = FirebaseAuth.instance.currentUser;
    CollectionReference studentsInSpecia = FirebaseFirestore.instance.collection('Specialists')
        .doc(user.email).collection('Students');
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
              onChanged: (string) {
                setState(() {
                  _searchString = string;
                });
              }),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: studentsInSpecia.snapshots(),
                builder: ( context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: SpinKitFoldingCube(
                        color: kUnselectedItemColor,
                        size: 60,
                      ),
                    );
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: SpinKitFoldingCube(
                        color: kUnselectedItemColor,
                        size: 60,
                      )
                        ,);
                    default:
                      return ListView.builder(
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            DocumentSnapshot document =snapshot.data.docs[index];
                            String name = document.data()['name'];
                            _gender= document.data()['gender'];

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