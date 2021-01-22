import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{


  UserPreferences(){}


  void login(int id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log("kayit:"+id.toString());
    prefs.setInt("id", id);
  }

  Future<bool> checkUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log(prefs.getInt("id").toString());
    if(prefs.getInt("id")!=null){
      return true;
    }
    return false;
  }

  Future<int> getId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("id");
  }

}
