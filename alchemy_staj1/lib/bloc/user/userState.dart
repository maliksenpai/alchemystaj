import 'package:alchemy_staj1/data/preferences/userPreferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserState extends Equatable{

  @override
  List<Object> get props => [];

}

class InitState extends UserState{

}

class LoginLoading extends UserState{

}

class LoginSuccess extends UserState{
  int id;

  LoginSuccess({@required this.id});


}

class LoginError extends UserState{
  String error;
  LoginError({@required this.error});

  @override
  List<Object> get props => [error];
}

class HaveUser extends UserState{

}