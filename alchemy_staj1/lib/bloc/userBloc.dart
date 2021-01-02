import 'dart:async';
import 'dart:developer';

import 'package:alchemy_staj1/bloc/blocProvider.dart';
import 'package:alchemy_staj1/model/user.dart';
import 'package:alchemy_staj1/utils/loginValidator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

class UserBloc with LoginValidator implements BlocBase{

  List<User> users = [User(id:0,name: "enes",surname: "acun",birthdate: "1",gender: "e") , User(id:1,name: "easd",surname: "aasdun",birthdate: "12",gender: "e") , User(id:2,name: "enasd",surname: "acasdun",birthdate: "3",gender: "e") ,User(id:3,name: "sdf",surname: "acdsf",birthdate: "4",gender: "k")  ];
  BehaviorSubject<User> user = BehaviorSubject<User>();
  BehaviorSubject<String> name = BehaviorSubject<String>() ?? "";
  BehaviorSubject<String> surname = BehaviorSubject<String>() ?? "";
  BehaviorSubject<bool> check = BehaviorSubject<bool>();

  Stream<String> get namestream => name.stream.transform(namevalidator);
  Stream<String> get surnamestream => surname.stream.transform(surnamevalidator);
  Stream<bool> get checkstream => check.stream;
  Stream<bool> get submitlogin => Rx.combineLatest2(namestream,surnamestream,(n,s)=>true);

  changeName(String string) {name.sink.add(string); }
  changeSurnname(String string) { surname.sink.add(string);}

  submit() {
    check.sink.add(false);
    users.forEach((element) async {
      if(element.name==name.value && element.surname==surname.value){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("name", element.name);
        await prefs.setString("surname", element.surname);
        user.sink.add(element);
        check.sink.add(true);
        log("oldu");
      }
    });
  }





  @override
  void dispose() {
    user.close();
    name.close();
    surname.close();
  }


}