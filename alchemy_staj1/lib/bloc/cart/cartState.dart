import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class CartState extends Equatable{
  @override
  List<Object> get props => [];

}

class InitState extends CartState{

}


class CompletedState extends CartState{

}

class ErrorState extends CartState{
  String error;

  ErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}
