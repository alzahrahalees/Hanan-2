import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Constance.dart';
import 'package:hanan/UI/Specialists/Plans/GoalAnalysisS.dart';


//plan pages for 6 majors ..
class SpecialMajorsPageS extends StatefulWidget {
  final String studentId;
  final String planId;
  SpecialMajorsPageS({this.studentId,this.planId});
  @override
  _SpecialMajorsPageSState createState() => _SpecialMajorsPageSState();
}

class _SpecialMajorsPageSState extends State<SpecialMajorsPageS>  with TickerProviderStateMixin{

  @override
  void dispose() {
    super.dispose();
  }
  TabController controller;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    User _userSpecialist = FirebaseAuth.instance.currentUser;
    CollectionReference studentsPlansGoal = FirebaseFirestore.instance.collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");
    CollectionReference specialistPlansGoal =FirebaseFirestore.instance.collection('Specialists').doc(_userSpecialist.email).collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");


    if(controller == null) {
      controller=new TabController(length: 6, vsync: this);
    }
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: kAppBarColor,
            toolbarHeight: 75,
            bottom: TabBar(
              indicatorWeight: 2,
              isScrollable: true,
              controller:controller,
              labelColor: kSelectedItemColor,
              indicatorColor: kSelectedItemColor,
              unselectedLabelColor: kUnselectedItemColor,
              tabs:
              [
                Tab(text: 'مجال الانتباه والتركيز'),
                Tab(text: 'مجال التواصل'),
                Tab(text: 'المجال الإدراكي'),
                Tab(text: 'المجال الحركي الدقيق'),
                Tab(text: 'المجال الاجتماعي'),
                Tab(text: 'المجال الاستقلالي'),
              ],
            ),
          ),
          body:TabBarView(
            controller: controller,
            children: [
              SafeArea(
                  child: StreamBuilder<QuerySnapshot>(
                      stream:
                      specialistPlansGoal.where('goalType',isEqualTo: 'مجال الانتباه والتركيز').orderBy('createdAt',descending: true).snapshots(),
                      builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData){
                          return  Center(child: SpinKitFoldingCube(
                            color: kUnselectedItemColor,
                            size: 60,
                          ));}
                        else{return Container(
                          color: Colors.white70,
                          child:ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder:(context,index){
                                DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
                                return Column(
                                    children:[
                                      Padding(padding: EdgeInsets.all(5)),
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(context,MaterialPageRoute(builder: (context) =>GoalAnalysisMainS(studentId: widget.studentId,planId: widget.planId,goalId: documentSnapshot["goalId"],)));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(10),
                                                  topRight: Radius.circular(10)),
                                              side: BorderSide(width: 2, color: Colors.deepPurple.shade200)),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                  title:    Center(
                                                    child: Text(documentSnapshot['goalTitle']),
                                                  ),
                                                  leading: Icon(Icons.title,color: Colors.indigoAccent,),
                                              ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              Center(child: Text("الهدف العام:",style: TextStyle(color: Colors.deepPurple,fontSize: 10),)),
                                              ListTile(
                                                title:Text(documentSnapshot['generalGoal'],style:TextStyle(color: Colors.black,fontSize: 15)),
                                                leading: Icon(Icons.lightbulb,color: Colors.amber),

                                              ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              documentSnapshot["image"] !=null?
                                              ListTile(
                                                title:  Image.network(documentSnapshot["image"],loadingBuilder: (BuildContext context, Widget child,
                                                    ImageChunkEvent loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Center(
                                                      child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),backgroundColor: Colors.deepPurple));},
                                                  width: 1500,
                                                  height: 300,),
                                                leading: Icon(Icons.image,color: Colors.deepOrangeAccent),
                                              ):Text("",style: TextStyle(fontSize: 0),),
                                              ListTile(
                                                title:Container(child: Text(" تم إنشاؤه  ${documentSnapshot['date']}",style:TextStyle(color: Colors.grey,fontSize: 8)),
                                                  alignment:Alignment.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.all(3)),]
                                );
                              }
                          ) ,
                        );}
                      })),
              // 2
              SafeArea(
                  child: StreamBuilder<QuerySnapshot>(
                      stream:specialistPlansGoal.where('goalType',isEqualTo:'مجال التواصل').orderBy('createdAt',descending: true).snapshots(),
                      builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData){
                          return  Center(child: SpinKitFoldingCube(
                            color: kUnselectedItemColor,
                            size: 60,
                          ));}
                        else{return Container(
                          color: Colors.white70,
                          child:ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder:(context,index){
                                DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
                                return Column(
                                    children:[
                                      Padding(padding: EdgeInsets.all(5)),
                                      GestureDetector(
                                        onTap:(){
                                         Navigator.push(context,MaterialPageRoute(builder: (context) =>GoalAnalysisMainS(studentId: widget.studentId,planId: widget.planId,goalId: documentSnapshot["goalId"],)));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(10),
                                                  topRight: Radius.circular(10)),
                                              side: BorderSide(width: 2, color: Colors.deepPurple.shade200)),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                  title:    Center(
                                                    child: Text(documentSnapshot['goalTitle']),
                                                  ),
                                                  leading: Icon(Icons.title,color: Colors.indigoAccent,),
                                                  ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              Center(child: Text("الهدف العام:",style: TextStyle(color: Colors.deepPurple,fontSize: 10),)),
                                              ListTile(
                                                title:Text(documentSnapshot['generalGoal'],style:TextStyle(color: Colors.black,fontSize: 15)),
                                                leading: Icon(Icons.lightbulb,color: Colors.amber),
                                              ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              documentSnapshot["image"] !=null?
                                              ListTile(
                                                title:  Image.network(documentSnapshot["image"],loadingBuilder: (BuildContext context, Widget child,
                                                    ImageChunkEvent loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Center(
                                                      child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),backgroundColor: Colors.deepPurple));},
                                                  width: 1500,
                                                  height: 300,),
                                                leading: Icon(Icons.image,color: Colors.deepOrangeAccent),
                                              ):Text("",style: TextStyle(fontSize: 0),),
                                              ListTile(
                                                title:Container(child: Text(" تم إنشاؤه  ${documentSnapshot['date']}",style:TextStyle(color: Colors.grey,fontSize: 8)),
                                                  alignment:Alignment.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.all(3)),]
                                );
                              }
                          ) ,
                        );}
                      })),
              //3
              SafeArea(
                  child: StreamBuilder<QuerySnapshot>(
                      stream:specialistPlansGoal.where('goalType',isEqualTo: 'المجال الإدراكي').orderBy('createdAt',descending: true).snapshots(),
                      builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData){
                          return  Center(child: SpinKitFoldingCube(
                            color: kUnselectedItemColor,
                            size: 60,
                          ));}
                        else{return Container(
                          color: Colors.white70,
                          child:ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder:(context,index){
                                DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
                                return Column(
                                    children:[
                                      Padding(padding: EdgeInsets.all(5)),
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(context,MaterialPageRoute(builder: (context) =>GoalAnalysisMainS(studentId: widget.studentId,planId: widget.planId,goalId: documentSnapshot["goalId"],)));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(10),
                                                  topRight: Radius.circular(10)),
                                              side: BorderSide(width: 2, color: Colors.deepPurple.shade200)),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                  title:    Center(
                                                    child: Text(documentSnapshot['goalTitle']),
                                                  ),
                                                  leading: Icon(Icons.title,color: Colors.indigoAccent,),
                                                 ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              Center(child: Text("الهدف العام:",style: TextStyle(color: Colors.deepPurple,fontSize: 10),)),
                                              ListTile(
                                                title:Text(documentSnapshot['generalGoal'],style:TextStyle(color: Colors.black,fontSize: 15)),
                                                leading: Icon(Icons.lightbulb,color: Colors.amber),
                                              ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              documentSnapshot["image"] !=null?
                                              ListTile(
                                                title:  Image.network(documentSnapshot["image"],loadingBuilder: (BuildContext context, Widget child,
                                                    ImageChunkEvent loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Center(
                                                      child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),backgroundColor: Colors.deepPurple));},
                                                  width: 1500,
                                                  height: 300,),
                                                leading: Icon(Icons.image,color: Colors.deepOrangeAccent),
                                              ):Text("",style: TextStyle(fontSize: 0),),
                                              ListTile(
                                                title:Container(child: Text(" تم إنشاؤه  ${documentSnapshot['date']}",style:TextStyle(color: Colors.grey,fontSize: 8)),
                                                  alignment:Alignment.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.all(3)),]
                                );
                              }
                          ) ,
                        );}
                      })),
              //4
              SafeArea(
                  child: StreamBuilder<QuerySnapshot>(
                      stream:specialistPlansGoal.where('goalType',isEqualTo:'المجال الحركي الدقيق').orderBy('createdAt',descending: true).snapshots(),
                      builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData){
                          return  Center(child: SpinKitFoldingCube(
                            color: kUnselectedItemColor,
                            size: 60,
                          ));}
                        else{return Container(
                          color: Colors.white70,
                          child:ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder:(context,index){
                                DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
                                return Column(
                                    children:[
                                      Padding(padding: EdgeInsets.all(5)),
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(context,MaterialPageRoute(builder: (context) =>GoalAnalysisMainS(studentId: widget.studentId,planId: widget.planId,goalId: documentSnapshot["goalId"],)));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(10),
                                                  topRight: Radius.circular(10)),
                                              side: BorderSide(width: 2, color: Colors.deepPurple.shade200)),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                  title:    Center(
                                                    child: Text(documentSnapshot['goalTitle']),
                                                  ),
                                                  leading: Icon(Icons.title,color: Colors.indigoAccent,),
                                                  ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              Center(child: Text("الهدف العام:",style: TextStyle(color: Colors.deepPurple,fontSize: 10),)),
                                              ListTile(
                                                title:Text(documentSnapshot['generalGoal'],style:TextStyle(color: Colors.black,fontSize: 15)),
                                                leading: Icon(Icons.lightbulb,color: Colors.amber),
                                              ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              documentSnapshot["image"] !=null?
                                              ListTile(
                                                title:  Image.network(documentSnapshot["image"],loadingBuilder: (BuildContext context, Widget child,
                                                    ImageChunkEvent loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Center(
                                                      child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),backgroundColor: Colors.deepPurple));},
                                                  width: 1500,
                                                  height: 300,),
                                                leading: Icon(Icons.image,color: Colors.deepOrangeAccent),
                                              ):Text("",style: TextStyle(fontSize: 0),),
                                              ListTile(
                                                title:Container(child: Text(" تم إنشاؤه  ${documentSnapshot['date']}",style:TextStyle(color: Colors.grey,fontSize: 8)),
                                                  alignment:Alignment.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.all(3)),]
                                );
                              }
                          ) ,
                        );}
                      })),
              //5
              SafeArea(
                  child: StreamBuilder<QuerySnapshot>(
                      stream:specialistPlansGoal.where('goalType',isEqualTo: 'المجال الاجتماعي').orderBy('createdAt',descending: true).snapshots(),
                      builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData){
                          return  Center(child: SpinKitFoldingCube(
                            color: kUnselectedItemColor,
                            size: 60,
                          ));}
                        else{return Container(
                          color: Colors.white70,
                          child:ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder:(context,index){
                                DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
                                return Column(
                                    children:[
                                      Padding(padding: EdgeInsets.all(5)),
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(context,MaterialPageRoute(builder: (context) =>GoalAnalysisMainS(studentId: widget.studentId,planId: widget.planId,goalId: documentSnapshot["goalId"],)));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(10),
                                                  topRight: Radius.circular(10)),
                                              side: BorderSide(width: 2, color: Colors.deepPurple.shade200)),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                  title:    Center(
                                                    child: Text(documentSnapshot['goalTitle']),
                                                  ),
                                                  leading: Icon(Icons.title,color: Colors.indigoAccent,),
                                                  ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              Center(child: Text("الهدف العام:",style: TextStyle(color: Colors.deepPurple,fontSize: 10),)),
                                              ListTile(
                                                title:Text(documentSnapshot['generalGoal'],style:TextStyle(color: Colors.black,fontSize: 15)),
                                                leading: Icon(Icons.lightbulb,color: Colors.amber),
                                              ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              documentSnapshot["image"] !=null?
                                              ListTile(
                                                title:  Image.network(documentSnapshot["image"],loadingBuilder: (BuildContext context, Widget child,
                                                    ImageChunkEvent loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Center(
                                                      child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),backgroundColor: Colors.deepPurple));},
                                                  width: 1500,
                                                  height: 300,),
                                                leading: Icon(Icons.image,color: Colors.deepOrangeAccent),
                                              ):Text("",style: TextStyle(fontSize: 0),),
                                              ListTile(
                                                title:Container(child: Text(" تم إنشاؤه  ${documentSnapshot['date']}",style:TextStyle(color: Colors.grey,fontSize: 8)),
                                                  alignment:Alignment.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.all(3)),]
                                );
                              }
                          ) ,
                        );}
                      })),
              //6
              SafeArea(
                  child: StreamBuilder<QuerySnapshot>(
                      stream:specialistPlansGoal.where('goalType',isEqualTo:  'المجال الاستقلالي').orderBy('createdAt',descending: true).snapshots(),
                      builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData){
                          return  Center(child: SpinKitFoldingCube(
                            color: kUnselectedItemColor,
                            size: 60,
                          ));}
                        else{return Container(
                          color: Colors.white70,
                          child:ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder:(context,index){
                                DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
                                return Column(
                                    children:[
                                      Padding(padding: EdgeInsets.all(5)),
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(context,MaterialPageRoute(builder: (context) =>GoalAnalysisMainS(studentId: widget.studentId,planId: widget.planId,goalId: documentSnapshot["goalId"],)));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(10),
                                                  topRight: Radius.circular(10)),
                                              side: BorderSide(width: 2, color: Colors.deepPurple.shade200)),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                  title:    Center(
                                                    child: Text(documentSnapshot['goalTitle']),
                                                  ),
                                                  leading: Icon(Icons.title,color: Colors.indigoAccent,),
                                                  ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              Center(child: Text("الهدف العام:",style: TextStyle(color: Colors.deepPurple,fontSize: 10),)),
                                              ListTile(
                                                title:Text(documentSnapshot['generalGoal'],style:TextStyle(color: Colors.black,fontSize: 15)),
                                                leading: Icon(Icons.lightbulb,color: Colors.amber),
                                              ),
                                              Divider(thickness: 0.2,color: Colors.grey),
                                              documentSnapshot["image"] !=null?
                                              ListTile(
                                                title:  Image.network(documentSnapshot["image"],loadingBuilder: (BuildContext context, Widget child,
                                                    ImageChunkEvent loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Center(
                                                      child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),backgroundColor: Colors.deepPurple));},
                                                  width: 1500,
                                                  height: 300,),
                                                leading: Icon(Icons.image,color: Colors.deepOrangeAccent),
                                              ):Text("",style: TextStyle(fontSize: 0),),
                                              ListTile(
                                                title:Container(child: Text(" تم إنشاؤه  ${documentSnapshot['date']}",style:TextStyle(color: Colors.grey,fontSize: 8)),
                                                  alignment:Alignment.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.all(3)),]
                                );
                              }
                          ) ,
                        );}})),
            ],
          )
      ),
    );
  }
}


