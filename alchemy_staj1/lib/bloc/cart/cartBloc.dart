import 'dart:developer';

import 'package:alchemy_staj1/bloc/cart/cartEvent.dart';
import 'package:alchemy_staj1/bloc/cart/cartState.dart';
import 'package:alchemy_staj1/data/cartData.dart';
import 'package:alchemy_staj1/model/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc extends Bloc<CartEvent,CartState>{

  BehaviorSubject<List<Book>> _books = new BehaviorSubject();

  Stream<List<Book>> get bookstream => _books.stream;

  CartBloc() : super(InitState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async*{
    if(event is AddItem){
      //var temp = _books.value;
      var temp = CartData().cartList;
      log(temp.length.toString());
      temp.add(event.book);
      _books.sink.add(temp);
      CartData().cartList=temp;
      yield InitState();
    }else if(event is RemoveItem){
      var temp = CartData().cartList;
      log(temp.length.toString());
      temp.remove(event.book);
      _books.sink.add(temp);
      CartData().cartList=temp;
      yield InitState();
    }else if(event is InitList){
      var temp = CartData().cartList;
      log(temp.length.toString()+"bb");
      _books.sink.add(temp);
      CartData().cartList=temp;
      yield InitState();
    }
  }

}