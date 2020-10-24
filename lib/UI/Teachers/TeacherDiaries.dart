import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';
import '../Constance.dart';
import 'addPostPage.dart';
import 'Post.dart';
class DiariesTeacher extends StatefulWidget {
  @override
  final String uid;
  final String centerId;
  final String name;
  final String teacherName;
  DiariesTeacher ({this.uid,this.centerId,this.name,this.teacherName});

  _DiariesTeacherState createState() => _DiariesTeacherState(uid,centerId,name,teacherName);
}

class _DiariesTeacherState extends State<DiariesTeacher> {

  String uid;
  String centerId;
  String name;
  String teacherName;

  _DiariesTeacherState (String uid, String centerId ,String name,String teacherName) {
    this.uid=uid;
    this.centerId=centerId;
    this.name=name;
    this.teacherName=teacherName;}
  TextEditingController c = new TextEditingController();

  List <TextEditingController> cs=[];



  @override

  DateTime dateSearch=DateTime.now();
  String dateSearch2=DateTime.now().toString().substring(0, 10);
  var dateSearch3;
  final _formkey = GlobalKey<FormState>();
  String comment;
  List<TextEditingController> _controllers = new List();
  int i=-1;


  Widget build(BuildContext context) {
    List <TextEditingController> cs=[];

    User userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference Students =
    FirebaseFirestore.instance.collection('Students');
    CollectionReference Teachers =
    FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Admin =
    FirebaseFirestore.instance.collection('Centers');
    CollectionReference Admin_Teachers =
    Admin.doc(centerId).collection('Teachers');
    CollectionReference Admin_Students =
    Admin.doc(centerId).collection('Students');
    return Scaffold(
      body: SafeArea(
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
                        image: DecorationImage(image: AssetImage(
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
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                           /*  snapshot.connectionState == ConnectionState.done?
                                   AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  )
                                :
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                          GestureDetector(
                            onTap: () {
                              // Wrap the play or pause in a call to `setState`. This ensures the
                              // correct icon is shown
                              setState(() {
                                // If the video is playing, pause it.
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  // If the video is paused, play it.
                                  _controller.play();
                                }
                              });
                            },
                            // Display the correct icon depending on the state of the player.
                            child: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                          ),*/

                          Center(
                            //alignment: Alignment.bottomLeft,
                            child:Text(dateSearch2,style:TextStyle(color: Colors.grey) ,),),
                          Padding(padding: new EdgeInsets.all(8)),

                          Column( children:

                          snapshot.data.docs.map((DocumentSnapshot document) {
                            String  PostId=document.id;
                            cs.add(new TextEditingController());
                            return Column(children:[

                              Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 5,
                                child:
                                Column(
                                  children:[
                                    Padding(padding: EdgeInsets.only(right: 300),
                                    child:  DeletePost(centerId: centerId,postId: document.id,studentUid: uid,imageUrl: document.data()['imageUrl'] ,),),
                                    document.data()['imageUrl']!=null ?
                                    Image.network(document.data()['imageUrl'],
                                      width: 1500,
                                      height: 500,
                                    )  :
                                        Text("",style:TextStyle(fontSize: 0),),
                                     ListTile(
                                      title: Text(document.data()['content'],),),
                                    Padding(padding: EdgeInsets.only(right: 280),
                                      child:  Text(document.data()['hour'].toString()+":"+document.data()['minute'].toString()+" "+document.data()['time'],style: TextStyle(fontSize: 9,color: Colors.grey)),),
                                    Text   ("التعليقات"),
                                    Padding(padding: EdgeInsets.all(0),
                                    child: StreamBuilder<QuerySnapshot>(
                                        stream: Admin_Students.doc(uid).collection('Posts').doc(document.id).collection('Comments').orderBy('createdAt',descending: false).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (snapshot.hasData){
                                            return Column(
                                                children:
                                                snapshot.data.docs.map((DocumentSnapshot document) {
                                                       return   Column(
                                                         children: [
                                                           ListTile(
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
                                      controller: c,
                                     minLines: 1,
                                      maxLines: 5,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        suffix: Padding(padding: EdgeInsets.all(1),
                                        child: AddComment(studentName: name,
                                        studentUid: uid,comment: comment,
                                        postId: document.id,    minute: DateTime.now().minute,
                                          hour: DateTime.now().hour,
                                          date: DateTime.now().toString().substring(0,10),
                                          centerId: centerId,writer: teacherName,
                                          c: c, formkey: _formkey,
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
                                      textInputAction: TextInputAction.unspecified,
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
                            ],);
                          }
                          ).toList(),


                          ),


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
                MaterialPageRoute(builder: (context) => AddPostPage(uid: uid,centerId: centerId,name: name)),
              );
            },
            child: Icon(Icons.edit,size: 30,),
            elevation: 10, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, highlightElevation: 20,
              mini: false,
            backgroundColor: Colors.deepPurple.shade200,
              foregroundColor: Colors.white60,
          ),
          Padding(padding: EdgeInsets.only(right: 60)),
          FloatingActionButton(
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
            child: Icon(Icons.search,size: 30,),
            elevation: 10, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, highlightElevation: 20,
            mini: false,
            backgroundColor: Colors.deepPurple.shade200,
            foregroundColor: Colors.white60,
          ),
        ],
      ),
    ),
    );
  }
}

