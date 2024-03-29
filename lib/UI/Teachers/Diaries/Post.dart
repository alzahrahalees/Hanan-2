import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:path/path.dart' as p;
import '../../Constance.dart';


class AddPost extends StatefulWidget {
  final File video;
  final File image;
  final String content;
  final String studentUid;
  final String centerId;
  final String studentName;
  final int minute;
  final int hour;
  final String date;
  final String teacherId;
  final String teacherName;
  AddPost(
      {this.teacherName,
        this.teacherId,
        this.video,
        this.image,
        this.content,
         this.studentUid,
       this.date,
        this.minute,
        this.hour,
      this.centerId,
      this.studentName});

  @override
  _AddPostState createState() => _AddPostState();
}
class _AddPostState extends State<AddPost> {
  String Imageurl;
  String Videourl;
  Widget build(BuildContext context) {
    User userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference Students =
    FirebaseFirestore.instance.collection('Students');


    int hourEditor (int hour){
      int newHour;
      if (hour!=null) {
        if (hour > 12)
          newHour = hour - 12;
        else
          newHour = hour;
        return newHour;
      }
      else return 0;
    }


    String dayOrNight(int hour){
      String time;
      if (hour!= null){
        if(hour>=12) time='م';
        else time ="ص";
        return time;
      }
      else return "ص";
    }

    var random= new Random();
    int documentId=random.nextInt(1000000000);

    Future<void> addPost() async {
      if (widget.image !=null) {
      FirebaseStorage storage= FirebaseStorage(storageBucket: 'gs://hananz-5ffb9.appspot.com');

        StorageReference ref = storage.ref().child(p.basename(widget.image.path));
        StorageUploadTask storageUploadTask = ref.putFile(widget.image);
        StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask
            .onComplete;
        String Url = await storageTaskSnapshot.ref.getDownloadURL();
        print("........ $Url ..........");
        if (!mounted) return;
        setState(() {
          Imageurl = Url;
        });
      }
      if (widget.video !=null) {
        FirebaseStorage storage= FirebaseStorage(storageBucket: 'gs://hananz-5ffb9.appspot.com');
        StorageReference ref = storage.ref().child(p.basename(widget.video.path));
        StorageUploadTask storageUploadTask = ref.putFile(widget.video);
        StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
        String Url = await storageTaskSnapshot.ref.getDownloadURL();
        print("........ $Url ..........");
        if (!mounted) return;
        setState(() {
          Videourl = Url;
        });
      }


   var addToStudentPost=  Students.doc(widget.studentUid).collection("Posts").doc("${widget.studentUid}$documentId").set({
        'videoUrl':Videourl,
        'imageUrl':Imageurl,
        'teacherId':userTeacher.email,
        'teacherName': widget.teacherName,
        'content': widget.content,
        'uid': widget.studentUid,
        'date': widget.date,
        'time':dayOrNight(widget.hour),
        'hour':hourEditor(widget.hour),
        'minute':widget.minute,
        'centerId': widget.centerId,
        'studentName': widget.studentName,
        'createdAt':Timestamp.now(),
        'postId':"${widget.studentUid}$documentId",
      });





    Navigator.of(context).pop();}

    return FlatButton  (

      child: Text('نشر', style: kTextPageStyle.copyWith(
          color: Colors.deepPurpleAccent.shade700)),
      onPressed: () {
        if (widget.content!=" " || widget.image!=null || widget.video !=null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),backgroundColor: Colors.deepPurple),
              Padding (padding: EdgeInsets.all(5)),
              Text("جاري التحميل..",style: TextStyle(color: Colors.deepPurple,fontSize: 12)),

            ],
          ),
          duration: Duration(hours: 1),
          backgroundColor: Colors.white70,
        ));
        print(widget.content);
          addPost();
       }
       else{
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(" مطلوب كتابة يومية أو إضافة صورة أو فيديو",style: TextStyle(color: Colors.deepPurple,fontSize: 12)),
            backgroundColor: Colors.white70,
            duration: Duration(seconds: 1),
          ));
        }
      },
    );
  }}

class AddComment extends StatelessWidget {
  final String comment;
  final String studentUid;
  final int minute;
  final int hour;
  final String date;
  final String centerId;
  final String studentName;
  final String postId;
  final String writer;
  final TextEditingController c;
  final formkey;

  AddComment({
    this.formkey,
    this.c,
    this.comment,
    this.minute,
    this.hour,
    this.date,
    this.studentUid,
    this.centerId,
    this.postId,
    this.studentName,
    this.writer,

  });


  int hourEditor(int hour) {
    int newHour;
    if (hour != null) {
      if (hour > 12)
        newHour = hour - 12;
      else
        newHour = hour;
      return newHour;
    }
    else
      return 0;
  }

  String dayOrNight(int hour) {
    String time;
    if (hour != null) {
      if (hour >= 12)
        time = 'م';
      else
        time = "ص";
      return time;
    }
    else
      return "ص";
  }

  @override
  Widget build(BuildContext context) {
    User userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference Students =
    FirebaseFirestore.instance.collection('Students');


    var random = new Random();
    int documentId = random.nextInt(1000000000);

    Future<void> AddComment() async {
      var addtoStudentPostComment = Students.doc(studentUid).collection("Posts")
          .doc(postId).collection("Comments").doc("$studentUid$documentId").set({
            'comment': comment,
            'uid': studentUid,
            'date': date,
            'time': dayOrNight(hour),
            'hour': hourEditor(hour),
            'minute': minute,
            'centerId': centerId,
            'postId': postId,
            'studentName': studentName,
            'writer': writer,
            'createdAt': Timestamp.now(),
            'read': false,
          });}


      return FlatButton(child: Text('نشر', style: kTextPageStyle.copyWith(
            color: comment == null || comment == "" ? Colors.white10 : Colors
                .deepPurpleAccent.shade700)),
        onPressed: () {
          if (comment != null && comment.isNotEmpty && comment != "") {
            AddComment();
            c.clear();
          }
        },
      );
    }
  }


class ShowComments extends StatelessWidget {
  final String studentName;
  final String postId;
  final String studentUid;
  final String centerId;
  ShowComments({this.studentUid,this.studentName,this.postId,this.centerId});


  Widget build(BuildContext context) {
    User userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference Students =
    FirebaseFirestore.instance.collection('Students');
    return  StreamBuilder<QuerySnapshot>(
        stream: Students.doc(studentUid).collection('Posts').doc(postId).collection('Comments').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData){
            return ListView(
                children:
                snapshot.data.docs.map((DocumentSnapshot document) {
                  return
                  Card(
                child: ListTile(
                    title: Text(document.data()['comment'],style: TextStyle(fontSize: 15,color: Colors.black),),
                  ));
                }).toList()
            );}
          else{return Text("");}
        }
    );
  }
}

class AddCommentParent extends StatelessWidget {
  final String comment;
  final String teacherId;
  final String studentUid;
  final int minute;
  final int hour;
  final String date;
  final String centerId;
  final String studentName;
  final String postId;
  final String writer;
  final TextEditingController c;

  AddCommentParent({
    this.c,
    this.comment,
    this.minute,
    this.hour,
    this.date,
    this.studentUid,
    this.centerId,
    this.postId,
    this.studentName,
    this.writer,
    this.teacherId,

  });


  int hourEditor(int hour) {
    int newHour;
    if (hour != null) {
      if (hour > 12)
        newHour = hour - 12;
      else
        newHour = hour;
      return newHour;
    }
    else
      return 0;
  }

  String dayOrNight(int hour) {
    String time;
    if (hour != null) {
      if (hour >= 12)
        time = 'م';
      else
        time = "ص";
      return time;
    }
    else
      return "ص";
  }

  @override
  Widget build(BuildContext context) {
    User userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference Students =
    FirebaseFirestore.instance.collection('Students');
    CollectionReference Teachers =
    FirebaseFirestore.instance.collection('Teachers');

    var random = new Random();
    int documentId = random.nextInt(1000000000);

    Future<void> addCommentParent() async {
      var addToStudentPostComment = Students.doc(studentUid).collection("Posts")
          .doc(postId).collection("Comments").doc("$studentUid$documentId").set(
          {
            'comment': comment,
            'teacherId': teacherId,
            'uid': studentUid,
            'date': date,
            'time': dayOrNight(hour),
            'hour': hourEditor(hour),
            'minute': minute,
            'centerId': centerId,
            'postId': postId,
            'studentName': studentName,
            'writer': writer,
            'createdAt': Timestamp.now(),
          });

      var addToTeacherNotification = Teachers.doc(
          teacherId).collection('Notifications').doc(
          "$studentUid$documentId Notifications").set({
        'commentId': "$studentUid$documentId",
        'comment': comment,
        'uid': studentUid,
        'date': date,
        'time': dayOrNight(hour),
        'hour': hourEditor(hour),
        'minute': minute,
        'centerId': centerId,
        'postId': postId,
        'studentName': studentName,
        'writer': writer,
        'createdAt': Timestamp.now(),
        'read': false,
        'NotificationUid': "$studentUid$documentId Notifications",
      });




    }

    return FlatButton(
      child: Text('نشر', style: kTextPageStyle.copyWith(
          color: comment == null || comment == "" ? Colors.white10 : Colors
              .deepPurpleAccent.shade700)),
      onPressed: () {
        if (comment != null && comment.isNotEmpty && comment != "") {
          print(comment);
          addCommentParent();
          c.clear();
        }
      },
    );
  }
}


class DeletePost extends StatelessWidget {
  @override

  final String studentUid;
  final String postId;
  final String centerId;
  final String imageUrl;
  final String videoUrl;

  DeletePost({this.centerId,this.postId,this.studentUid,this.imageUrl,this.videoUrl});

  Widget build(BuildContext context) {
    User userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference Students =
    FirebaseFirestore.instance.collection('Students');
    CollectionReference Teachers =
    FirebaseFirestore.instance.collection('Teachers');


    Future<void> deletePost() async {
      var DeltoStudentPost = Students.doc(studentUid).collection("Posts").doc(
          postId).delete();
      var DeltoStudentPostComments = Students.doc(studentUid).collection(
          'Posts').doc(postId).collection('Comments').get().then((value) =>
          value.docs.forEach((element) {
            Students.doc(studentUid).collection('Posts').doc(postId).collection(
                'Comments').doc(element.id).delete();
          }));
      var DelttoTeacherNot= Teachers.doc(userTeacher.email).collection('Notifications').where('postId', isEqualTo: postId).get().then((value) =>
          value.docs.forEach((element) {
            Teachers.doc(userTeacher.email).collection('Notifications').doc(element.id).delete();
          }));

      if (imageUrl != null) {
        if (imageUrl.contains('im',71)){
          FirebaseStorage storage = FirebaseStorage(
              storageBucket: 'gs://hananz-5ffb9.appspot.com');
          String chaildName =imageUrl.substring(71,imageUrl.indexOf('?'));
          print(chaildName);
          await storage.ref().child('$chaildName').delete();
        }
        else{
        FirebaseStorage storage = FirebaseStorage(
            storageBucket: 'gs://hananz-5ffb9.appspot.com');
        String chaildName =imageUrl.substring(71,imageUrl.indexOf('?'));
        await storage.ref().child('$chaildName').delete();}
      }

    if (videoUrl != null) {
      if (videoUrl .contains('im',71)){
        FirebaseStorage storage = FirebaseStorage(
            storageBucket: 'gs://hananz-5ffb9.appspot.com');
        String chaildName =videoUrl.substring(71,videoUrl.indexOf('?'));
        print(chaildName);
        await storage.ref().child('$chaildName').delete();
      }
      else{
        FirebaseStorage storage = FirebaseStorage(
            storageBucket: 'gs://hananz-5ffb9.appspot.com');
        String chaildName =videoUrl.substring(71,videoUrl .indexOf('?'));
        await storage.ref().child('$chaildName').delete();}
    }
  }

       return IconButton  (
      icon:Icon( Icons.clear,color: Colors.deepPurple.shade100,size: 18,),
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
              content: new Text("هل تريد حذف اليومية؟"),
              actions: <Widget>[
                Row(
                  children: [
                    FlatButton(
                      child: Text('حذف',style: TextStyle(color: Colors.deepPurple),),
                      onPressed: () {
                        deletePost();
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
    );
  }
}

class DeleteComments extends StatelessWidget {
  @override
  final String studentUid;
  final String postId;
  final String centerId;
  final String commentId;

  DeleteComments({this.centerId, this.postId, this.studentUid, this.commentId});

  Widget build(BuildContext context) {
    User userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference Students =
    FirebaseFirestore.instance.collection('Students');


    Future<void> deleteComments() async {
      var DeltoStudentPost = Students.doc(studentUid).collection("Posts").doc(
          postId).collection('Comments').doc(commentId).delete();
      return IconButton(
          icon: Icon(Icons.clear, color: Colors.deepPurple.shade100, size: 18,),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) =>
                new AlertDialog(
                  content: new Text("هل تريد حذف اليومية؟"),
                  actions: <Widget>[
                    Row(
                      children: [
                        FlatButton(
                          child: Text('حذف', style: TextStyle(color: Colors
                              .deepPurple),),
                          onPressed: () {
                            deleteComments();
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text('إلغاء', style: TextStyle(color: Colors
                              .deepPurple),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                ));
          }
      );
    }
  }


}