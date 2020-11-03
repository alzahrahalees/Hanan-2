import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Constance.dart';



class PFiles extends StatefulWidget {

  @override
  _PFilesState createState() => new _PFilesState();
}

class _PFilesState extends State<PFiles> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String fileUrl;
  bool psychologySpecialistName2=false;
  bool communicationSpecialistName2=false;
  bool occupationalSpecialistName2=false;
  bool physiotherapySpecialistName2=false;
  bool showMassage=false;
  bool showMassage2=false;
  String download;
  @override
  Widget build(BuildContext context) {
    User userStudent = FirebaseAuth.instance.currentUser;
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("المرفقات", style: kTextAppBarStyle),
          centerTitle: true,
          backgroundColor: Colors.white70,),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream:  FirebaseFirestore.instance.collection('Students').doc(userStudent.email).collection('StudyCases').orderBy('createdAt',descending: true ).snapshots(),
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
                                Text(download!=null?"  جاري التحميل  "+download:""),
                                Column(
                                    children:  snapshot.data.docs.map((DocumentSnapshot document) {
                                      String publisher= " بواسطة ${document.data()['publisher']}";
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

  showDownloadProgress(received, total) {
    if (total != -1) {
      setState(() {
        download= ((received / total * 100).toStringAsFixed(0) + "%");
      });

    }
  }
}