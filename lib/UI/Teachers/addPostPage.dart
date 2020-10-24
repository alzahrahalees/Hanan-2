import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hanan/UI/Teachers/Video.dart';
import 'package:image_picker/image_picker.dart';
import '../Constance.dart';
import 'Post.dart';
import 'package:path/path.dart' as p;
import 'package:image_downloader/image_downloader.dart';
import 'package:video_player/video_player.dart';


class AddPostPage extends StatefulWidget {
  final String uid;
  final String centerId;
  final String name;
  AddPostPage ({this.uid,this.centerId,this.name});
  @override
  _AddPostPageState createState() => _AddPostPageState(uid,centerId,name);
}

class _AddPostPageState extends State<AddPostPage> {
  void initState() {
    super.initState();
  }

  String uid;
  String centerId;
  String name;
  String _diary;

  _AddPostPageState(String uid, String centerId, String name) {
    this.uid = uid;
    this.centerId = centerId;
    this.name = name;
  }

  final _formkey = GlobalKey<FormState>();

  File _Image;
  File _Vedio;
  String _URL ;
  var   _cameraVideoPlayerController ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("إضافة يومية", style: kTextAppBarStyle),
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
                            focusNode: FocusNode(skipTraversal: false,
                                canRequestFocus: false,
                                descendantsAreFocusable: false),
                            autofocus: true,
                            maxLines: 24,
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
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(5),),
                   Container(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        backgroundImage: _Image == null ? null : FileImage(_Image),
                        backgroundColor: kBackgroundPageColor ,
                        radius: 20,
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(5),),
                    Divider(color: Colors.deepPurple,
                      thickness: 3,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 130),
                          child:
                          AddPost(
                            video: _Vedio,
                            image: _Image,
                            content: _diary!=null?_diary:" ",
                            centerId: centerId,
                            studentUid: uid,
                            studentName: name,
                            minute: DateTime
                                .now()
                                .minute,
                            hour: DateTime
                                .now()
                                .hour,
                            date: DateTime.now().toString().substring(0, 10),
                          ),),

                        GestureDetector(
                          onTap: pickImageCamera,
                          child: IconButton(icon: Icon(Icons.camera_alt,
                            color: Colors.deepPurple.shade400,)),
                        ),
                        GestureDetector(
                            onTap: pickImageGallery,
                            child: IconButton(icon: Icon(Icons.photo,
                                color: Colors.deepPurple.shade400),)),
                      ],
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

  /*void pickVideoCamera() async {
    var Vedio = await ImagePicker.pickVideo(source:ImageSource.camera);
    _Vedio=Vedio;
    _cameraVideoPlayerController = VideoPlayerController.file(Vedio)..initialize().then((_) {
      setState(() { });
      _cameraVideoPlayerController.play();
    });
  }*/


  void pickImageGallery() async {
    var Image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _Image = Image;
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
