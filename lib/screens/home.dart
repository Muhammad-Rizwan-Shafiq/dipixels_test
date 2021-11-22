import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_chef/auth/login.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: prefer_typing_uninitialized_variables
  var name=" ";
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future<void> getUser() async{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    setState(() {

      name = prefs.getString('name')!;
      // cell.text = prefs.getString('cell');
      // photo=prefs.getString('photo');

      print(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("Home",
            style: TextStyle(fontFamily: "Montserrat-SemiBold", color: black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: black),
          actions: [
            IconButton(onPressed:() async{
              final pref = await SharedPreferences.getInstance();
              await pref.clear();
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            }, icon: Icon(Icons.logout))
          ],
        bottom: PreferredSize(
            child: Padding(
              padding: EdgeInsets.only(
                left: _width * 0.05,
                right: _width * 0.05,
              ),
              child: Container(
                color: black,
                height: 1.0,
              ),
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      // appBar: AppBar(
      //   title: Text(name),
      //   actions: [
      //     IconButton(onPressed:() async{
      //       final pref = await SharedPreferences.getInstance();
      //       await pref.clear();
      //       Navigator.pop(context);
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      //     }, icon: Icon(Icons.logout))
      //   ],
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome to HOME CHEF",style: TextStyle(color: black,fontFamily: "Poppins",fontSize: _width * 0.06,fontWeight: FontWeight.w900),),
            SizedBox(height: _height * 0.01,),
            Text("${name.toUpperCase()}",style: TextStyle(color: blue,fontFamily: "Poppins",fontSize: _width * 0.06),)
          ],
        ),
      ),

    );
  }
}
