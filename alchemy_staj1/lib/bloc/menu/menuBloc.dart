import 'dart:developer';

import 'package:alchemy_staj1/bloc/blocProvider.dart';
import 'package:alchemy_staj1/bloc/menu/menuEvent.dart';
import 'package:alchemy_staj1/bloc/menu/menuState.dart';
import 'package:alchemy_staj1/data/api/menuItems.dart';
import 'package:alchemy_staj1/data/preferences/userPreferences.dart';
import 'package:alchemy_staj1/model/author.dart';
import 'package:alchemy_staj1/model/book.dart';
import 'package:alchemy_staj1/model/loans.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuBloc extends Bloc<MenuEvent,MenuState> {


  int bookcount = 8;
  int bookinc = 5;

  BehaviorSubject<List<Book>> _booklist = BehaviorSubject<List<Book>>();
  BehaviorSubject<List<Author>> _authorlist = BehaviorSubject<List<Author>>();
  BehaviorSubject<List<Loan>> _loanlist = BehaviorSubject<List<Loan>>();

  MenuBloc() : super(BooksState());

  Stream<List<Book>> get bookstream => _booklist.stream;

  Stream<List<Author>> get authorstream => _authorlist.stream;

  Stream<List<Loan>> get loanstream => _loanlist.stream;



  @override
  void dispose() {
    _booklist.close();
    _authorlist.close();
  }


  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async*{

    if(event is ChangeMenuEvent){
      if(event.page==0){

        var books = MenuItems().books;
        List<Book> temp = [];
        books.forEach((element) {
          if(temp.length<bookcount){
            temp.add(element);
          }
        });
        _booklist.sink.add(temp);
        _booklist.value=temp;
        yield BooksState();
        _booklist.sink.add(temp);
        _booklist.value=temp;
        log(_booklist.value.length.toString()+"xx");

      }else if(event.page==1){

        var authors = MenuItems().authors;
        _authorlist.sink.add(authors);
        yield AuthorsState();
        _authorlist.sink.add(authors);
      }else{

        var loans = MenuItems().loans;
        List<Loan> temp = [];
        UserPreferences prefs = new UserPreferences();
        int id = await prefs.getId();
        loans.forEach((element) {
          if(element.userId==id){
            temp.add(element);
          }
        });
        _loanlist.sink.add(temp);
        yield LoansState();

      }

    }

    if(event is MoreBooks){
      bookcount=bookcount+bookinc;
      var books = MenuItems().books;
      List<Book> temp = [];
      books.forEach((element) {
        if(temp.length<bookcount){
          temp.add(element);
        }
      });
      _booklist.sink.add(temp);
      yield BooksState();
    }

  }
}

/*
init() async{
    List<Book> temp = [];
    books.forEach((element) {
      if(temp.length<bookcount){
        temp.add(element);
      }
    });
    _booklist.sink.add(temp);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("id");

    List<Loan> temp2= [];
    loans.forEach((element) {
      if(element.userId==id){
        temp2.add(element);
      }
    });
    _authorlist.sink.add(authors);
    _loanlist.sink.add(temp2);
  }

  morebook() async{
    bookcount=bookcount+bookinc;
    List<Book> temp = [];
    books.forEach((element) {
      if(temp.length<bookcount){
        temp.add(element);
      }
    });
    _booklist.sink.add(temp);
  }
 */
