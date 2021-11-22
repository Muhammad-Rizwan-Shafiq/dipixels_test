import 'package:flutter/material.dart';
import 'package:home_chef/auth/signup.dart';
import 'package:home_chef/mixins/validation_mixin.dart';
import 'package:home_chef/models/login_model.dart';
import 'package:home_chef/screens/home.dart';
import 'package:home_chef/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String ?email;
  String ?password;
  String name = "";
  String ?mobile;
  bool loader = false;
  bool pressAttention = false;
  bool forEye = true;



  @override

  final formKey = GlobalKey<FormState>();
  List<String> valuesAdded = [];


  dynamic postData() async{
    setState(() {
      loader = true;
    });
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var api = "${BASE_URL}/login";
      // Map data = {"mobile": "03232314441", "password": "abc@1234"};
      //
      // String body = json.encode(data);

      http.Response response = await http.post(Uri.parse(api), body: {"mobile": mobile, "password": password});

      if(response.statusCode == 200) {
        setState(() {
          loader = false;
        });
        final result = json.decode(response.body);
         //print(result);
        final loginModelValues = LoginModel.fromJson(result);

        // LocalDataServer.saveEmail(loginModelValues.email);
        // LocalDataServer.saveStdId(loginModelValues.id);
        print(loginModelValues.name);




        prefs.setString('name', loginModelValues.name);
        prefs.setString('token', loginModelValues.token);


        ScaffoldMessenger.of(context).showSnackBar(SnackBar(

          content:Text("Successfully Login",style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: "Poppins"),),
          backgroundColor: blue,
        ));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Home(),
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
    catch(e){
      setState(() {
        loader = false;
      });
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(e.toString()),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    postData();

  }

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
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(left: _width * 0.04, right: _width * 0.04),
          child: ListView(
            children: [
              SizedBox(height: _height * 0.03),
              Text(
                "WELCOME",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: _width * 0.075,
                    fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: _height * 0.06),
              Padding(
                padding: EdgeInsets.all(_width * 0.01),
                child: Theme(
                  child: TextFormField(
keyboardType:TextInputType.number ,
                    cursorColor: blue,
                    style: TextStyle(color: black),
                    decoration: InputDecoration(
                        labelText: "Enter Mobile Number",
                        fillColor: black,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius:
                          new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(color: black),
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.mail),
                        hintText: "Enter your Mobile Number",
                        hintStyle: TextStyle(
                            fontFamily: "Poppins"),
                        labelStyle: TextStyle(
                            color: black,
                            fontFamily: "Poppins")),
                    validator: (value){
                      if(value!.length <10){
                        return 'password should be of 8 Characters';
                      }
                      return null;
                    },
                    onSaved: (String? value){
                      mobile=value;
                    },
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
                  child: TextFormField(
                    obscureText: forEye,
                    cursorColor: blue,
                    style: TextStyle(color: black),
                    decoration: InputDecoration(
                        labelText: "Enter Password",
                        fillColor: black,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius:
                          new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(color: black),
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon:GestureDetector(
                          onTap: (){
                            setState(() {
                              forEye=!forEye;
                            });
                          },
                          child: forEye ?Icon(Icons.visibility) : Icon(Icons.visibility_off),
                        ) ,
                        hintText: "Enter your password",
                        hintStyle: TextStyle(
                            fontFamily: "Poppins"),

                        labelStyle: TextStyle(
                            color: black,
                            fontFamily: "Poppins")),
                    validator: (value){
                      if(value!.length <8){
                        return 'password should be of 8 Characters';
                      }
                      return null;
                    },
                    onSaved: (String? value){
                      password=value;
                    },
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
                      'Login',
                      style: TextStyle(
                        fontFamily: "Montserrat-SemiBold",
                        fontSize: _width * 0.045,
                        color: pressAttention ? white : blue,
                      ),
                    ),
                    textColor: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: blue, width: 1)),
                    color: pressAttention ? blue : white,
                    onPressed: () async{
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                        print("your data is saved");
                        postData();
                        // Constants.name= await LocalDataServer.nameKey;

                      }
                      setState(() {

                        pressAttention = !pressAttention;

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
                    "Don't have an account?",
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
                            builder: (context) => Signup(),
                          ));
                    },
                    child: Text(
                      " Register",
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
