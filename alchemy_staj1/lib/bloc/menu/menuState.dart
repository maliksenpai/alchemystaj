import 'package:alchemy_staj1/model/book.dart';
import 'package:equatable/equatable.dart';

class MenuState extends Equatable{
  @override
  List<Object> get props => [];

}

class BooksState extends MenuState{
  List<Book> books;



}

class AuthorsState extends MenuState{

}

class LoansState extends MenuState{

}