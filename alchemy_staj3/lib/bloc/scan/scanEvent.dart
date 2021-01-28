import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ScanEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class TakeQR extends ScanEvent{
  String result;
  int code;
  TakeQR({@required this.code,@required this.result});
  @override
  List<Object> get props => [code,result];
}