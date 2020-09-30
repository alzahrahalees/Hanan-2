import 'package:hanan/user.dart';

class Teacher extends AUser{
  String name;
  String position;

  Teacher(String name, String position) {
    this.name = name;
    this.position = position;
  }
}