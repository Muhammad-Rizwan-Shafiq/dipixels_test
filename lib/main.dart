import 'package:flutter/material.dart';
import 'package:home_chef/auth/signup.dart';
import 'package:home_chef/splash_screen.dart';
import 'auth/login.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}


