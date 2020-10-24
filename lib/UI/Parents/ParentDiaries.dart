import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Teachers/Post.dart';
import 'package:image_downloader/image_downloader.dart';
import '../Constance.dart';

class ParentDiaries extends StatefulWidget {
  @override
  _ParentDiariesState createState() => _ParentDiariesState();
}

class _ParentDiariesState extends State<ParentDiaries> {
  @override
  final _formkey = GlobalKey<FormState>();
  String comment;
  DateTime dateSearch=DateTime.now();
  String dateSearch2=DateTime.now().toString().substring(0, 10);

  Widget build(BuildContext context) {
    User userStudent = FirebaseAuth.instance.currentUser;
    CollectionReference Students = FirebaseFirestore.instance.collection('Students');
    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
    return Scaffold(
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: Students.doc(userStudent.email).collection('Posts').where('date',isEqualTo:dateSearch2).orderBy('createdAt', descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(child: SpinKitFoldingCube(
                    color: kUnselectedItemColor,
                    size: 60,
                  ),
                  );
                else {
                  return Container(
                      padding: EdgeInsets.all(20),
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/transparent-balloon-icon-party-icon-balloons-icon-5dcb3172c52650.7590878415735975548075.png",),
                            fit: BoxFit.contain,
                            colorFilter:
                                ColorFilter.mode(Colors.white10, BlendMode.dstIn),
                            alignment: Alignment.bottomRight,
                            centerSlice: Rect.zero,
                            scale: 100,
                            matchTextDirection: false),
                      ),
                      child: Form(
                          key: _formkey,
                          child:ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Center(
                                //alignment: Alignment.bottomLeft,
                                child:Text(dateSearch2,style:TextStyle(color: Colors.grey) ,),),
                              Padding(padding: new EdgeInsets.all(8)),
                             Column(
                                  children: snapshot.data.docs
                                      .map((DocumentSnapshot document) {
                                    String PostId = document.id;
                                    String Name = document.data()['studentName'];
                                    String CenterId = document.data()['centerId'];
                                    String Uid = document.data()['uid'];
                                    String Writer = document.data()['studentName'];
                                    User userTeacher = FirebaseAuth.instance.currentUser;
                                    CollectionReference Students = FirebaseFirestore.instance.collection('Students');
                                    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
                                    CollectionReference Admin = FirebaseFirestore.instance.collection('Centers');
                                    CollectionReference Admin_Teachers = Admin.doc(CenterId).collection('Teachers');
                                    CollectionReference Admin_Students = Admin.doc(CenterId).collection('Students');

                                    return Column(
                                      children: [
                                        Card(
                                          shape: BeveledRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              document.data()['imageUrl']!=null ?
                                              Column(
                                                children: [
                                                  Container(
                                                    child: IconButton(icon: Icon(Icons.file_download,color: Colors.deepPurpleAccent.shade100,), onPressed:() async {
                                                      var imageId = await ImageDownloader
                                                          .downloadImage(document
                                                          .data()['imageUrl']);
                                                      var path = await ImageDownloader
                                                          .findPath(imageId);
                                                      File image = File(path);
                                                        Scaffold.of(context).showSnackBar(SnackBar(
                                                            content: Text("تم حفظ الصورة بنجاح",style: TextStyle(color: Colors.deepPurple,fontSize: 12)),
                                                            backgroundColor: Colors.white70,
                                                            duration: Duration(seconds: 1)));
                                                      }),
                                                    alignment: Alignment.centerLeft,
                                                  ),
                                                    Image.network(document.data()['imageUrl'],
                                                      width: 1500,
                                                      height: 500,
                                                    ),
                                                ],
                                              )  :
                                              Text("\n"),
                                              ListTile(
                                                title: Text(
                                                  document.data()['content'],
                                                ),
                                                trailing: Text(
                                                    document
                                                            .data()['hour']
                                                            .toString() +
                                                        ":" +
                                                        document
                                                            .data()['minute']
                                                            .toString() +
                                                        " " +
                                                        document.data()['time'],
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.grey)),
                                              ),
                                              Text("التعليقات"),
                                              Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: StreamBuilder<QuerySnapshot>(
                                                      stream: Students.doc(
                                                              userStudent.email)
                                                          .collection('Posts')
                                                          .doc(PostId)
                                                          .collection('Comments')
                                                          .orderBy('createdAt',
                                                              descending: false)
                                                          .snapshots(),
                                                      builder: (BuildContext context,
                                                          AsyncSnapshot<QuerySnapshot>
                                                              snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Column(
                                                            children: snapshot
                                                                .data.docs
                                                                .map((DocumentSnapshot
                                                                    document) {
                                                              return Column(
                                                                children: [
                                                                  ListTile(
                                                                      title: Text(
                                                                        document.data()[
                                                                                'writer'] +
                                                                            ": " +
                                                                            document.data()[
                                                                                'comment'],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color: Colors
                                                                                .black),
                                                                      ),
                                                                      trailing: Text(
                                                                          document
                                                                                  .data()[
                                                                                      'hour']
                                                                                  .toString() +
                                                                              ":" +
                                                                              document
                                                                                  .data()[
                                                                                      'minute']
                                                                                  .toString() +
                                                                              " " +
                                                                              document.data()[
                                                                                  'time'],
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  9,
                                                                              color: Colors
                                                                                  .grey)),
                                                                      onLongPress:
                                                                          () {
                                                                        if (document.data()[
                                                                                'writer'] ==
                                                                            Name) {
                                                                          showDialog(
                                                                              context:
                                                                                  context,
                                                                              builder: (_) =>
                                                                                  new AlertDialog(
                                                                                    content: new Text("هل تريد حذف التعليق"),
                                                                                    actions: <Widget>[
                                                                                      Row(
                                                                                        children: [
                                                                                          FlatButton(
                                                                                            child: Text(
                                                                                              'حذف',
                                                                                              style: TextStyle(color: Colors.deepPurple),
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              var DeltoStudentPost = Students.doc(Uid).collection("Posts").doc(PostId).collection('Comments').doc(document.id).delete();

                                                                                              var DeltoAdminStudentPost = Admin_Students.doc(Uid).collection('Posts').doc(PostId).collection('Comments').doc(document.id).delete();

                                                                                              var DeltoTeacherStudentPost = Teachers.doc(userTeacher.email).collection("Students").doc(Uid).collection('Posts').doc(PostId).collection('Comments').doc(document.id).delete();

                                                                                              var DeltoAdminTeacherStudentPost = Admin_Teachers.doc(userTeacher.email).collection("Students").doc(Uid).collection('Posts').doc(PostId).collection('Comments').doc(document.id).delete();

                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          ),
                                                                                          FlatButton(
                                                                                            child: Text(
                                                                                              'إلغاء',
                                                                                              style: TextStyle(color: Colors.deepPurple),
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ));
                                                                        } else {
                                                                          Scaffold.of(
                                                                                  context)
                                                                              .showSnackBar(
                                                                                  SnackBar(
                                                                            content: Text(
                                                                                "لا يمكنك حذف تعيلق المعلم",
                                                                                style: TextStyle(
                                                                                    color: Colors.deepPurple,
                                                                                    fontSize: 12)),
                                                                            backgroundColor:
                                                                                Colors
                                                                                    .white70,
                                                                            duration: Duration(
                                                                                seconds:
                                                                                    1),
                                                                          ));
                                                                        }
                                                                      }),
                                                                  Divider(
                                                                    color:
                                                                        Colors.grey,
                                                                    thickness: 0.1,
                                                                  ),
                                                                ],
                                                              );
                                                            }).toList(),
                                                          );
                                                        } else {
                                                          return Text("");
                                                        }
                                                      })),
                                              TextFormField(
                                                //keyboardType: TextInputType.multiline,
                                                minLines: 1,
                                                maxLines: 5,
                                                showCursor: true,
                                                decoration: InputDecoration(
                                                  suffix: Padding(
                                                      padding: EdgeInsets.all(1),
                                                      child: AddComment(
                                                        writer: Writer,
                                                        studentUid: Uid,
                                                        studentName: Name,
                                                        minute: DateTime.now().minute,
                                                        hour: DateTime.now().hour,
                                                        date: DateTime.now()
                                                            .toString()
                                                            .substring(0, 10),
                                                        centerId: CenterId,
                                                        comment: comment,
                                                        postId: PostId,

                                                      )),
                                                  prefixIcon: Icon(
                                                    Icons.comment,
                                                    color: Colors.deepPurple,
                                                  ),
                                                  hintText: "إضافة تعليق",
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.deepPurpleAccent),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.deepPurpleAccent),
                                                  ),
                                                ),
                                                textInputAction:
                                                    TextInputAction.unspecified,
                                                onChanged: (value) {
                                                  setState(() {
                                                    comment = value;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return ' يجب إضافة تعليق لنشره';
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                        ),
                                      ],
                                    );
                                  }).toList()),
                            ],
                          )));
                }

              })
    ),

        floatingActionButton:   Container(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
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
        ),

      );

  }
}
