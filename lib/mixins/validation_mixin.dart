import 'package:flutter/material.dart';

class ValidationMixin {
  String? emailValidation(String value) {
    if (!value.contains("@")) {
      return 'You have missed "@"';
    }
    return null;
  }


  String? passwordValidation (String value){
    if(value.length <8){
      return 'password should be of 8 Characters';
    }
    return null;
  }

}