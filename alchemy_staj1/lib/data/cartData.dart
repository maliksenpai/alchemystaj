import 'package:alchemy_staj1/model/book.dart';

class CartData{

  CartData._privateConstructor();

  static final CartData _cartData = CartData._privateConstructor();

  factory CartData(){
    return _cartData;
  }

  List<Book> cartList = List<Book>();



}