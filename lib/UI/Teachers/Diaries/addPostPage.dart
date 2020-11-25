import 'dart:io';
import 'package:export_video_frame/export_video_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../Constance.dart';
import 'Post.dart';
import 'package:path/path.dart' as p;
import 'package:image_downloader/image_downloader.dart';


class AddPostPage extends StatefulWidget {
  final String uid;
  final String centerId;
  final String name;
  final String teacherId;
  final String teacherName;
  AddPostPage ({this.uid,this.centerId,this.name,this.teacherId,this.teacherName});
  @override
  _AddPostPageState createState() => _AddPostPageState(uid,centerId,name,teacherId);
}


class _AddPostPageState extends State<AddPostPage> {
  void initState() {
    super.initState();
  }

  String uid;
  String centerId;
  String name;
  String _diary;
  String teacherId;
  _AddPostPageState(String uid, String centerId, String name,String teacherId) {
    this.uid = uid;
    this.centerId = centerId;
    this.name = name;
    this.teacherId=teacherId;
  }

  final _formkey = GlobalKey<FormState>();

  File _Image;
  Image _Image2;
  File _Vedio;
  List<Image> Images;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("إضافة", style: kTextAppBarStyle),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          color: kBackgroundPageColor,
          alignment: Alignment.topCenter,
          child: Form(
            key: _formkey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            //keyboardType: TextInputType.multiline,
                            //  focusNode: FocusNode(skipTraversal: false,
                            //    canRequestFocus: false,
                            //  descendantsAreFocusable: false),
                            //autofocus: true,
                            maxLines: 20,
                            showCursor: true,
                            decoration: InputDecoration(
                              hintText: "ماذا فعل/ت $name اليوم ؟ ",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: kBackgroundPageColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: kBackgroundPageColor),
                              ),
                            ),
                            textInputAction: TextInputAction.unspecified,
                            onChanged: (value) {
                              setState(() {
                                _diary = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'مطلوب';
                              }
                              else return '';
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(5),),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundImage: _Image == null ? null : FileImage(_Image),
                            backgroundColor: kBackgroundPageColor ,
                            radius: 20,
                          ),
                        ),

                        _Vedio != null ?
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 50)),
                            Text("تم تحميل المقطع بنجاح",style: TextStyle(color: Colors.deepPurple,fontSize: 15),),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Icon(Icons.thumb_up_alt_rounded,color: Colors.green,),
                          ],
                        ) : Text(""),   ],
                    ),
                    Padding(padding: EdgeInsets.all(5),),
                    Divider(color: Colors.deepPurple,
                      thickness: 2,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 150),
                          child:
                          AddPost(
                            video: _Vedio,
                            image: _Image,
                            teacherId: teacherId,
                            teacherName: widget.teacherName,
                            content: _diary!=null?_diary:" ",
                            centerId: centerId,
                            studentUid: uid,
                            studentName: name,
                            minute: DateTime.now().minute,
                            hour: DateTime.now().hour,
                            date: DateTime.now().toString().substring(0, 10),
                          ),),
                        GestureDetector(
                          onTap:() {
                            showDialog(
                                context: context,
                                builder: (_) => new AlertDialog(
                                  title: Column(
                                    children: [

                                      Row(
                                        children: [
                                          Center(
                                            child: FlatButton(
                                              child: Text('  الكاميرا',style: TextStyle(color: Colors.deepPurple),),
                                              onPressed: () {
                                                pickImageCamera();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Center(
                                            child: FlatButton(
                                              child: Text('مكتبة الصور',style: TextStyle(color: Colors.deepPurple),),
                                              onPressed: () {
                                                pickImageGallery();
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  titlePadding: EdgeInsets.only(right:90),
                                ));
                          },
                          child: IconButton(
                              icon: Icon(Icons.camera_enhance_rounded,
                            color: Colors.deepPurple.shade400,)),
                        ),
                        GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (_) => new AlertDialog(
                                    title: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Center(
                                              child: FlatButton(
                                                child: Text('  الكاميرا',style: TextStyle(color: Colors.deepPurple),),
                                                onPressed: () {
                                                  pickVideoCamera();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Center(
                                              child: FlatButton(
                                                child: Text('مكتبة الصور',style: TextStyle(color: Colors.deepPurple),),
                                                onPressed: () {
                                                  pickVideoGallery();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    titlePadding: EdgeInsets.only(right: 90),
                                  ));
                            },
                            child: IconButton(icon: Icon(Icons.video_call,
                                size: 30,
                                color: Colors.deepPurple.shade400),)),

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ChewieDemo()),);},
                      ],
                    ),
                    Divider(color: Colors.deepPurple,
                      thickness: 2,
                    ),
                  ],
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }


  void pickImageCamera() async {
    var Image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _Image = Image;
    });
  }

  void pickVideoCamera() async {
    //  var _isClean = false;
    var Vedio = await ImagePicker.pickVideo(source:ImageSource.camera,maxDuration: const Duration(seconds: 10));
    setState(() {
      _Vedio = Vedio;
    });
  }
  void exportImage() async {
    var _isClean = false;
    var images = await ExportVideoFrame.exportImage(p.basename(_Vedio.path),10,10);
    var result = images.map((file) => Image.file(file)).toList();
    setState(() {
      Images.addAll(result);
      _Image2=Images.first;
    });
  }

  void pickImageGallery() async {
    var Image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _Image = Image;});
  }

  void pickVideoGallery() async {
    var Vedio = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _Vedio = Vedio;
    });
  }

  void loadImage(String url) async {
    var imageId = await ImageDownloader.downloadImage(url);
    var path =await ImageDownloader.findPath(imageId);
    File image=File(path);
    setState(() {
      _Image=image;
    });
  }





}