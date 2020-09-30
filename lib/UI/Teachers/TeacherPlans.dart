import 'package:flutter/material.dart';
import '../Constance.dart';

class PlansScreen extends StatefulWidget {
  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "This is Plans Screen",
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
