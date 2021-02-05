import 'package:alchemy_staj3/model/date.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DateState extends Equatable{

  @override
  List<Object> get props => [];

}

class InitState extends DateState{

}

class CompletedState extends DateState{
  DateTime time;
  String name;
  String surname;
  String mail;
  String number;


  CompletedState({@required this.time,@required this.name,@required this.surname,@required this.mail,@required this.number});
}

class FailedState extends DateState{
  String error;

  FailedState({@required this.error});

}