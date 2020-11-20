import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Constance.dart';
import 'addPostPage.dart';
import 'Post.dart';
import 'Video.dart';
class DiariesTeacher extends StatefulWidget {
  @override
  final String uid;
  final String centerId;
  final String name;
  final String teacherName;
  final String teacherId;

  DiariesTeacher ({this.uid,this.centerId,this.name,this.teacherName,this.teacherId});

  _DiariesTeacherState createState() => _DiariesTeacherState(uid,centerId,name,teacherName,teacherId);
}

class _DiariesTeacherState extends State<DiariesTeacher> {

  String uid;
  String centerId;
  String name;
  String teacherName;
  String teacherId;
  _DiariesTeacherState (String uid, String centerId ,String name,String teacherName,String teacherId) {
    this.uid=uid;
    this.centerId=centerId;
    this.name=name;
    this.teacherName=teacherName;
    this.teacherId=teacherId;
  }


  @override

  DateTime dateSearch=DateTime.now();
  String dateSearch2=DateTime.now().toString().substring(0, 10);
  var dateSearch3;
  final _formkey = GlobalKey<FormState>();
  String comment;
  List<TextEditingController> _controllers = new List();

  Widget build(BuildContext context) {
    List <TextEditingController> cs=[];
    User userTeacher = FirebaseAuth.instance.currentUser;CollectionReference Students = FirebaseFirestore.instance.collection('Students');
    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Teachers = Admin.doc(centerId).collection('Teachers');
    CollectionReference Admin_Students = Admin.doc(centerId).collection('Students');
    return Scaffold(
      body:
        SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream:Admin_Students.doc(uid).collection('Posts').where('date',isEqualTo:dateSearch2).orderBy('createdAt',descending: true).snapshots(),
            builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return  Center(child: SpinKitFoldingCube(
                  color: kUnselectedItemColor,
                  size: 60,
                ),
                );
                  else{
                    return Container(
                      padding: EdgeInsets.all(20) ,
                        constraints: BoxConstraints.expand(),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                            "assets/images/transparent-balloon-icon-party-icon-balloons-icon-5dcb3172c52650.7590878415735975548075.png",),
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                  Colors.white10, BlendMode.dstIn),
                              alignment: Alignment.bottomRight,
                              centerSlice: Rect.zero,
                              scale: 100,
                              matchTextDirection: false
                          ),
                        ),
                        child:ListView(
                          shrinkWrap: true,
                          children: [
                            Center(
                              //alignment: Alignment.bottomLeft,
                              child:Text(dateSearch2,style:TextStyle(color: Colors.grey) ,),),
                            Padding(padding: new EdgeInsets.all(8)),
                            ListView.builder(
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                                itemBuilder: (context,index){
                                DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
                                String  PostId=documentSnapshot.id;
                                  _controllers.add(TextEditingController());
                                  return
                                    Column( children:[
                                      Padding(padding: new EdgeInsets.all(8)),
                                      Column(children:[
                                        Card(
                                          shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          elevation: 5,
                                          child:
                                          Column(
                                            children:[
                                          Padding(
                                            padding: EdgeInsets.only(right: 280),
                                          child:  DeletePost(centerId: centerId,postId: documentSnapshot.id,studentUid: uid,imageUrl: documentSnapshot['imageUrl'] ,videoUrl: documentSnapshot['video'],),),
                                          documentSnapshot['video']!=null ?
                                          Video(documentSnapshot['video'],):Text("",style:TextStyle(fontSize: 0),),
                                          documentSnapshot['imageUrl']!=null ?
                                          Image.network(documentSnapshot['imageUrl'],
                                            loadingBuilder: (BuildContext context, Widget child,
                                            ImageChunkEvent loadingProgress) {
                                           if (loadingProgress == null) return child;
                                               return Center(
                                           child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),backgroundColor: Colors.deepPurple)
                                               );},
                                            width: 2000,
                                            height: 450,
                                          ):Text("",style:TextStyle(fontSize: 0),),
                                           ListTile(
                                            title: Text(documentSnapshot['content'],),),
                                          Padding(padding: EdgeInsets.only(right: 280),
                                            child:  Text(documentSnapshot['hour'].toString()+":"+documentSnapshot['minute'].toString()+" "+documentSnapshot['time'],style: TextStyle(fontSize: 9,color: Colors.grey)),),
                                          Text   ("التعليقات"),
                                          Padding(padding: EdgeInsets.all(0),
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: Admin_Students.doc(uid).collection('Posts').doc(documentSnapshot.id).collection('Comments').orderBy('createdAt',descending: false).snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                if (snapshot.hasData){
                                                  return Column(
                                                      children:
                                                      snapshot.data.docs.map((DocumentSnapshot document) {
                                                             return   Column(
                                                               children: [
                                                                 ListTile(
                                                                   key: Key("${index}"),
                                                                   title: Text(document.data()['writer']+": "+document.data()['comment'],style: TextStyle(fontSize: 13,color: Colors.black),),
                                                                    trailing: Text(document.data()['hour'].toString()+":"+document.data()['minute'].toString()+" "+document.data()['time'],style: TextStyle(fontSize: 9,color: Colors.grey)),
                                                                   onLongPress: (){
                                                                     if(document.data()['writer']==teacherName){
                                                                     showDialog(
                                                                         context: context,
                                                                         builder: (_) => new AlertDialog(
                                                                           content: new Text("هل تريد حذف التعليق"),
                                                                           actions: <Widget>[
                                                                             Row(
                                                                               children: [
                                                                                 FlatButton(
                                                                                   child: Text('حذف',style: TextStyle(color: Colors.deepPurple),),
                                                                                   onPressed: () {

                                                                 var DeltoStudentPost=  Students.doc(uid).collection("Posts").doc(PostId).collection('Comments').doc(document.id).delete();

                                                                 var DeltoAdminStudentPost= Admin_Students.doc(uid).collection('Posts').doc(PostId).collection('Comments').doc(document.id).delete();

                                                                  var DeltoTeacherStudentPost= Teachers.doc(userTeacher.email).collection("Students").doc(uid)
                                                                  .collection('Posts').doc(PostId).collection('Comments').doc(document.id).delete();

                                                                   var DeltoAdminTeacherStudentPost=  Admin_Teachers.doc(userTeacher.email).collection("Students")
                                                                   .doc(uid).collection('Posts').doc(PostId).collection('Comments').doc(document.id).delete();

                                                                        Navigator.of(context).pop();
                                                                                   },
                                                                                 ),
                                                                                 FlatButton(
                                                                                   child: Text('إلغاء',style: TextStyle(color: Colors.deepPurple),),
                                                                                   onPressed: () {
                                                                                     Navigator.of(context).pop();
                                                                                   },
                                                                                 ),
                                                                               ],
                                                                             )
                                                                           ],
                                                                         ));
                                                                 }
                                                                     else{
                                                                       Scaffold.of(context).showSnackBar(SnackBar(
                                                                         content: Text("لا يمكنك حذف التعيلق",style: TextStyle(color: Colors.deepPurple,fontSize: 12)),
                                                                         backgroundColor: Colors.white70,
                                                                         duration: Duration(seconds: 1),
                                                                       ));
                                                                     }},
                                                                 ),
                                                                 Divider(color: Colors.grey,
                                                                 thickness: 0.1,
                                                                 ),
                                                               ],
                                                             );
                                                      }
                                                      ).toList(),
                                                  );

                                                }
                                                else{return Text("");}
                                              }
                                          )
                                          ),
                                            TextFormField(
                                              //keyboardType: TextInputType.multiline,
                                              controller: _controllers[index],
                                             minLines: 1,
                                              maxLines: 5,
                                              decoration: InputDecoration(
                                                suffix: Padding(padding: EdgeInsets.all(1),
                                                child: AddComment(studentName: name,
                                                studentUid: uid,comment: comment,
                                                postId: documentSnapshot.id,    minute: DateTime.now().minute,
                                                  hour: DateTime.now().hour,
                                                  date: DateTime.now().toString().substring(0,10),
                                                  centerId: centerId,writer: teacherName,
                                                  c: _controllers[index], formkey: _formkey,
                                                ) ,),
                                                prefixIcon: Icon(Icons.comment,color: Colors.deepPurple,),
                                                hintText: "إضافة تعليق",
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                                                ),
                                                focusedBorder:  UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                                                ),
                                              ),
                                              onChanged: (value){
                                                setState(() {
                                                comment= value ;
                                                });
                                              }
                                            ),
                                        ],
                                      ),
                                        ),
                                  Padding(padding: EdgeInsets.all(10),),
                                  ],),
                              ]
                                );




    } ),
                          ],
                        )
                    );
                }}
          )
        ),
    floatingActionButton:
    Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(right: 60)),
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    AddPostPage(uid: uid,centerId: centerId,name: name,teacherName: teacherName,)),
              );
            },
            child: Icon(Icons.edit,size: 30,),
            elevation: 10, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, highlightElevation: 20,
            backgroundColor: Colors.deepPurple.shade200,
              foregroundColor: Colors.white60,
          ),
          Padding(padding: EdgeInsets.only(right: 20)),
          FloatingActionButton(
            mini:true,
            heroTag: "btn2",
            onPressed: (){
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  confirmText: "إبحث",
                  firstDate: DateTime(2020, 1),
                  lastDate: DateTime.now(),
                  initialDatePickerMode: DatePickerMode.day,
                  useRootNavigator: false,
                  initialEntryMode: DatePickerEntryMode.input,
                  builder: (BuildContext context, Widget picker){
                    return Theme(
                      //TODO: change colors
                      data: ThemeData.fallback().copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Colors.deepPurple.shade100,
                          onPrimary: Colors.deepPurple,
                          onSurface: Colors.deepPurple,
                        ),
                        dialogBackgroundColor:Colors.white,
                      ),
                      child: picker,);
                  })
                  .then((selectedDate) {
                if(selectedDate!=null){
                  setState(() {
                    dateSearch3=DatePickerEntryMode.input;
                    dateSearch=selectedDate;
                    dateSearch2=dateSearch.toString().substring(0, 10);
                    print(dateSearch2);});
                }
              });

            },
            child: Icon(Icons.search,size: 23,),
            elevation: 10, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, highlightElevation: 20,
            backgroundColor: Colors.deepPurple.shade200,
            foregroundColor: Colors.white60,
          ),
        ],
      ),
    ),
    );


  }
}

