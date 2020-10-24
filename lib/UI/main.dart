import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'welcomeScreen.dart';
import 'Constance.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() {print('completed'); });
  runApp( new MaterialApp(

      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("ar"), // OR Locale('ar', 'AE') OR Other RTL locales,

    title: kTitleOfProject ,
    home: WelcomeScreen(),
  )
  );
}
