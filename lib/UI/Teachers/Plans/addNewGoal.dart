import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../Constance.dart';
import 'package:path/path.dart' as p;


class AddGoal extends StatefulWidget {
  @override
  final String studentId;
  final String planId;

  AddGoal({this.studentId,this.planId});
  _AddGoalState createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _goalTitle=TextEditingController();
  TextEditingController _generalGoal=TextEditingController();
  TextEditingController _goalNeeds=TextEditingController();
  String _goalType;
  List<String> majors=['مجال الانتباه والتركيز','مجال التواصل','المجال الإدراكي','المجال الحركي الدقيق','المجال الاجتماعي','المجال الاستقلالي'];
  File _image;
  String _physiotherapySpecialistId;
  String  _psychologySpecialistId;
  String  _occupationalSpecialistId;
  String  _communicationSpecialistId;
  String _physiotherapySpecialistName;
  String  _psychologySpecialistName;
  String  _occupationalSpecialistName;
  String  _communicationSpecialistName;
  bool _psychologySpecialist=false;
  bool _communicationSpecialist=false;
  bool _occupationalSpecialist=false;
  bool _physiotherapySpecialist=false;
  final _formkey = GlobalKey<FormState>();
  bool _showMassage=true;
  String _imageUrl;

  Future<bool> setUIds() async {
    bool isDone= false;

    await FirebaseFirestore.instance.collection('Students')
        .doc(widget.studentId).get().then((data) {
      _physiotherapySpecialistId = data.data()['physiotherapySpecialistId'];
      _psychologySpecialistId = data.data()['psychologySpecialistId'];
      _occupationalSpecialistId = data.data()['occupationalSpecialistId'];
      _communicationSpecialistId = data.data()['communicationSpecialistId'];
      _physiotherapySpecialistName=data.data()['physiotherapySpecialistName'];
       _psychologySpecialistName=data.data()['psychologySpecialistName'];
       _occupationalSpecialistName=data.data()['occupationalSpecialistName'];
       _communicationSpecialistName=data.data()['communicationSpecialistName'];
    }).whenComplete((){ isDone=true;});
    return isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("إضافة هدف", style: kTextAppBarStyle),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),

      body: SafeArea(
        child: Container(
          color: Colors.white70,
          child: Form(
            key: _formkey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Padding(padding: EdgeInsets.all(8)),
                    SizedBox(
                      width:350 ,
                      child:GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.share,color: Colors.deepPurple.shade100,size: 35,),
                              Text("  إضغط هنا لمشاركة الهدف", style:TextStyle(color: Colors.black),),
                            ],
                          ),
                          onTap: () async {
                            bool d= await setUIds();
                            showDialog(
                                context: context,
                                builder: (_) => StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                          title:
                                          ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Column(
                                                  children:[
                                                    Padding(padding: EdgeInsets.all(5)) ,
                                                    Text("مشاركة مع : ",style: kTextPageStyle),
                                                    Padding(padding: EdgeInsets.all(5)),
                                                    _occupationalSpecialistId !=null?
                                                    Row(
                                                      children: [
                                                        Text(_occupationalSpecialistName,style: kTextPageStyle),
                                                        Text("  أخصائي العلاج الوظيفي",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                                                        Checkbox(value: _occupationalSpecialist, onChanged: (bool value) {
                                                          setState(() {
                                                            _occupationalSpecialist = value;
                                                          });
                                                          print(_occupationalSpecialist);
                                                        },
                                                          checkColor: Colors.black,
                                                          activeColor: Colors.deepPurple.shade100,
                                                          hoverColor: Colors.black,
                                                        )
                                                      ],):Text("",style:TextStyle (fontSize: 0)),

                                                    _communicationSpecialistId !=null?
                                                    Row(
                                                      children: [
                                                        Text(_communicationSpecialistName,style: kTextPageStyle),
                                                        Text("  أخصائي التواصل",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                                                        Checkbox(value: _communicationSpecialist, onChanged: (bool value) async{
                                                          bool isDone=await setUIds();
                                                          setState(() {
                                                            _communicationSpecialist = value;
                                                          });
                                                          print(_communicationSpecialist);
                                                        },
                                                          checkColor: Colors.black,
                                                          activeColor: Colors.deepPurple.shade100,
                                                          hoverColor: Colors.black,
                                                        )
                                                      ],
                                                    ):Text("",style:TextStyle (fontSize: 0)),
                                                    _physiotherapySpecialistId !=null?
                                                    Row(
                                                      children: [
                                                        Text(_physiotherapySpecialistName,style: kTextPageStyle),
                                                        Text("  أخصائي العلاج الطبيعي",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                                                        Checkbox(value: _physiotherapySpecialist, onChanged: (bool value) async {
                                                          setState(() {
                                                            _physiotherapySpecialist = value;
                                                          });
                                                          print(_physiotherapySpecialist);
                                                        },
                                                          checkColor: Colors.black,
                                                          activeColor: Colors.deepPurple.shade100,
                                                          hoverColor: Colors.black,
                                                        )
                                                      ],
                                                    ):Text("",style:TextStyle (fontSize: 0)),

                                                    _psychologySpecialistId!=null?
                                                    Row(
                                                      children: [
                                                        Text(_psychologySpecialistName,style: kTextPageStyle),
                                                        Text(" الأخصائي النفسي ",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                                                        Checkbox(value: _psychologySpecialist, onChanged: (bool value) async {
                                                          bool isDone=await setUIds();
                                                          setState(() {
                                                            _psychologySpecialist = value;
                                                          });
                                                          print(_psychologySpecialist);
                                                        },
                                                          checkColor: Colors.black,
                                                          activeColor: Colors.deepPurple.shade100,
                                                          hoverColor: Colors.black,
                                                        )
                                                      ],
                                                    ):Text("",style:TextStyle (fontSize: 0)),
                                                  ]),
                                            ],
                                          )
                                      );}));
                          }
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(4),),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextFormField(
                          controller: _goalTitle,
                          minLines: 1,
                          maxLines: 3,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'عنوان الهدف',
                             labelStyle:kTextPageStyle.copyWith(color: Colors.grey.shade700),
                            filled: true,
                            fillColor:Colors.deepPurple.shade50,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return '* مطلوب';
                            }
                            else return '';
                            },

                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _generalGoal,
                          minLines: 5,
                          maxLines: 15,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'الهدف العام',
                            labelStyle: kTextPageStyle.copyWith(color: Colors.grey.shade700),
                            filled: true,
                            fillColor:Colors.deepPurple.shade50,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return '* مطلوب';
                            }else return '';
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _goalNeeds,
                          minLines: 3,
                          maxLines: 15,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'متطلبات تحقيق الهدف',
                            labelStyle: kTextPageStyle.copyWith(color: Colors.grey.shade700),
                            filled: true,
                            fillColor:Colors.deepPurple.shade50,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return '* مطلوب';
                            }else return '';
                          },

                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Row(children: <Widget>[
                      new Padding(padding: new EdgeInsets.all(5)),
                      Text("مجال الهدف", style: kTextPageStyle.copyWith(color: Colors.grey.shade700)),
                      new Padding(padding: new EdgeInsets.all(7)),
                      Expanded(
                          child: SizedBox(
                            height: 40,
                            width: 200,
                            child: DropdownButton(
                              hint: Text('اختر'),
                              // Not necessary for Option 1
                              value: _goalType,
                              onChanged: (newValue) {
                                setState(() {
                                  _goalType = newValue;
                                });
                              },
                              items: majors.map((location) {
                                return DropdownMenuItem(
                                  onTap:(){  print(_goalType);},
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ))
                    ]),
                    Container(alignment: Alignment.centerRight,child: Text(_showMassage == false ?"  * يجب تحديد المجال":"",style: TextStyle(color: Colors.red.shade700),)),
                    Row(
                      children: [
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
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.camera_enhance_rounded,
                                    color: Colors.deepPurple.shade200,size: 30,)),
                              Padding(padding: EdgeInsets.all(5)),
                              Text("إضغط هنا لإرفاق صورة", style:TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(5)),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundImage: _image == null ? null : FileImage(_image),
                            backgroundColor: Colors.white70 ,
                            radius: 20,
                          ),
                        ),

                      ],
                    ),
        Padding(padding: EdgeInsets.all(5)),
        SizedBox(
          width:350 ,
          child: RaisedButton(
            color: kButtonColor,
            child: Text("إضافة", style: kTextButtonStyle),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            onPressed: () async{
    User _userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference studentsPlansGoal = FirebaseFirestore.instance.collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");
    CollectionReference teachersPlansGoal =FirebaseFirestore.instance.collection('Teachers').doc(_userTeacher.email).collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");
    CollectionReference specialists = FirebaseFirestore.instance.collection('Specialists');
    if(_goalType==null){
      setState(() {
        _showMassage=false;
      });
    }
    if ( _formkey.currentState.validate() && _goalType!=null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Row(
          children: [CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(Colors.grey),backgroundColor: Colors.deepPurple),
            Padding (padding: EdgeInsets.all(5)),
            Text("جاري الإضافة ..",style: TextStyle(color: Colors.deepPurple,fontSize: 12)),
          ],
        ),
        duration: Duration(hours: 1),
        backgroundColor: Colors.white70,
      ));

      var random = new Random();
      int documentId = random.nextInt(1000000000);
     if(_image!=null){
      FirebaseStorage storage= FirebaseStorage(storageBucket: 'gs://hananz-5ffb9.appspot.com');
      StorageReference ref = storage.ref().child(p.basename(_image.path));
      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask
          .onComplete;
      String Url = await storageTaskSnapshot.ref.getDownloadURL();
      print("........ $Url ..........");
      if (!mounted) return;
      setState(() {
        _imageUrl = Url;
      });}

      var addPlanGoalToStudent = studentsPlansGoal.doc(
          "${widget.planId}${documentId} Goal").set({
        "goalType": _goalType,
        "goalTitle": _goalTitle.text,
        "generalGoal": _generalGoal.text,
        "image": _imageUrl,
        "goalNeeds": _goalNeeds.text,
        "postId": widget.planId,
        "goalId": "${widget.planId}${documentId} Goal",
        'createdAt': Timestamp.now(),
        'date':DateTime.now().toString().substring(0, 10),
        'psychologySpecialistName':_psychologySpecialist == true?_psychologySpecialistName:null,
        'occupationalSpecialistName':_occupationalSpecialist==true?_occupationalSpecialistName:null,
        'communicationSpecialistName':_communicationSpecialist==true?_communicationSpecialistName:null,
        'physiotherapySpecialistName':_physiotherapySpecialist==true?_physiotherapySpecialistName:null,
        'psychologySpecialistId':_psychologySpecialist == true?_psychologySpecialistId:null,
        'occupationalSpecialistId':_occupationalSpecialist==true?_occupationalSpecialistId:null,
        'communicationSpecialistId':_communicationSpecialist==true?_communicationSpecialistId:null,
        'physiotherapySpecialistId':_physiotherapySpecialist==true?_physiotherapySpecialistId:null,
      });
     // add evaluation and notes docements
     //  studentsPlansGoal.doc("${widget.planId}${documentId} Goal").collection('Evaluation')
     //      .doc('$documentId'+'eval').set({});
     //
     //  studentsPlansGoal.doc("${widget.planId}${documentId} Goal").collection('Notes')
     //      .doc('$documentId'+'note').set({});

      var addPlanGoalToTeacher = teachersPlansGoal
        ..doc("${widget.planId}${documentId} Goal").set({
          "goalType": _goalType,
          "goalTitle": _goalTitle.text,
          "generalGoal": _generalGoal.text,
          "image": _imageUrl,
          "goalNeeds": _goalNeeds.text,
          "postId": widget.planId,
          "goalId": "${widget.planId}${documentId} Goal",
          'createdAt': Timestamp.now(),
          'date':DateTime.now().toString().substring(0, 10),
          'psychologySpecialistName':_psychologySpecialist == true?_psychologySpecialistName:null,
          'occupationalSpecialistName':_occupationalSpecialist==true?_occupationalSpecialistName:null,
          'communicationSpecialistName':_communicationSpecialist==true?_communicationSpecialistName:null,
          'physiotherapySpecialistName':_physiotherapySpecialist==true?_physiotherapySpecialistName:null,
          'psychologySpecialistId':_psychologySpecialist == true?_psychologySpecialistId:null,
          'occupationalSpecialistId':_occupationalSpecialist==true?_occupationalSpecialistId:null,
          'communicationSpecialistId':_communicationSpecialist==true?_communicationSpecialistId:null,
          'physiotherapySpecialistId':_physiotherapySpecialist==true?_physiotherapySpecialistId:null,
        });

      if (_psychologySpecialist == true) {
        var addPlanGoalTopsychologySpecialist = specialists.doc(
            _psychologySpecialistId).collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals").doc("${widget.planId}${documentId} Goal").set({
          "goalType": _goalType,
          "goalTitle": _goalTitle.text,
          "generalGoal": _generalGoal.text,
          "image": _imageUrl,
          "goalNeeds": _goalNeeds.text,
          "postId": widget.planId,
          "goalId": "${widget.planId}${documentId} Goal",
          'createdAt': Timestamp.now(),
          'date':DateTime.now().toString().substring(0, 10),
          'psychologySpecialistName':_psychologySpecialist == true?_psychologySpecialistName:null,
          'occupationalSpecialistName':_occupationalSpecialist==true?_occupationalSpecialistName:null,
          'communicationSpecialistName':_communicationSpecialist==true?_communicationSpecialistName:null,
          'physiotherapySpecialistName':_physiotherapySpecialist==true?_physiotherapySpecialistName:null,
          'psychologySpecialistId':_psychologySpecialist == true?_psychologySpecialistId:null,
          'occupationalSpecialistId':_occupationalSpecialist==true?_occupationalSpecialistId:null,
          'communicationSpecialistId':_communicationSpecialist==true?_communicationSpecialistId:null,
          'physiotherapySpecialistId':_physiotherapySpecialist==true?_physiotherapySpecialistId:null,
        });
      }
      if (_physiotherapySpecialist == true) {
        var addGoalPlanToPhysiotherapySpecialistStudent =specialists.doc(
        _physiotherapySpecialistId).collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals").doc("${widget.planId}${documentId} Goal").set({
          "goalType": _goalType,
          "goalTitle": _goalTitle.text,
          "generalGoal": _generalGoal.text,
          "image": _imageUrl,
          "goalNeeds": _goalNeeds.text,
          "postId": widget.planId,
          "goalId": "${widget.planId}${documentId} Goal",
          'createdAt': Timestamp.now(),
          'date':DateTime.now().toString().substring(0, 10),
          'psychologySpecialistName':_psychologySpecialist == true?_psychologySpecialistName:null,
          'occupationalSpecialistName':_occupationalSpecialist==true?_occupationalSpecialistName:null,
          'communicationSpecialistName':_communicationSpecialist==true?_communicationSpecialistName:null,
          'physiotherapySpecialistName':_physiotherapySpecialist==true?_physiotherapySpecialistName:null,
          'psychologySpecialistId':_psychologySpecialist == true?_psychologySpecialistId:null,
          'occupationalSpecialistId':_occupationalSpecialist==true?_occupationalSpecialistId:null,
          'communicationSpecialistId':_communicationSpecialist==true?_communicationSpecialistId:null,
          'physiotherapySpecialistId':_physiotherapySpecialist==true?_physiotherapySpecialistId:null,
            });
      }

      if (_communicationSpecialist == true) {
        var addGoalPlanToCommunicationSpecialistStudent = specialists.doc(
        _communicationSpecialistId).collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals").doc("${widget.planId}${documentId} Goal").set({
          "goalType": _goalType,
          "goalTitle": _goalTitle.text,
          "generalGoal": _generalGoal.text,
          "image": _imageUrl,
          "goalNeeds": _goalNeeds.text,
          "postId": widget.planId,
          "goalId": "${widget.planId}${documentId} Goal",
          'createdAt': Timestamp.now(),
          'date':DateTime.now().toString().substring(0, 10),
          'psychologySpecialistName':_psychologySpecialist == true?_psychologySpecialistName:null,
          'occupationalSpecialistName':_occupationalSpecialist==true?_occupationalSpecialistName:null,
          'communicationSpecialistName':_communicationSpecialist==true?_communicationSpecialistName:null,
          'physiotherapySpecialistName':_physiotherapySpecialist==true?_physiotherapySpecialistName:null,
          'psychologySpecialistId':_psychologySpecialist == true?_psychologySpecialistId:null,
          'occupationalSpecialistId':_occupationalSpecialist==true?_occupationalSpecialistId:null,
          'communicationSpecialistId':_communicationSpecialist==true?_communicationSpecialistId:null,
          'physiotherapySpecialistId':_physiotherapySpecialist==true?_physiotherapySpecialistId:null,
            });
      }
      if (_occupationalSpecialist == true) {
        var addGoalPlanToOccupationalSpecialistStudent = specialists.doc(
        _occupationalSpecialistId).collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals").doc("${widget.planId}${documentId} Goal").set({
          "goalType": _goalType,
          "goalTitle": _goalTitle.text,
          "generalGoal": _generalGoal.text,
          "image": _imageUrl,
          "goalNeeds": _goalNeeds.text,
          "postId": widget.planId,
          "goalId": "${widget.planId}${documentId} Goal",
          'createdAt': Timestamp.now(),
          'date':DateTime.now().toString().substring(0, 10),
          'psychologySpecialistName':_psychologySpecialist == true?_psychologySpecialistName:null,
          'occupationalSpecialistName':_occupationalSpecialist==true?_occupationalSpecialistName:null,
          'communicationSpecialistName':_communicationSpecialist==true?_communicationSpecialistName:null,
          'physiotherapySpecialistName':_physiotherapySpecialist==true?_physiotherapySpecialistName:null,
          'psychologySpecialistId':_psychologySpecialist == true?_psychologySpecialistId:null,
          'occupationalSpecialistId':_occupationalSpecialist==true?_occupationalSpecialistId:null,
          'communicationSpecialistId':_communicationSpecialist==true?_communicationSpecialistId:null,
          'physiotherapySpecialistId':_physiotherapySpecialist==true?_physiotherapySpecialistId:null,
            });
      }
      Navigator.pop(context);
    }}  )),
                  ],
                )
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
      _image = Image;
    });
  }
  void pickImageGallery() async {
    var Image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = Image;});

  }
}
