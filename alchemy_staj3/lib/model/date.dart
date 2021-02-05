import 'package:equatable/equatable.dart';

class Date extends Equatable{

  int dateid;
  int personid;
  DateTime time;

  Date({this.dateid,this.personid,this.time});

  @override
  List<Object> get props => [dateid,personid,time];
}