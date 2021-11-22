import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_chef/auth/login.dart';
import 'package:home_chef/screens/home.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds:5),
            () => checkUser()
    );
  }

  Future<void> checkUser() async{

    SharedPreferences  prefs = await SharedPreferences.getInstance();
    var sessionToken = prefs.getString('token');
    print("ToKen "+sessionToken.toString());
    if(sessionToken == null){
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
    else{
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
    //sessionEmail == null ?  Navigator.push(context, MaterialPageRoute(builder: (context) => Login())): Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }
  Widget build(BuildContext context) {

    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: lightblue,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SvgPicture.asset(
            "assets/images/chef.svg",
            height: _height * 0.42,

          ),
          SizedBox(height:_height * 0.2 ,),
          SpinKitFadingCube(color: blue ,size: _height * 0.07,)
        ],
      ),

    );
  }
}
