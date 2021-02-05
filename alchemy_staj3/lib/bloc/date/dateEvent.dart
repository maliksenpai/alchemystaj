import 'package:alchemy_staj3/model/date.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DateEvent extends Equatable{

  @override
  List<Object> get props => [];

}

class NewDateA extends DateEvent{
  //int personid;
  DateTime time;
  String name;
  String surname;
  String mail;
  String number;

  NewDateA({@required this.time,@required this.name,@required this.surname,@required this.mail,@required this.number});

}

class NewDateB extends DateEvent{
  //int personid;
  DateTime time;
  String name;
  String surname;
  String mail;
  String number;

  NewDateB({@required this.time,@required this.name,@required this.surname,@required this.mail,@required this.number});

}

class Finish extends DateEvent{

}