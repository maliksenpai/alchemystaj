import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class LoginWithNickPass extends UserEvent{
  String name;
  String surname;

  LoginWithNickPass({@required this.name, @required this.surname});

  @override
  List<Object> get props => [name,surname];
}

class ErrorBack extends UserEvent{

}

class CheckUser extends UserEvent{

}