import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hanan/UI/Constance.dart';


class LoadingScreen extends StatelessWidget{
  Widget build(BuildContext context) {
    return Container(
      color:kWolcomeBkg ,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SpinKitFoldingCube(
                color: kUnselectedItemColor,
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

