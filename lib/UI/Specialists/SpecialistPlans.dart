import 'package:flutter/material.dart';
import '../Constance.dart';


class PlansSpecialist extends StatefulWidget {
  @override
  _PlansSpecialistState createState() => _PlansSpecialistState();
}

class _PlansSpecialistState extends State<PlansSpecialist> {
  @override
  Widget build(BuildContext context) {



    return Container(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "This is plans page ",
                style: TextStyle(fontSize: 40),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "center: ${studentInfo.centerId}",
            //     style: TextStyle(fontSize: 40),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "teacher: ${studentInfo.teacherId}",
            //     style: TextStyle(fontSize: 40),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
