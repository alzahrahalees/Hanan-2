import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Constance.dart';

class MonthlyReports extends StatefulWidget {
  final String studentId;
  final String planId;

  const MonthlyReports({@required this.studentId, @required this.planId});

  @override
  _MonthlyReportsState createState() => _MonthlyReportsState();
}

class _MonthlyReportsState extends State<MonthlyReports> {
  int _numOfMonth = DateTime.now().month;

  String _notes = 'لا يوجد ملاحظات';

  List<String> months = [
    'يناير',
    'فبراير',
    'مارس',
    'إبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر'
  ];

  @override
  Widget build(BuildContext context) {
    String _month = months[_numOfMonth - 1];
    String _hint = months[_numOfMonth - 1];
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundPageColor,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: Text(
            'التقارير الشهريه',
            style: kTextAppBarStyle,
          ),
          iconTheme: IconThemeData(color: kUnselectedItemColor),
          centerTitle: true,
          toolbarHeight: 50,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: kBackgroundPageColor,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("اختر الشهر:",
                          style: kTextPageStyle.copyWith(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    new Padding(padding: new EdgeInsets.all(7)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: DropdownButton(
                          isExpanded: false,
                          hint: Text(_hint),
                          value: _month,
                          onChanged: (newValue) {
                            setState(() {
                              _month = newValue;
                              _numOfMonth = months.indexOf(_month) + 1;
                            });
                          },
                          items: months.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    width: 330,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.deepPurple.shade100, width: 3.0),
                        // set border width
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        // set rounded corner radius
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.grey,
                              offset: Offset(1, 3))
                        ] // make rounded corner of border
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            child: Center(child: Text('المجال')),
                            width: 100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                              width: 100,
                              child: Center(
                                  child: Text(
                                'الهدف',
                                textAlign: TextAlign.center,
                              ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text('التقييم'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text('المساعدة'),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Students')
                        .doc(widget.studentId)
                        .collection('Plans')
                        .doc(widget.planId)
                        .collection('Reports')
                        .doc('monthlyReports')
                        .collection(_numOfMonth.toString())
                        .orderBy('goalType')
                        .snapshots(),
                    builder: (BuildContext context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: SpinKitFoldingCube(
                          color: kUnselectedItemColor,
                          size: 60,
                        ));
                      } else {
                        return ListView.builder(
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              DocumentSnapshot document =
                                  snapshot.data.docs[index];
                              if (document.id == 'note') {
                                setState(() {
                                  _notes = document.data()['note'];
                                });
                                return SizedBox();
                              } else {
                                String eval = document.data()['evaluation'];
                                String help = document.data()['helpType'] == ''
                                    ? 'لا يوجد'
                                    : document.data()['helpType'];
                                String goalName = document.data()['goalName'];
                                String goalType = document.data()['goalType'];
                                return Container(
                                  width: 330,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.deepPurple.shade100,
                                          width: 3.0),
                                      // set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      // set rounded corner radius
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.grey,
                                            offset: Offset(1, 3))
                                      ] // make rounded corner of border
                                      ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                            goalType,
                                            textAlign: TextAlign.center,
                                          )),
                                          width: 100,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                goalName,
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(eval,
                                            textAlign: TextAlign.center),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(help,
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                      }
                    }),
                // Row(
                //   children: [
                //     Padding(
                //       padding:
                //       const EdgeInsets.only(top: 20, right: 8),
                //       child: Text('ملاحظات شهر $_month : '),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5, bottom: 5),
                //   child: Container(
                //     width: 400,
                //     height: 100,
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         border: Border.all(
                //             color: Colors.deepPurple.shade100,
                //             width: 3.0),
                //         // set border width
                //         borderRadius:
                //         BorderRadius.all(Radius.circular(10.0)),
                //         // set rounded corner radius
                //         boxShadow: [
                //           BoxShadow(
                //               blurRadius: 5,
                //               color: Colors.grey,
                //               offset: Offset(1, 3))
                //         ] // make rounded corner of border
                //     ),
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: TextFormField(
                //           textAlign: TextAlign.start,
                //           initialValue: _notes,
                //           maxLines: null,
                //           minLines: null,
                //           expands: true,
                //           cursorColor: kSelectedItemColor,
                //           decoration: InputDecoration(
                //               focusedBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(
                //                       color: Colors.deepPurple,
                //                       width: 2)),
                //               hintText: _notes,
                //               helperStyle: TextStyle(
                //                 fontSize: 16,
                //                 color: Colors.black38,
                //               )),
                //           onChanged: (value) {
                //             setState(() {
                //               _notes = value;
                //             });
                //           },
                //           // controller: note,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: RaisedButton(
                //     color: kButtonColor,
                //     child: Text("حفظ الملاحظات ", style: kTextButtonStyle),
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(18.0)),
                //     onPressed: () {
                //       FirebaseFirestore.instance
                //           .collection('Students')
                //           .doc(widget.studentId)
                //           .collection('Plans')
                //           .doc(widget.planId)
                //           .collection('Reports')
                //           .doc('monthlyReports')
                //           .collection(_numOfMonth.toString())
                //           .doc('note')
                //           .update({'note': _notes}).whenComplete(
                //               () => print('note is added to $_month'));
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
