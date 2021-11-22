import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool pressAttention = false;
  bool loader = false;
  final registrationFormKey = GlobalKey<FormState>();

  var name = " ";
  var mobile = " ";
  var password = " ";
  var confirmPassword = " ";
  var email = " ";

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();

  registerUser() async {
    setState(() {
      loader = true;
    });
    try {
      if (password == confirmPassword) {
        var api = "${BASE_URL}/register";

        http.Response response = await http.post(Uri.parse(api),
            body: {"name": name,"mobile": mobile,"email": email, "password": password});

        if (response.statusCode == 200) {
          setState(() {
            loader = false;
          });
          final result = json.decode(response.body);
          //print(result);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Successfully Register",
              style: TextStyle(
                  fontSize: 14, color: Colors.white, fontFamily: "Poppins"),
            ),
            backgroundColor: blue,
          ));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ));
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${json.decode(response.body)}",
              style: TextStyle(
                  fontSize: 14, color: Colors.white, fontFamily: "Poppins"),
            ),
            backgroundColor: pink,
          ));
        }
      }
    } catch (e) {
      setState(() {
        loader = false;
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Error"),
                content: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            color: black,
            size: _width * 0.07,
          ),
        ),
      ),
      body: Form(
        key: registrationFormKey,
        child: Padding(
          padding: EdgeInsets.only(left: _width * 0.04, right: _width * 0.04),
          child: ListView(
            children: [
              SizedBox(height: _height * 0.03),
              Text(
                "Create an Account",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: _width * 0.075,
                    fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: _height * 0.02),
              Padding(
                padding: EdgeInsets.all(_width * 0.01),
                child: Theme(
                  child: TextFormField(
                    controller: nameController,
                    cursorColor: blue,
                    style: TextStyle(color: black),
                    decoration: InputDecoration(
                        labelText: "Your name",
                        fillColor: black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(color: black),
                        ),
                        border: InputBorder.none,
                        hintText: "Name",
                        hintStyle: TextStyle(fontFamily: "Poppins"),
                        labelStyle:
                            TextStyle(color: black, fontFamily: "Poppins")),
                  ),
                  data: Theme.of(context).copyWith(
                    primaryColor: blue,
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.all(_width * 0.01),
                child: Theme(
                  child: TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    cursorColor: blue,
                    style: TextStyle(color: black),
                    decoration: InputDecoration(
                        labelText: "Mobile",
                        fillColor: black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(color: black),
                        ),
                        border: InputBorder.none,
                        hintText: "Mobile",
                        hintStyle: TextStyle(fontFamily: "Poppins"),
                        labelStyle:
                            TextStyle(color: black, fontFamily: "Poppins")),
                  ),
                  data: Theme.of(context).copyWith(
                    primaryColor: blue,
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.all(_width * 0.01),
                child: Theme(
                  child: TextField(
                    cursorColor: blue,
                    controller: emailController,
                    style: TextStyle(color: black),
                    decoration: InputDecoration(
                        labelText: "Your Email",
                        fillColor: black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(color: black),
                        ),
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(fontFamily: "Poppins"),
                        labelStyle:
                            TextStyle(color: black, fontFamily: "Poppins")),
                  ),
                  data: Theme.of(context).copyWith(
                    primaryColor: blue,
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.all(_width * 0.01),
                child: Theme(
                  child: TextField(
                    cursorColor: blue,
                    controller: passwordController,
                    style: TextStyle(color: black),
                    decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(color: black),
                        ),
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(fontFamily: "Poppins"),
                        labelStyle:
                            TextStyle(color: black, fontFamily: "Poppins")),
                  ),
                  data: Theme.of(context).copyWith(
                    primaryColor: blue,
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.all(_width * 0.01),
                child: Theme(
                  child: TextField(
                    cursorColor: blue,
                    controller: confirmPasswordController,
                    style: TextStyle(color: black),
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        fillColor: black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(color: black),
                        ),
                        border: InputBorder.none,
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(fontFamily: "Poppins"),
                        labelStyle:
                            TextStyle(color: black, fontFamily: "Poppins")),
                  ),
                  data: Theme.of(context).copyWith(
                    primaryColor: blue,
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.03,
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  height: _height * 0.1,
                  child: new RaisedButton(
                    elevation: 0,
                    child: new Text(
                      'Register',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: _width * 0.045,
                        color: pressAttention ? white : blue,
                      ),
                    ),
                    textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: blue, width: 1)),
                    color: pressAttention ? blue : white,
                    onPressed: () {
                      setState(() {
                        pressAttention = !pressAttention;
                        name = nameController.text;
                        mobile = mobileController.text;
                        email = emailController.text;
                        password = passwordController.text;
                        confirmPassword = confirmPasswordController.text;
                        registerUser();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Choose(),
                        //     ));
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.03,
              ),
              Text(
                "By clicking on Sign Up, you are agree to the following Terms and conditions",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: _width * 0.034,
                    fontWeight: FontWeight.w400,
                    color: black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: _width * 0.037,
                        color: black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: _width * 0.04,
                          color: blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
