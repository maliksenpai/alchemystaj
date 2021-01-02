import 'dart:developer';

import 'package:alchemy_staj1/bloc/blocProvider.dart';
import 'package:alchemy_staj1/bloc/userBloc.dart';
import 'package:alchemy_staj1/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu.dart';

class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  checkuser(context);
    return MaterialApp(
      title: "Login",
      home: BlocProviderr(
        bloc: UserBloc(),
        child: _Loginpage(),
      )
    );
  }

  checkuser(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("name")!=null && prefs.getString("surname")!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu()));
    }
  }

}

class _Loginpage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Loginpage();
  }

}

class Loginpage extends State<_Loginpage>{
  UserBloc bloc;
  String user="deneme";
  @override
  Widget build(BuildContext context) {
    bloc = BlocProviderr.of<UserBloc>(context);
    bloc.changeName(" ");
    bloc.changeSurnname(" ");
    return Scaffold(
      appBar: AppBar(title: Text("Login Page"),),
      body: Column(
        children: [
          Icon(
            Icons.local_library,
            size: 120.0,
          ),
          Center(
            child: Column(
              children: [
                name(bloc),
                surname(bloc),
                login(bloc),
                StreamBuilder(
                    stream: bloc.checkstream,
                    builder: (context,snapshot){
                      if(snapshot.data==true){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu()));
                        return Text(" ");
                      }else{
                        return Text(" ");
                      }
                    }
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget name(UserBloc bloc){
    return StreamBuilder(
        stream: bloc.namestream,
        builder: (context,snapshot){
          return TextField(
            onChanged: bloc.changeName,
            decoration: InputDecoration(
              labelText: "İsim",
              icon: Icon(Icons.account_box_sharp)
            ),
          );
        }
    );
  }

  Widget surname(UserBloc bloc){
    return StreamBuilder(
        stream: bloc.surnamestream,
        builder: (context,snapshot){
          return TextField(
            onChanged: bloc.changeSurnname,
            decoration: InputDecoration(
                labelText: "Soyisim",
                icon: Icon(Icons.supervisor_account)
            ),
          );
        }
    );
  }

  Widget login(UserBloc bloc){
    return StreamBuilder<bool>(
        stream: bloc.submitlogin,
        builder: (context,snapshot){
          return RaisedButton(
                onPressed: snapshot.hasError? null : bloc.submit,
                child: Text("Giris yap"),
                color: Colors.blue,

          );
        }
    );
  }
}