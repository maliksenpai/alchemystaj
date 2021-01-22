import 'dart:async';
import 'dart:developer';

import 'package:alchemy_staj1/bloc/blocProvider.dart';
import 'package:alchemy_staj1/bloc/user/userEvent.dart';
import 'package:alchemy_staj1/bloc/user/userState.dart';
import 'package:alchemy_staj1/data/preferences/userPreferences.dart';
import 'package:alchemy_staj1/model/user.dart';
import 'package:alchemy_staj1/utils/loginValidator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';


class UserBloc extends Bloc<UserEvent,UserState>{

  List<User> users = [User(id:0,name: "enes",surname: "acun",birthdate: "1",gender: "e") , User(id:1,name: "easd",surname: "aasdun",birthdate: "12",gender: "e") , User(id:2,name: "enasd",surname: "acasdun",birthdate: "3",gender: "e") ,User(id:3,name: "sdf",surname: "acdsf",birthdate: "4",gender: "k")  ];

  UserBloc() : super(InitState());


 // UserBloc(UserState initialState) : super(InitState());


  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    yield LoginLoading();
    await Future.delayed(const Duration(seconds: 1));
    if(event is LoginWithNickPass){
      try{

        var temp = -1;
        users.forEach((element)  {
          if(element.name==event.name && element.surname==event.surname){
            temp=element.id;
          }
        });
        if(temp!=-1){
          yield LoginSuccess();
          UserPreferences prefs = new UserPreferences();
          prefs.login(temp);
        }else{
          throw "Hata meydana geldi";
        }

      }catch(e){
          yield LoginError(error: e.toString());
      }


    }else if(event is ErrorBack){

      yield InitState();

    }else if(event is CheckUser){

      UserPreferences prefs = new UserPreferences();
      bool temp = await prefs.checkUser();

      if(temp){
        log("haveuser");
        yield HaveUser();
      }else{
        log("haventuser");
        yield InitState();
      }

    }
  }


}


/*class UserBloc with LoginValidator implements BlocBase{

 
  List<User> users = [User(id:0,name: "enes",surname: "acun",birthdate: "1",gender: "e") , User(id:1,name: "easd",surname: "aasdun",birthdate: "12",gender: "e") , User(id:2,name: "enasd",surname: "acasdun",birthdate: "3",gender: "e") ,User(id:3,name: "sdf",surname: "acdsf",birthdate: "4",gender: "k")  ];
  BehaviorSubject<bool> check = BehaviorSubject<bool>();
  Stream<bool> get checkstream => check.stream;
  BehaviorSubject<User> user = BehaviorSubject<User>();
  BehaviorSubject<String> name = BehaviorSubject<String>() ?? "";
  BehaviorSubject<String> surname = BehaviorSubject<String>() ?? "";
  

  Stream<String> get namestream => name.stream.transform(namevalidator);
  Stream<String> get surnamestream => surname.stream.transform(surnamevalidator);
  
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
  submit(String name,String surname){
    check.sink.add(false);
    users.forEach((element) async{
      if(element.name==name && element.surname==surname){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt("id", element.id);
        check.sink.add(true);
        log("oldu");
      }
    });
  }




  @override
  void dispose() {
    check.close();
  }

*/