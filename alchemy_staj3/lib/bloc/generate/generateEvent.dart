import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class GenerateEvent extends Equatable{
  @override
  List<Object> get props => [];

}

class GenerateQRCode extends GenerateEvent{
  String value;

  GenerateQRCode({@required this.value});

  @override
  List<Object> get props => [value];
}