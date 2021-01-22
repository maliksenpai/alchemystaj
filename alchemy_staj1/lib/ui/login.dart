import 'dart:developer';

import 'package:alchemy_staj1/bloc/blocProvider.dart';
import 'package:alchemy_staj1/bloc/user/userBloc.dart';
import 'package:alchemy_staj1/bloc/user/userEvent.dart';
import 'package:alchemy_staj1/bloc/user/userState.dart';
import 'package:alchemy_staj1/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu.dart';


  /*checkuser(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getInt("id")!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu()));
    }
  }*/


class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }

}

class _LoginPage extends State<LoginPage>{
  UserBloc bloc = UserBloc();
  String user="deneme";
  TextEditingController namecontroller=new TextEditingController();
  TextEditingController surnamecontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("LoginPage"),),
      body: SafeArea(
        child: BlocConsumer<UserBloc,UserState>(
          listener: (context,state) async {
            bloc = BlocProvider.of<UserBloc>(context);
            state = bloc.state;
            log("list"+state.toString());
            if(state is InitState){
              //loginScreen();
            }else if(state is LoginLoading){
              return Center(child:CircularProgressIndicator(),);
            }else if(state is LoginSuccess){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BlocProvider.value(value: bloc,child: MenuPage(),)  ));
              return Container();
            }else if(state is LoginError){
              return Center(child: Text("Hata:"+state.error),);
            }else if(state is HaveUser){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BlocProvider.value(value: bloc,child: MenuPage(),)  ));
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuPage() ));
              return Container();
            }else{
              return Container();
            }

          },
          builder: (context,state){
            bloc = BlocProvider.of<UserBloc>(context);
            state = bloc.state;
            //bloc.add(CheckUser());
            log("builder"+state.toString());
            if(state is InitState){
              bloc.add(CheckUser());
              return Center(child:CircularProgressIndicator(),);
            }else if(state is LoginState){
              return loginScreen();
            }else if(state is LoginLoading){
              return Center(child:CircularProgressIndicator(),);
            }else if(state is LoginError){
              return errorScreen(state.error);
            }else if(state is HaveUser){
              return Container();
            }else{
              return Container();
            }
          },
        ),
      ),
    );

    /*return Scaffold(
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
                name(bloc,namecontroller),
                surname(bloc,surnamecontroller),
                login(bloc,namecontroller,surnamecontroller),
              ],
            ),
          )
        ],
      ),
    );*/
  }

  Widget loginScreen(){
    return Column(
      children: [
        name(),
        surname(),
        login()
      ],
    );
  }

  Widget errorScreen(String error){
    return Center(
        child: Column(
          children:
          [
            Text("Hata:"+error),
            RaisedButton( onPressed: () => bloc.add(ErrorBack()),child: Text("Tekrar dene"),)
          ],
        )
    );
  }

  Widget name(){
          return TextField(
            controller: namecontroller,
            decoration: InputDecoration(
              labelText: "İsim",
              icon: Icon(Icons.account_box_sharp)
            ),
          );
        }

  Widget surname(){
    return TextField(
      controller: surnamecontroller,
      decoration: InputDecoration(
          labelText: "Soyisim",
          icon: Icon(Icons.supervisor_account)
      ),
    );
  }


  Widget login(){
    return RaisedButton(
      onPressed: () => bloc.add(LoginWithNickPass(name: namecontroller.text,surname: surnamecontroller.text)),
      child: Text("Giris yap"),
      color: Colors.blue,
    );
  }


}





