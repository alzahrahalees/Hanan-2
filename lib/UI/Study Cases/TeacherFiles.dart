import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path/path.dart' as p;
import '../Constance.dart';


class TFiles extends StatefulWidget {
  final String studentId;
  final String centerId;
  final String psychologySpecialistName;//نفسي
  final String psychologySpecialistId;
  final String communicationSpecialistName;//تخاطب
  final String communicationSpecialistId;
  final String occupationalSpecialistName; //,ظيفي
  final String occupationalSpecialistId;
  final String physiotherapySpecialistName;//علاج طبيعي
  final String physiotherapySpecialistId;
  final String teacherName;

  TFiles({this.studentId,this.centerId,this.teacherName,
    this.communicationSpecialistId,this.communicationSpecialistName,
    this.physiotherapySpecialistId,this.physiotherapySpecialistName,
    this.psychologySpecialistId,this.psychologySpecialistName,
    this.occupationalSpecialistId,this.occupationalSpecialistName,});



  @override
  _TFilesState createState() => new _TFilesState();
}

class _TFilesState extends State<TFiles> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String fileUrl;
  File _File;
  bool psychologySpecialist=false;
  bool communicationSpecialist=false;
  bool occupationalSpecialist=false;
  bool physiotherapySpecialist=false;
  bool showMassage=false;
  bool showMassage2=false;
  String download;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        title: Text("المرفقات", style: kTextAppBarStyle),
    centerTitle: true,
    backgroundColor: Colors.white70,),
    body: SafeArea(
    child: StreamBuilder<QuerySnapshot>(
      stream:  FirebaseFirestore.instance.collection('Students').doc(widget.studentId).collection('StudyCases').orderBy('createdAt',descending: true ).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData){
          return  Center(child: SpinKitFoldingCube(
            color: kUnselectedItemColor,
            size: 60,
          ),
          );}
        else{
        return Container(
        padding: EdgeInsets.all(10),
        color: kBackgroundPageColor,
        alignment: Alignment.topCenter,
        child: ListView(
        shrinkWrap: true,
        children: [
            Column(children:[
              Padding(padding:EdgeInsets.all(3),),
              GestureDetector(

        onTap:(){
          showDialog(
              context: context,
              builder: (_) => StatefulBuilder(
  builder: (context, setState) {
                return new AlertDialog(
                title: SizedBox(
                  width: 200,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.upload_file,color: Colors.deepPurple.shade200,),
                            Padding(padding: EdgeInsets.all(3),),
                            GestureDetector(child:Text("إضغط هنا لإختيار المستند",style: kTextPageStyle,),
                            onTap:(){ pickFile1().whenComplete((){
                                       setState(() {
                                         showMassage=true;
                                                 });
                            });}),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(3)) ,
                       _File!=null?
                       showMassage==true?Text("تم إختيار ${p.basename(_File.path)}",style:kTextPageStyle.copyWith(fontSize: 10,color: Colors.grey) ,):Text(""):Text(""),
                       Padding(padding: EdgeInsets.all(5)) ,
                        Text("مشاركة مع : ",style: kTextPageStyle),
                        Padding(padding: EdgeInsets.all(5)),
                        widget.occupationalSpecialistId !=null?
                 Row(
                       children: [
                         Text(widget.occupationalSpecialistName,style: kTextPageStyle),
                         Text("  أخصائي العلاج الوظيفي",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                         Checkbox(value: occupationalSpecialist, onChanged: (bool value) {
                           setState(() {
                            occupationalSpecialist = value;
                           });
                           print(occupationalSpecialist);
                         },
                         checkColor: Colors.black,
                           activeColor: Colors.deepPurple.shade100,
                           hoverColor: Colors.black,
                         )
                       ],
                 ):Text("",style:TextStyle (fontSize: 0)),
                        widget.communicationSpecialistId !=null?
                        Row(
                          children: [
                            Text(widget.communicationSpecialistName,style: kTextPageStyle),
                            Text("  أخصائي التواصل",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                            Checkbox(value: communicationSpecialist, onChanged: (bool value) {
                              setState(() {
                                communicationSpecialist = value;
                              });
                              print(communicationSpecialist);
                            },
                              checkColor: Colors.black,
                              activeColor: Colors.deepPurple.shade100,
                              hoverColor: Colors.black,
                            )
                          ],
                        ):Text("",style:TextStyle (fontSize: 0)),
                        widget.physiotherapySpecialistId !=null?
                        Row(
                          children: [
                            Text(widget.physiotherapySpecialistName,style: kTextPageStyle),
                            Text("  أخصائي العلاج الطبيعي",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                            Checkbox(value: physiotherapySpecialist, onChanged: (bool value) {
                              setState(() {
                                physiotherapySpecialist = value;
                              });
                              print(physiotherapySpecialist);
                            },
                              checkColor: Colors.black,
                              activeColor: Colors.deepPurple.shade100,
                              hoverColor: Colors.black,
                            )
                          ],
                        ):Text("",style:TextStyle (fontSize: 0)),

                        widget.psychologySpecialistId!=null?
                        Row(
                          children: [
                            Text(widget.psychologySpecialistName,style: kTextPageStyle),
                            Text(" الأخصائي النفسي ",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                            Checkbox(value: psychologySpecialist, onChanged: (bool value) {
                              setState(() {
                                psychologySpecialist = value;
                              });
                              print(psychologySpecialist);
                            },
                              checkColor: Colors.black,
                              activeColor: Colors.deepPurple.shade100,
                              hoverColor: Colors.black,
                            )
                          ],
                        ):Text("",style:TextStyle (fontSize: 0)),

                        Padding(padding: EdgeInsets.all(5)),
                    _File !=null ?
                        FlatButton(onPressed: (){
                          setState(() {
                            showMassage2=true;
                          });
                          pickFile2().whenComplete(() {
                              Navigator.pop(context);});
                          },
                            child:
                            Text( "إرفاق", style: kTextPageStyle.copyWith(color:Colors.deepPurple.shade400))):
                        Text("*يجب إختيار مستند",style:  kTextPageStyle.copyWith(color: Colors.grey,fontSize: 8)),
                        Padding(padding: EdgeInsets.all(6)),
                        showMassage2==true?
                        Text("جاري التحميل ...",style:  kTextPageStyle.copyWith(color: Colors.grey,fontSize: 8)):
                             Text("",style: TextStyle(fontSize: 0),)

        ],
        ),
                    ],
                  ),
                ),
        );
    }));},
             child: Row(
               children: [
                 Icon(Icons.add,),
                 Text(" إرفاق مستند جديد",style: kTextPageStyle),
               ],
             ),
              ),
              Text(download!=null?"  جاري التحميل  "+download:""),
              Column(
                children:  snapshot.data.docs.map((DocumentSnapshot document) {
                    String publisher= document.data()['publisher']==widget.teacherName?"بواسطتك":" بواسطة ${document.data()['publisher']}";
                      return ListTile(
                          leading:  Icon(Icons.attach_file,color:Colors.deepPurple.shade200,size: 35,),
                          trailing: IconButton(icon:Icon(Icons.download_sharp),onPressed: () async{
                                   Dio dio =Dio();
                            String path = await ExtStorage.getExternalStoragePublicDirectory(
                                ExtStorage.DIRECTORY_DOWNLOADS);print(path);
        try {
        Response response = await dio.get(document.data()['filePath'],
        onReceiveProgress: showDownloadProgress,
        options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
        return status < 500;
        }),
        );
        print(response.headers);
        File file = File("$path/${document.data()['fileName']}.pdf");
        var raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close().whenComplete((){  _displaySnackBar(context, "تم تحميل المستند إلى التنزيلات بنجاح");
        setState(() {
          download=null;
        });
        });
        } catch (e) {
        print(e);
        }}),
                          title: Text(document.data()['fileName'],style: kTextPageStyle.copyWith(fontSize: 10),),
                           subtitle: Text( "تم إرفاقه تاريخ: "+document.data()['date']+" "+publisher ,style:kTextPageStyle.copyWith(color: Colors.grey,fontSize: 8)),
                      );
                }).toList()),
           ]),
        ]));}
      }
    ))
    );
  }

  _displaySnackBar(BuildContext context,String s) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(
        "$s", style: TextStyle(color: Colors.deepPurple, fontSize: 12)),
        backgroundColor: Colors.white70, duration: Duration(seconds: 3)));}

  Future pickFile1() async {
  File file = await FilePicker.getFile(type: FileType.any);
  setState(() {
  _File = file;});}

  Future pickFile2() async {
    User userTeacher = FirebaseAuth.instance.currentUser;
    CollectionReference Students =
    FirebaseFirestore.instance.collection('Students');
    CollectionReference Specialists = FirebaseFirestore.instance.collection('Specialists');
    String basename = p.basename(_File.path);
    FirebaseStorage storage= FirebaseStorage(storageBucket: 'gs://hananz-5ffb9.appspot.com');
    StorageReference ref = storage.ref().child(p.basename(_File.path));
    StorageUploadTask storageUploadTask = ref.putFile(_File);
    StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
    String Url = await storageTaskSnapshot.ref.getDownloadURL().whenComplete(() => _displaySnackBar(context,"تم إرفاق المستند بنجاح"));
    print("........ $Url ..........");
    if (!mounted) return;
    setState(() {
      fileUrl = Url;
    });

    var random= new Random();
    int documentId=random.nextInt(1000000000);

    print("py $psychologySpecialist");
    print("ph $physiotherapySpecialist");
    print("c $communicationSpecialist");
    print("o $occupationalSpecialist");

    var addFileToStudent= Students.doc(widget.studentId).collection('StudyCases').doc("${widget.studentId}$documentId File").set(
        {
          'filePath':fileUrl,
          'createdAt':Timestamp.now(),
          'fileName':basename,
          'date':DateTime.now().toString().substring(0, 10),
          'publisher':widget.teacherName
        });


    if (psychologySpecialist==true) {
      var addFileToPsychologySpecialistStudent = Specialists.doc(
          widget.psychologySpecialistId).collection("Students").doc(
          widget.studentId).collection('StudyCases').doc(
          "${widget.studentId}$documentId File").set(
          {
            'filePath': fileUrl,
            'createdAt': Timestamp.now(),
            'fileName': basename,
            'date': DateTime.now().toString().substring(0, 10),
            'publisher': widget.teacherName
          });
    }
      if (physiotherapySpecialist == true) {
        var addFileToPhysiotherapySpecialistStudent = Specialists.doc(
            widget.physiotherapySpecialistId).collection("Students").doc(
            widget.studentId).collection('StudyCases').doc(
            "${widget.studentId}$documentId File").set(
            {
              'filePath': fileUrl,
              'createdAt': Timestamp.now(),
              'fileName': basename,
              'date': DateTime.now().toString().substring(0, 10),
              'publisher': widget.teacherName
            });
      }
        if (communicationSpecialist == true) {
          var addFileToCommunicationSpecialistStudent = Specialists.doc(
              widget.communicationSpecialistId).collection("Students").doc(
              widget.studentId).collection('StudyCases').doc(
              "${widget.studentId}$documentId File").set(
              {
                'filePath': fileUrl,
                'createdAt': Timestamp.now(),
                'fileName': basename,
                'date': DateTime.now().toString().substring(0, 10),
                'publisher': widget.teacherName
              });}
        if (occupationalSpecialist == true) {
          var addFileToOccupationalSpecialistStudent = Specialists.doc(
              widget.occupationalSpecialistId).collection("Students").doc(
              widget.studentId).collection('StudyCases').doc(
              "${widget.studentId}$documentId File").set(
              {
                'filePath': fileUrl,
                'createdAt': Timestamp.now(),
                'fileName': basename,
                'date': DateTime.now().toString().substring(0, 10),
                'publisher': widget.teacherName
              });
        }
        setState(() {
          psychologySpecialist = false;
          communicationSpecialist = false;
          occupationalSpecialist = false;
          physiotherapySpecialist = false;
          showMassage = false;
          showMassage2 = false;
        });
       }
      showDownloadProgress(received, total) {
        if (total != -1) {
          setState(() {
            download = ((received / total * 100).toStringAsFixed(0) + "%");
          });
        }
      }
    }