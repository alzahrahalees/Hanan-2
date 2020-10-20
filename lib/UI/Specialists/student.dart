import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentSp {

  String _studentName;
  String _studentId;
  String _teacherId;
  String _centerId;


  void setStudentName(String studentName){
    _studentName= studentName;
  }

  void setStudentId(String studentId){
    _studentId= studentId;
  }

  void setCenterId(String centerId){
    _centerId= centerId;
  }

  void setTeacherId(String teacherId){
    _teacherId= teacherId;
  }

  String getStudentName(){
    return _studentName;
  }

  String getStudentId(){
    return _studentId;
  }

  String getCenterId(){
    return _centerId;
  }

  String getTeacherId(){
    return _teacherId;
  }


}