import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class MenuEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class ChangeMenuEvent extends MenuEvent{
  int page;

  ChangeMenuEvent({@required this.page});

  @override
  List<Object> get props => [page];
}

class MoreBooks extends MenuEvent{

}

