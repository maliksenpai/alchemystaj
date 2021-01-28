import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ScanState extends Equatable{
  @override
  List<Object> get props => [];

}

class InitState extends ScanState{

}

class CompleteState extends ScanState{
  String result;
  CompleteState({@required this.result});

  @override
  List<Object> get props => [result];
}

class FailedState extends ScanState{
  String error;

  FailedState({@required this.error});

  @override
  List<Object> get props => [error];
}