import 'package:alchemy_staj1/model/book.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class CartEvent extends Equatable{


  List<Object> get props => [];

}

class AddItem extends CartEvent{
  Book book;

  AddItem({@required this.book});

  @override
  List<Object> get props => [book];
}

class RemoveItem extends CartEvent{
  Book book;

  RemoveItem({@required this.book});

  @override
  List<Object> get props => [book];
}

class InitList extends CartEvent{

}
