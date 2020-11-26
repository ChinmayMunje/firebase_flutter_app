import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter_app/Home_Page.dart';
import 'package:firebase_flutter_app/Login.dart';
import 'package:firebase_flutter_app/Signup.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Login(),
      routes: <String, WidgetBuilder> {
        '/landingpage': (BuildContext context)=> new MyApp(),
        '/signup': (BuildContext context)=> new Signup(),
        '/homepage': (BuildContext context)=> new Home_Page(),
      },
    );
  }
}
