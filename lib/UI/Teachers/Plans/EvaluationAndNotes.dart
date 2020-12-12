import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Constance.dart';

class NotesAndEvaluation extends StatefulWidget {
  final String studentId;
  final String planId;
  final String goalId;
  final String type;
  final String goalType;
  NotesAndEvaluation(
      {this.goalType, this.studentId, this.planId, this.goalId, this.type});

  @override
  _NotesAndEvaluationState createState() => _NotesAndEvaluationState();
}

class _NotesAndEvaluationState extends State<NotesAndEvaluation> {
  String _currentUser = FirebaseAuth.instance.currentUser.email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController note = TextEditingController();

    String name;



    Future<String> _getName() async {
      String name;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(_currentUser)
          .get()
          .then((value) {
        name = value.data()['name'];
      });
      return name;
    }

    Future<String> _getStudentName() async {
      String name;
      await FirebaseFirestore.instance
          .collection('Students')
          .doc(widget.studentId)
          .get()
          .then((value) {
        name = value.data()['name'];
      });
      return name;
    }

    Future<String> getGoalName() async {
      String aName;
      await FirebaseFirestore.instance
          .collection('Students')
          .doc(widget.studentId)
          .collection('Plans')
          .doc(widget.planId)
          .collection("Goals")
          .doc(widget.goalId)
          .get()
          .then((value) => aName = value.data()['goalTitle']);

      return aName;
    }

    CollectionReference studentGoalEval = FirebaseFirestore.instance
        .collection('Students')
        .doc(widget.studentId)
        .collection('Plans')
        .doc(widget.planId)
        .collection("Goals")
        .doc(widget.goalId)
        .collection('Evaluation');

    CollectionReference studentNotes = FirebaseFirestore.instance
        .collection('Students')
        .doc(widget.studentId)
        .collection('Plans')
        .doc(widget.planId)
        .collection("Goals")
        .doc(widget.goalId)
        .collection('Notes');

    CollectionReference planPath = FirebaseFirestore.instance
        .collection('Students')
        .doc(widget.studentId)
        .collection('Plans')
        .doc(widget.planId)
        .collection('Reports');

    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: StreamBuilder(
                stream: studentGoalEval.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: SpinKitFoldingCube(
                        color: kUnselectedItemColor,
                        size: 60,
                      ),
                    );
                  if (snapshot.connectionState == ConnectionState.waiting)  {
                    return Center(
                      child: SpinKitFoldingCube(
                        color: kUnselectedItemColor,
                        size: 60,
                      ),
                    );}
                  return Column(
                      // shrinkWrap: true,
                      children: snapshot.data.docs
                          .map<Widget>((DocumentSnapshot doc) {
                    if (doc.data().isEmpty && widget.type == 'Teachers') {
                      return GestureDetector(
                          onTap: () async {
                            String nameOfGoal = await getGoalName();
                            String nameOfStudent = await _getStudentName();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEvaluation(
                                          goalType: widget.goalType,
                                          reportPath: planPath,
                                          collectionPath: studentGoalEval,
                                          studentName: nameOfStudent,
                                          goalName: nameOfGoal,
                                          goalId: widget.goalId,
                                          planId: widget.planId,
                                          studentId: widget.studentId,
                                        )));
                          },
                          child: ReusableCard(
                            color: kCardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: <Widget>[
                                Icon(Icons.add),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(" إضافة تقييم نهائي للطالب ",
                                      style: kTextPageStyle.copyWith(
                                          fontSize: 18)),
                                )
                              ]),
                            ),
                          ));
                    } else if (doc.data().isEmpty &&
                        widget.type != 'Teachers') {
                      return Text("لم يتم إضافة تقييم نهائي للطالب ",
                          style: kTextPageStyle.copyWith(fontSize: 18));
                    } else {
                      String evaluation = doc.data()['evaluation'];
                      String helpType = doc.data()['helpType'];
                      String note = doc.data()['notes'];
                      String goalName = doc.data()['goalName'];
                      String studentName = doc.data()['studentName'];
                      String yearOfPub = doc.data()['yearOfPublish'].toString();
                      String monthOfPub =
                          doc.data()['monthOfPublish'].toString();
                      String dayOfPub = doc.data()['dayOfPublish'].toString();

                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              'هل أتقن $studentName الهدف ($goalName)؟',
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              width: 330,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.deepPurple.shade100,
                                      width: 3.0),
                                  // set border width
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  // set rounded corner radius
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.grey,
                                        offset: Offset(1, 3))
                                  ] // make rounded corner of border
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text('تقييم الأداء: '),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(evaluation),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(8.0)),
                            Container(
                              width: 330,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.deepPurple.shade100,
                                      width: 3.0),
                                  // set border width
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  // set rounded corner radius
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.grey,
                                        offset: Offset(1, 3))
                                  ] // make rounded corner of border
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text('نوع المساعدة: '),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(helpType == null
                                          ? 'لا يوجد'
                                          : helpType),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(8.0)),
                            Container(
                              width: 330,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.deepPurple.shade100,
                                      width: 3.0),
                                  // set border width
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  // set rounded corner radius
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.grey,
                                        offset: Offset(1, 3))
                                  ] // make rounded corner of border
                                  ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('ملاحظات وتفاصيل أخرى: '),
                                    SizedBox(
                                      width: 330,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          initialValue:
                                              note == null ? 'لا يوجد' : note,
                                          readOnly: true,
                                          minLines: 2,
                                          maxLines: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 30, top: 8.0, bottom: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'تاريخ التقييم: ',
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  Text(
                                    '$yearOfPub / $monthOfPub / $dayOfPub',
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }).toList());
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'الملاحظات: ',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Column(
                children: [
                  StreamBuilder(
                      stream: studentNotes.orderBy('createdAt').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: SpinKitFoldingCube(
                              color: kUnselectedItemColor,
                              size: 60,
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SpinKitFoldingCube(
                              color: kUnselectedItemColor,
                              size: 60,
                            ),
                          );
                        }
                        return ListView.builder(
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document =
                                snapshot.data.docs[index];
                            String theNote = document.data()['note'];
                            String year =
                                document.data()['yearOfPublish'].toString();
                            String month =
                                document.data()['monthOfPublish'].toString();
                            String day =
                                document.data()['dayOfPublish'].toString();
                            String nameOfPublisher =
                                document.data()['nameOfPublisher'];
                            String email = document.data()['email'];

                            return Card(
                                color: Colors.white,
                                borderOnForeground: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Text(nameOfPublisher),
                                      trailing: Text(
                                        '$year / $month / $day',
                                        style: TextStyle(color: Colors.black38),
                                      ),
                                    ),
                                    Divider(
                                      height: 12,
                                    ),
                                    ListTile(
                                      title: Text(
                                        theNote,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      trailing: email == _currentUser
                                          ? IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                return Alert(
                                                  context: context,
                                                  type: AlertType.error,
                                                  title:
                                                      " هل أنت مـتأكد من الحذف ؟ ",
                                                  desc: "",
                                                  buttons: [
                                                    DialogButton(
                                                      child: Text(
                                                        "لا",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      color: kButtonColor,
                                                    ),
                                                    DialogButton(
                                                      child: Text(
                                                        "نعم",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                      onPressed: () {
                                                        studentNotes
                                                            .doc(document.id)
                                                            .delete();
                                                        Navigator.pop(context);
                                                      },
                                                      color: kButtonColor,
                                                    ),
                                                  ],
                                                ).show();
                                              })
                                          : SizedBox(),
                                    )
                                  ],
                                ));
                          },
                        );
                      }),
                  Container(
                    height: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            width: 300,
                            height: 180,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.deepPurple.shade100,
                                    width: 3.0), // set border width
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0)), // set rounded corner radius
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey,
                                      offset: Offset(1, 3))
                                ] // make rounded corner of border
                                ),
                            child: TextFormField(
                              maxLines: 20,
                              showCursor: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                hintText: "اضافة ملاحظة",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kBackgroundPageColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kBackgroundPageColor),
                                ),
                              ),
                              textInputAction: TextInputAction.unspecified,
                              controller: note,
                              // ignore: missing_return
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'مطلوب';

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      color: kButtonColor,
                      child: Text("إضافة", style: kTextButtonStyle),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      onPressed: () async {
                        var random = new Random();
                        int documentId = random.nextInt(4294967265);
                        name = await _getName();
                        if (_formKey.currentState.validate()) {
                          studentNotes
                              .doc('$_currentUser' + 'note' + '$documentId')
                              .set({
                            'createdAt': Timestamp.now(),
                            'nameOfPublisher': name,
                            'email': _currentUser,
                            'note': note.text,
                            'yearOfPublish': DateTime.now().year,
                            'monthOfPublish': DateTime.now().month,
                            'dayOfPublish': DateTime.now().day,
                          }).whenComplete(() {
                            print('note is added');
                            note.clear();
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddEvaluation extends StatefulWidget {
  final String studentId;
  final String planId;
  final String goalId;
  final String goalName;
  final String studentName;
  final String goalType;
  final CollectionReference collectionPath;
  final CollectionReference reportPath;

  const AddEvaluation(
      {this.reportPath,
      this.studentId,
      this.planId,
      this.goalId,
      this.studentName,
      this.goalName,
      this.goalType,
      this.collectionPath});

  @override
  _AddEvaluationState createState() => _AddEvaluationState();
}

class _AddEvaluationState extends State<AddEvaluation> {

  onChangedValue(value) {
    setState(() {
      _achievementValue = value;
    });
  }

  String communicationSpecialistId ;
  String psychologySpecialistId ;
  String occupationalSpecialistId ;
  String physiotherapySpecialistId;

  getSpecialists() async{


    FirebaseFirestore.instance.collection('Students')
        .doc(widget.studentId).collection('Plans')
        .doc(widget.planId).collection('Goals')
        .doc(widget.goalId).get().then((value) {
          setState(() {
            communicationSpecialistId = value.data()['communicationSpecialistId'];
            occupationalSpecialistId = value.data()['occupationalSpecialistId'];
            psychologySpecialistId = value.data()['psychologySpecialistId'];
            physiotherapySpecialistId = value.data()['physiotherapySpecialistId'];
          });
    });



  }



  TextEditingController helper = TextEditingController();
  TextEditingController notes = TextEditingController();
  String _achievementValue = 'أتقن';

  bool _withHelp = false;

  @override
  void initState() {
    super.initState();
    getSpecialists();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: kAppBarColor,
        title: Text(
          'إضافة التقييم النهائي للهدف',
          style: kTextAppBarStyle,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: kUnselectedItemColor),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 330,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(color: Colors.deepPurple.shade100, width: 3.0),
                  // set border width
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  // set rounded corner radius
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5, color: Colors.grey, offset: Offset(1, 3))
                  ] // make rounded corner of border
                  ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'هل أتقن ${widget.studentName} الهدف (${widget.goalName})؟',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Radio(
                          toggleable: true,
                          activeColor: kSelectedItemColor,
                          value: 'أتقن',
                          groupValue: _achievementValue,
                          onChanged: (value) {
                            onChangedValue(value);
                            setState(() {
                              _withHelp = false;
                            });
                          },
                        ),
                        Text('أتقن'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Radio(
                          activeColor: kSelectedItemColor,
                          value: 'أتقن بمساعدة',
                          groupValue: _achievementValue,
                          onChanged: (value) {
                            onChangedValue(value);
                            setState(() {
                              _withHelp = true;
                            });
                          },
                        ),
                        Text('أتقن بمساعدة'),
                      ],
                    ),
                  ),
                  _withHelp
                      ? Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 10, bottom: 10),
                          child: TextFormField(
                            cursorColor: kSelectedItemColor,
                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurple, width: 2)),
                                hintText: "نوع المساعدة",
                                helperStyle: TextStyle(fontSize: 10)),
                            controller: helper,
                          ))
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Radio(
                          toggleable: true,
                          activeColor: kSelectedItemColor,
                          value: 'مازال يحتاج إلى تدريب',
                          groupValue: _achievementValue,
                          onChanged: (value) {
                            onChangedValue(value);
                            setState(() {
                              _withHelp = false;
                            });
                          },
                        ),
                        Text('يحتاج إلى تدريب أكثر'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 330,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(color: Colors.deepPurple.shade100, width: 3.0),
                  // set border width
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  // set rounded corner radius
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5, color: Colors.grey, offset: Offset(1, 3))
                  ] // make rounded corner of border
                  ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    cursorColor: kSelectedItemColor,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple, width: 2)),
                        hintText: "إضافة ملاحظات وتفاصيل",
                        helperStyle: TextStyle(fontSize: 10)),
                    controller: notes,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              color: kButtonColor,
              child: Text("إضافة", style: kTextButtonStyle),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              onPressed: () {
                var random = new Random();
                int documentId = random.nextInt(4294967265);
                widget.collectionPath
                    .doc('eval')
                    .set({
                      'goalName': widget.goalName,
                      'studentName': widget.studentName,
                      'evaluation': _achievementValue,
                      'helpType': helper.text,
                      'notes': notes.text,
                      'yearOfPublish': DateTime.now().year,
                      'monthOfPublish': DateTime.now().month,
                      'dayOfPublish': DateTime.now().day,
                    })
                    .whenComplete(() => print('eval is add'))
                    .catchError(
                        (e) => print('inside on press of eval err: $e'));
                widget.reportPath
                    .doc('monthlyReports')
                    .collection(DateTime.now().month.toString())
                    .doc(widget.goalId)
                    .set({
                  'communicationSpecialistId': communicationSpecialistId,
                  'occupationalSpecialistId': occupationalSpecialistId,
                  'psychologySpecialistId': psychologySpecialistId,
                  'physiotherapySpecialistId': physiotherapySpecialistId,
                  'goalId': widget.goalName,
                  'goalName': widget.goalName,
                  'goalType': widget.goalType,
                  'month': DateTime.now().month,
                      'evaluation': _achievementValue,
                      'helpType': helper.text
                    })
                    .whenComplete(() => print('report is add'))
                    .catchError(
                        (e) => print('inside on press of eval err: $e'));
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
