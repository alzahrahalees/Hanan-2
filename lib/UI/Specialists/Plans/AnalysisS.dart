import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Constance.dart';

class AnalysisDetailsS extends StatefulWidget {
  final String studentId;
  final String planId;
  final String goalId;
  AnalysisDetailsS({this.studentId,this.planId,this.goalId});
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<AnalysisDetailsS> {
  void dispose() {
    super.dispose();
    canEdit=false;
    _newStartDate=null;
    _newEndDate=null;
    _successfulTimes=null;
    _totalTimes=null;
    _helpType=null;
    _evaluation=null;
  }

  TextEditingController _proceduralGoal= TextEditingController();
  TextEditingController _startDate= TextEditingController();
  TextEditingController _endDate= TextEditingController();
  List<TextEditingController>_proceduralGoalL= [];
  List<TextEditingController> _startDateL= [];
  List<TextEditingController> _endDateL= [];
  List<TextEditingController> _successfulTimesL= [];
  List<TextEditingController> _totalTimesL= [];
  List<TextEditingController> _evaluationL= [];
  List<TextEditingController> _helpTypeL= [];
  String _newStartDate;
  String _newEndDate;
  String  _successfulTimes;
  String _totalTimes;
  String _helpType;
  String _evaluation;
  final _formkey = GlobalKey<FormState>();
  bool canEdit=false;
  User _userSpecialist = FirebaseAuth.instance.currentUser;


  Future<String> spicialistName() async {
    String name= "";
    await FirebaseFirestore.instance.collection('Specialists')
        .doc(_userSpecialist.email).get().then((data){
     name=data.data()['name'];
    });
    return name;
  }




  @override
  Widget build(BuildContext context) {
    User _userSpecialist = FirebaseAuth.instance.currentUser;
    CollectionReference studentsPlansGoal = FirebaseFirestore.instance.collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");
    CollectionReference specialistPlansGoal =FirebaseFirestore.instance.collection('Specialists').doc(_userSpecialist.email).collection('Students').doc(widget.studentId).collection('Plans').doc(widget.planId).collection("Goals");

    return SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream:specialistPlansGoal.where("goalId",isEqualTo: widget.goalId).snapshots(),
            builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData){
                return  Center(child: SpinKitFoldingCube(
                  color: kUnselectedItemColor,
                  size: 60,
                ));}
              else{return Container(
                  color: Colors.white70,
                  child:ListView(
                      children:[
                        Padding(padding: EdgeInsets.all(5)),
                        Column (children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              width:330,
                              decoration: BoxDecoration(
                                  color:Colors.white,
                                  border: Border.all(
                                      color: Colors.deepPurple.shade100,
                                      width: 3.0),   // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)), // set rounded corner radius
                                  boxShadow: [BoxShadow(blurRadius: 5,color: Colors.grey,offset: Offset(1,3))]// make rounded corner of border
                              ),
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.all(3)),
                                  GestureDetector(
                                    child: Row(
                                      children: [
                                        Icon(Icons.people_alt_rounded,color: Colors.deepPurple.shade100,),
                                        Padding(padding: EdgeInsets.all(3)),
                                        Text("عرض المشاركين في تحقيق الهدف",style:kTextPageStyle),
                                      ],
                                    ),
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (_) => StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                    title:
                                                    Container(
                                                      width: 270,
                                                      height: 270,
                                                      child: ListView(
                                                          shrinkWrap: true,
                                                          children: [
                                                            Column(
                                                                children:[
                                                                  Padding(padding: EdgeInsets.all(5)) ,
                                                                  Row(
                                                                    children: [
                                                                      Icon(Icons.people_alt_rounded,color: Colors.deepPurple.shade100,),
                                                                      Padding(padding: EdgeInsets.all(3)),
                                                                      Text("المشاركين في تحقيق الهدف : ",style: kTextPageStyle),
                                                                    ],
                                                                  ),
                                                                  Padding(padding: EdgeInsets.all(5)),
                                                                  document.data()['physiotherapySpecialistName']!=null?
                                                                  Row(
                                                                    children: [
                                                                      Text(document.data()['physiotherapySpecialistName'],style: kTextPageStyle),
                                                                      Text("  أخصائي العلاج الطبيعي",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                                                                    ],
                                                                  ):Text("",style: TextStyle(fontSize: 0),),
                                                                  document.data()['communicationSpecialistName']!=null?
                                                                  Row(
                                                                    children: [
                                                                      Text(document.data()['communicationSpecialistName'],style: kTextPageStyle),
                                                                      Text("  أخصائي التواصل",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                                                                    ],
                                                                  ):Text("",style: TextStyle(fontSize: 0),),
                                                                  document.data()['occupationalSpecialistName']!=null?
                                                                  Row(
                                                                    children: [
                                                                      Text(document.data()['occupationalSpecialistName'],style: kTextPageStyle),
                                                                      Text("  أخصائي العلاج الوظيفي",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                                                                    ],
                                                                  ):Text("",style: TextStyle(fontSize: 0),),
                                                                  document.data()['psychologySpecialistName']!=null?
                                                                  Row(
                                                                    children: [
                                                                      Text(document.data()['psychologySpecialistName'],style: kTextPageStyle),
                                                                      Text("  أخصائي العلاج النفسي",style: kTextPageStyle.copyWith(fontSize: 8,color: Colors.grey)),
                                                                    ],
                                                                  ):Text("",style: TextStyle(fontSize: 0),),

                                                                ])]),
                                                    ));}));
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.all(3)),
                                  GestureDetector(
                                      child: Row(
                                        children: [
                                          Icon(Icons.add,color: Colors.deepPurple.shade100,),
                                          Padding(padding: EdgeInsets.all(3)),
                                          Text("إضافة هدف إجرائي",style:kTextPageStyle),
                                        ],
                                      ),
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (_) => StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                      title: Container(
                                                        width: 270,
                                                        height: 270,
                                                        child: Form(
                                                          key: _formkey,
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children: [
                                                              Column(
                                                                  children:[
                                                                    Padding(padding: EdgeInsets.all(3)) ,
                                                                    SizedBox(
                                                                      child: TextFormField(
                                                                        controller: _proceduralGoal,
                                                                        minLines: 1,
                                                                        maxLines: 3,
                                                                        autocorrect: false,
                                                                        decoration: InputDecoration(
                                                                          labelText: 'الهدف الإجرائي',
                                                                          labelStyle: kTextPageStyle.copyWith(color: Colors.grey.shade700),
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderSide: BorderSide(color: Colors.deepPurple),
                                                                          ),
                                                                        ),
                                                                        validator: (value) {
                                                                          if (value.isEmpty) {
                                                                            return '* مطلوب';
                                                                          }

                                                                        },
                                                                      ),
                                                                    ),
                                                                    Padding(padding: EdgeInsets.all(6)),
                                                                    SizedBox(
                                                                      child: TextFormField(
                                                                        controller: _startDate,
                                                                        minLines: 1,
                                                                        decoration: InputDecoration(
                                                                          labelText: 'تاريخ البداية',
                                                                          labelStyle: kTextPageStyle.copyWith(color: Colors.grey.shade700),
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderSide: BorderSide(color: Colors.deepPurple),
                                                                          ),
                                                                        ),
                                                                        validator: (value) {
                                                                          if (value.isEmpty) {
                                                                            return '* مطلوب';
                                                                          }

                                                                        },
                                                                      ),
                                                                    ),
                                                                    Padding(padding: EdgeInsets.all(6)),
                                                                    SizedBox(
                                                                      child: TextFormField(
                                                                        controller:_endDate,
                                                                        minLines: 1,
                                                                        autocorrect: false,
                                                                        decoration: InputDecoration(
                                                                          labelText: 'تاريخ النهاية',
                                                                          labelStyle: kTextPageStyle.copyWith(color: Colors.grey.shade700),
                                                                          focusedBorder: OutlineInputBorder(
                                                                            borderSide: BorderSide(color: Colors.deepPurple),
                                                                          ),
                                                                        ),
                                                                        validator: (value) {
                                                                          if (value.isEmpty) {
                                                                            return '* مطلوب';
                                                                          }

                                                                        },
                                                                      ),
                                                                    ),
                                                                    Padding(padding: EdgeInsets.all(6)),
                                                                    SizedBox(
                                                                      child: Row(
                                                                        children: [
                                                                          FlatButton(onPressed: () async{
                                                                            if(_formkey.currentState.validate()){
                                                                              var random = new Random();
                                                                              int documentId = random.nextInt(1000000000);
                                                                              String specialistName= await spicialistName();
                                                                              var addProceduralGoalToStudent = studentsPlansGoal.doc(
                                                                                  widget.goalId).collection('ProceduralGoals').doc("${widget.goalId}${documentId} ProceduralGoal").set({
                                                                                'proceduralGoal':_proceduralGoal.text,
                                                                                'startDate':_startDate.text,
                                                                                'endDate':_endDate.text,
                                                                                'createdAt': Timestamp.now(),
                                                                                'proceduralGoalId':"${widget.goalId}${documentId} ProceduralGoal",
                                                                                'planId':widget.planId,
                                                                                'goalId':widget.goalId,
                                                                                'totalTimes':"",
                                                                                'successfulTimes':"",
                                                                                'evaluation':"",
                                                                                'helpType':"",
                                                                                'writer':specialistName,
                                                                                'writerId':_userSpecialist.email,
                                                                                'teacherName':"",
                                                                              });
                                                                              var addProceduralGoalToSpecialist = specialistPlansGoal.doc(
                                                                                  widget.goalId).collection('ProceduralGoals').doc("${widget.goalId}${documentId} ProceduralGoal").set({
                                                                                'proceduralGoal':_proceduralGoal.text,
                                                                                'startDate':_startDate.text,
                                                                                'endDate':_endDate.text,
                                                                                'createdAt': Timestamp.now(),
                                                                                'proceduralGoalId':"${widget.goalId}${documentId} ProceduralGoal",
                                                                                'planId':widget.planId,
                                                                                'goalId':widget.goalId,
                                                                                'totalTimes':"",
                                                                                'successfulTimes':"",
                                                                                'evaluation':"",
                                                                                'helpType':"",
                                                                                'writer':specialistName,
                                                                                'writerId':_userSpecialist.email,
                                                                                'teacherName':"",

                                                                              }).whenComplete(() {
                                                                                _proceduralGoal.clear();
                                                                                _startDate.clear();
                                                                                _endDate.clear();
                                                                                Navigator.pop(context);});
                                                                            }}, child: Text(  "إضافة",style:kTextPageStyle.copyWith(color: Colors.deepPurple))),
                                                                          Padding(padding: EdgeInsets.all(20)),
                                                                          FlatButton(onPressed: (){
                                                                            _proceduralGoal.clear();
                                                                            _startDate.clear();
                                                                            _endDate.clear();
                                                                            Navigator.pop(context);}, child: Text("إلغاء",style:kTextPageStyle.copyWith(color: Colors.deepPurple))),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ]),
                                                            ],
                                                          ),
                                                        ),
                                                      ));}));
                                      }
                                  ),
                                  Padding(padding: EdgeInsets.all(3)),
                                ],
                              ),
                            ),
                          );
                        }).toList()),
                        ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder:(context,index){
                              DocumentSnapshot documentSnapshot=snapshot.data.docs[index];
                              return Column(
                                  children:[
                                    Padding(padding: EdgeInsets.all(8)),
                                    Container(
                                      width:330,
                                      decoration: BoxDecoration(
                                          color:Colors.white,
                                          border: Border.all(
                                              color: Colors.deepPurple.shade100,
                                              width: 3.0),   // set border width
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)), // set rounded corner radius
                                          boxShadow: [BoxShadow(blurRadius: 5,color: Colors.grey,offset: Offset(1,3))]// make rounded corner of border
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.list,color: Colors.deepPurple.shade100),
                                              Padding(padding: EdgeInsets.all(5)),
                                              Text("متطلبات تحقيق الهدف:",style: kTextPageStyle.copyWith(color: Colors.black,fontSize: 15),),
                                            ],
                                          ),
                                          ListTile(
                                            title:Text(documentSnapshot['goalNeeds'],style:TextStyle(color: Colors.black,fontSize: 15)),
                                          ),  ],
                                      ),),

                                    StreamBuilder<QuerySnapshot>(
                                        stream: specialistPlansGoal.doc(widget.goalId).collection('ProceduralGoals').orderBy('createdAt',descending: true).snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData){
                                            return ListView(
                                              physics: ScrollPhysics(),
                                              shrinkWrap: true,
                                              children: [
                                                Padding(padding: EdgeInsets.all(15)),
                                                Center(child: Text("الأهداف الإجرائية",style: kTextPageStyle)),
                                                ListView.builder(
                                                    itemCount: snapshot.data.docs.length,
                                                    shrinkWrap: true,
                                                    physics: ScrollPhysics(),
                                                    itemBuilder:(context,index){
                                                      DocumentSnapshot documentSnapshot2=snapshot.data.docs[index];
                                                      // String Id=documentSnapshot2['proceduralGoalId'];
                                                      _proceduralGoalL.add(TextEditingController());
                                                      _startDateL.add(TextEditingController());
                                                      _endDateL.add(TextEditingController());
                                                      _successfulTimesL.add(TextEditingController());
                                                      _totalTimesL.add(TextEditingController());
                                                      _helpTypeL.add(TextEditingController());
                                                      _evaluationL.add(TextEditingController());
                                                      return Column(
                                                          children:[
                                                            Padding(
                                                              padding:  EdgeInsets.all(8.0),
                                                              child: Container(
                                                                width:330,
                                                                decoration: BoxDecoration(
                                                                    color:Colors.white,
                                                                    border: Border.all(
                                                                        color: Colors.deepPurple.shade100,
                                                                        width: 3.0),   // set border width
                                                                    borderRadius: BorderRadius.all(
                                                                        Radius.circular(10.0)), // set rounded corner radius
                                                                    boxShadow: [BoxShadow(blurRadius: 5,color: Colors.grey,offset: Offset(1,3))]// make rounded corner of border
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      alignment: Alignment.bottomLeft,
                                                                      child: Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              IconButton(icon: Icon(Icons.clear,size: 10,),
                                                                                onPressed: () {
                                                                                    showDialog(
                                                                                        context: context,
                                                                                        builder: (
                                                                                            _) =>
                                                                                        new AlertDialog(
                                                                                          content: new Text(
                                                                                              "هل تريد حذف الهدف الإجرائي"),
                                                                                          actions: <
                                                                                              Widget>[
                                                                                            Row(
                                                                                              children: [
                                                                                                FlatButton(
                                                                                                  child: Text(
                                                                                                    'حذف',
                                                                                                    style: TextStyle(
                                                                                                        color: Colors
                                                                                                            .deepPurple),),
                                                                                                  onPressed: () {
                                                                                                    studentsPlansGoal
                                                                                                        .doc(
                                                                                                        widget
                                                                                                            .goalId)
                                                                                                        .collection(
                                                                                                        'ProceduralGoals')
                                                                                                        .doc(
                                                                                                        documentSnapshot2['proceduralGoalId'])
                                                                                                        .delete();
                                                                                                    specialistPlansGoal
                                                                                                        .doc(
                                                                                                        widget
                                                                                                            .goalId)
                                                                                                        .collection(
                                                                                                        'ProceduralGoals')
                                                                                                        .doc(
                                                                                                        documentSnapshot2['proceduralGoalId'])
                                                                                                        .delete();
                                                                                                    Navigator
                                                                                                        .of(
                                                                                                        context)
                                                                                                        .pop();
                                                                                                  },
                                                                                                ),
                                                                                                FlatButton(
                                                                                                  child: Text(
                                                                                                    'إلغاء',
                                                                                                    style: TextStyle(
                                                                                                        color: Colors
                                                                                                            .deepPurple),),
                                                                                                  onPressed: () {
                                                                                                    Navigator
                                                                                                        .of(
                                                                                                        context)
                                                                                                        .pop();
                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            )
                                                                                          ],
                                                                                        ));
                                                                                  }



                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              IconButton(icon: Icon(Icons.edit),color: Colors.grey,
                                                                                onPressed: (){
                                                                                  setState(() {
                                                                                    canEdit=true;
                                                                                  });
                                                                                },
                                                                              ),
                                                                              Padding(padding: EdgeInsets.only(right: 180)),
                                                                              canEdit ==true?
                                                                              FlatButton(onPressed: (){
                                                                                setState(() {
                                                                                 specialistPlansGoal.doc(widget.goalId).collection("ProceduralGoals").doc(documentSnapshot2['proceduralGoalId']).update({
                                                                                    'startDate':_newStartDate!=null?_newStartDate:documentSnapshot2['startDate'],
                                                                                    'endDate':_newEndDate!=null?_newEndDate:documentSnapshot2['endDate'],
                                                                                    'totalTimes':_totalTimes!=null?_totalTimes:documentSnapshot2['totalTimes'],
                                                                                    'successfulTimes':_successfulTimes !=null?_successfulTimes:documentSnapshot2['successfulTimes'],
                                                                                    'evaluation':_evaluation !=null?_evaluation:documentSnapshot2['evaluation'],
                                                                                    'helpType':_helpType!=null?_helpType:documentSnapshot2['helpType'],
                                                                                  }
                                                                                  );

                                                                                 studentsPlansGoal.doc(widget.goalId).collection("ProceduralGoals").doc(documentSnapshot2['proceduralGoalId']).update({
                                                                                   'startDate':_newStartDate!=null?_newStartDate:documentSnapshot2['startDate'],
                                                                                   'endDate':_newEndDate!=null?_newEndDate:documentSnapshot2['endDate'],
                                                                                   'totalTimes':_totalTimes!=null?_totalTimes:documentSnapshot2['totalTimes'],
                                                                                   'successfulTimes':_successfulTimes !=null?_successfulTimes:documentSnapshot2['successfulTimes'],
                                                                                   'evaluation':_evaluation !=null?_evaluation:documentSnapshot2['evaluation'],
                                                                                   'helpType':_helpType!=null?_helpType:documentSnapshot2['helpType'],
                                                                                 }
                                                                                 );

                                                                                  canEdit=false;
                                                                                });}
                                                                                  , child: Text("حفظ",style: TextStyle(color: Colors.deepPurple),)):
                                                                              Text(""),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    Center(child: Text(documentSnapshot2['proceduralGoal'])),
                                                                    DataTable(
                                                                      showBottomBorder: true,
                                                                      dataRowHeight: 35,
                                                                      columnSpacing: 2,
                                                                      dividerThickness: 1,
                                                                      columns:  <DataColumn>[
                                                                        DataColumn(
                                                                          label: Text(
                                                                              '    عدد \n المحاولات\n    الكلية ',style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                                        ),
                                                                        DataColumn(
                                                                          label: Center(
                                                                            child: Text(
                                                                                '   عدد \nالمحاولات\n الناجحة',style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                                          ),
                                                                        ),
                                                                        DataColumn(
                                                                          label: Text(
                                                                              "تقييم \nالأداء",style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                                        ),
                                                                        DataColumn(
                                                                          label: Text(
                                                                              '   نوع \nالمساعدة ',style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                                        ),
                                                                        DataColumn(
                                                                            label: Text(
                                                                                "تاريخ \nالبداية",style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                                            numeric: true),
                                                                        DataColumn(
                                                                            label: Text(
                                                                                " تاريخ\n النهاية ",style:TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                                                            numeric: true  ),
                                                                      ],
                                                                      rows:  <DataRow>[
                                                                        DataRow(
                                                                          cells: <DataCell>[
                                                                            DataCell(TextField(
                                                                              controller:_totalTimesL[index],
                                                                              decoration:  InputDecoration(
                                                                                focusedBorder: UnderlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.deepPurple,width: 1)),
                                                                                hintText: documentSnapshot2['totalTimes']!=null?documentSnapshot2['totalTimes']:"",
                                                                                hintStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,),
                                                                              ),
                                                                              style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                                                                              readOnly: canEdit==true? false:true,
                                                                              onChanged: (value){
                                                                                setState(() {
                                                                                  _totalTimes=value;
                                                                                });
                                                                              },
                                                                            )),
                                                                            DataCell(TextField(
                                                                                readOnly: canEdit==true? false:true,
                                                                                controller:_successfulTimesL[index],
                                                                                decoration:  InputDecoration(
                                                                                  focusedBorder: UnderlineInputBorder(
                                                                                      borderSide: BorderSide(color: Colors.deepPurple,width: 1)),
                                                                                  hintText:documentSnapshot2 ['successfulTimes']!=null?documentSnapshot2['successfulTimes']:"",
                                                                                  hintStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,),
                                                                                ),
                                                                                onChanged: (value){
                                                                                  setState(() {
                                                                                    _successfulTimes=value;
                                                                                  });
                                                                                },
                                                                                style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)
                                                                            )),
                                                                            DataCell(TextField(
                                                                                readOnly: canEdit==true? false:true,
                                                                                controller:_evaluationL[index],
                                                                                decoration:  InputDecoration(
                                                                                  focusedBorder: UnderlineInputBorder(
                                                                                      borderSide: BorderSide(color: Colors.deepPurple,width: 1)),
                                                                                  hintText: documentSnapshot2 ['evaluation']!=null?documentSnapshot2 ['evaluation']:"",
                                                                                  hintStyle: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,),
                                                                                ),
                                                                                onChanged: (value){
                                                                                  setState(() {
                                                                                    _evaluation=value;
                                                                                  });
                                                                                },
                                                                                style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold)
                                                                            )),
                                                                            DataCell(TextField(
                                                                                readOnly: canEdit==true? false:true,
                                                                                controller:_helpTypeL[index],
                                                                                decoration:  InputDecoration(
                                                                                  focusedBorder: UnderlineInputBorder(
                                                                                      borderSide: BorderSide(color: Colors.deepPurple,width: 1)),
                                                                                  hintText: documentSnapshot2 ['helpType']!=null?documentSnapshot2 ['helpType']:"",
                                                                                  hintStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,),
                                                                                ),
                                                                                onChanged: (value){
                                                                                  setState(() {
                                                                                    _helpType=value;
                                                                                  });
                                                                                },
                                                                                style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)
                                                                            )),
                                                                            DataCell(TextField(
                                                                                readOnly: canEdit==true? false:true,
                                                                                controller:_startDateL[index],
                                                                                decoration:  InputDecoration(
                                                                                  focusedBorder: UnderlineInputBorder(
                                                                                      borderSide: BorderSide(color: Colors.deepPurple,width: 1)),
                                                                                  hintText: documentSnapshot2 ['startDate']!=null? documentSnapshot2 ['startDate']:"",
                                                                                  hintStyle: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,),
                                                                                ),
                                                                                onChanged: (value){
                                                                                  setState(() {
                                                                                    _newStartDate=value;
                                                                                  });
                                                                                },
                                                                                style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold)
                                                                            )),
                                                                            DataCell(TextField(
                                                                                readOnly: canEdit==true? false:true,
                                                                                controller:_endDateL[index],
                                                                                decoration:  InputDecoration(
                                                                                  focusedBorder: UnderlineInputBorder(
                                                                                      borderSide: BorderSide(color: Colors.deepPurple,width: 1)),
                                                                                  hintText:  documentSnapshot2['endDate']!=null?documentSnapshot2['endDate']:"",
                                                                                  hintStyle: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,),
                                                                                ),
                                                                                onChanged: (value){
                                                                                  setState(() {
                                                                                    _newEndDate=value;
                                                                                  });
                                                                                },
                                                                                style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)
                                                                            )),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(padding: EdgeInsets.all(7)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                          ]);}),
                                              ],
                                            );}
                                          else{  return  Center(child: SpinKitFoldingCube(
                                            color: kUnselectedItemColor,
                                            size: 60,
                                          ));}

                                        }
                                    ),
                                  ]);}),

                      ]));}}));
  }
}