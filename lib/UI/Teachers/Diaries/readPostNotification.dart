import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Constance.dart';
import 'Post.dart';
import 'Video.dart';


class OnePostNot extends StatefulWidget {
  final String postId;
  final String notificationId;
  final String studentId;
  final String centerId;
  final String teacherName;

  OnePostNot({this.postId,this.notificationId,this.studentId,this.centerId,this.teacherName});
  @override
  _OnePostNotState createState() => _OnePostNotState();
}

class _OnePostNotState extends State<OnePostNot> {
  TextEditingController c = new TextEditingController();
  String comment;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    User userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference Teachers = FirebaseFirestore.instance.collection('Teachers');
    CollectionReference Students = FirebaseFirestore.instance.collection('Students');

     return Scaffold(
       appBar: AppBar(
         title: Text("اليومية", style: kTextAppBarStyle),
         centerTitle: true,
         backgroundColor: Colors.white70,
       ),
        body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
        stream:Students.doc(widget.studentId).collection('Posts').where('postId',isEqualTo: widget.postId).snapshots(),
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
    child:ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    children: [
     // Text(widget.postId),
    Padding(padding: new EdgeInsets.all(8)),
    Column( children:
    snapshot.data.docs.map((DocumentSnapshot document) {
    String  postId=document.id;
    String teacherName=document.data()['teacherName'];
    return Column(children:[
      Center(
        //alignment: Alignment.bottomLeft,
        child:Text(document.data()['date'],style:TextStyle(color: Colors.grey) ,),),
      Padding(padding: new EdgeInsets.all(8)),
    Card(
    shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(5),
    ),
    elevation: 5,
    child:
    Column(
    children:[
       Padding(padding: EdgeInsets.all(8),),
      document.data()['video']!=null ?
      Video(document.data()['video'],):Text("",style:TextStyle(fontSize: 0),),
      document.data()['imageUrl']!=null ?
      Image.network(document.data()['imageUrl'],loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
            child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),backgroundColor: Colors.deepPurple));},
        width: 2000,
        height: 450,
      ):Text("",style:TextStyle(fontSize: 0),),
    ListTile(
    title: Text(document.data()['content'],),),
    Padding(padding: EdgeInsets.only(right: 280),
    child:  Text(document.data()['hour'].toString()+":"+document.data()['minute'].toString()+" "+document.data()['time'],style: TextStyle(fontSize: 9,color: Colors.grey)),),
    Text   ("التعليقات"),
    Padding(padding: EdgeInsets.all(0),
    child: StreamBuilder<QuerySnapshot>(
    stream: Students.doc(widget.studentId).collection('Posts').doc(widget.postId).collection('Comments').orderBy('createdAt',descending: false).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData){
    return Column(
    children:
    snapshot.data.docs.map((DocumentSnapshot document) {
    return   Column(
    children: [
    ListTile(
    title: Text(document.data()['writer']+(": ")+document.data()['comment'],style: TextStyle(fontSize: 13,color: Colors.black),),
    trailing: Text(document.data()['hour'].toString()+(":")+document.data()['minute'].toString()+(" ")+document.data()['time'],style: TextStyle(fontSize: 9,color: Colors.grey)),
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

    var DeltoStudentPost=  Students.doc(widget.studentId).collection("Posts").doc(widget.postId).collection('Comments').doc(document.id).delete();

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
    child: AddComment(studentName: document.data()['studentName'],
    studentUid: widget.studentId,comment: comment,
    postId: document.id, minute: DateTime.now().minute, hour: DateTime.now().hour,
    date: DateTime.now().toString().substring(0,10),
    centerId: widget.centerId,writer: document.data()['teacherName'],
    formkey: _formkey, c: c,) ),
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
    ),);
  }
}
