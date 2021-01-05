import 'package:alchemy_staj1/bloc/blocProvider.dart';
import 'package:alchemy_staj1/model/author.dart';
import 'package:alchemy_staj1/model/book.dart';
import 'package:alchemy_staj1/model/loans.dart';
import 'package:rxdart/rxdart.dart';

class MenuBloc implements BlocBase {
  List<Book> books = [
    Book(
        bookId: 1,
        name: "Deneme1",
        pageCount: 100,
        typeId: 1,
        authorId: 1,
        isAvailable: true),
    Book(
        bookId: 2,
        name: "Deneme2",
        pageCount: 120,
        typeId: 1,
        authorId: 2,
        isAvailable: false),
    Book(
        bookId: 3,
        name: "Deneme3",
        pageCount: 130,
        typeId: 1,
        authorId: 1,
        isAvailable: true),
    Book(
        bookId: 4,
        name: "Deneme4",
        pageCount: 100,
        typeId: 2,
        authorId: 3,
        isAvailable: false)
  ];
  List<Author> authors = [
    Author(authorId: 1, name: "Deneme1", surname: "1Deneme"),
    Author(authorId: 2, name: "Deneme2", surname: "2Deneme"),
    Author(authorId: 3, name: "Deneme3", surname: "3Deneme")
  ];

  List<Loan> loans = [
    Loan(
        borrowId: 11,
        userId: 1,
        bookId: 111,
        takenDate: 1709953808,
        returnDate: 2000709853408),
    Loan(
        borrowId: 2,
        userId: 1,
        bookId: 1,
        takenDate: 3258354,
        returnDate: 4342350)
  ];

  BehaviorSubject<List<Book>> _booklist = BehaviorSubject<List<Book>>();
  BehaviorSubject<List<Author>> _authorlist = BehaviorSubject<List<Author>>();
  BehaviorSubject<List<Loan>> _loanlist = BehaviorSubject<List<Loan>>();

  Stream<List<Book>> get bookstream => _booklist.stream;

  Stream<List<Author>> get authorstream => _authorlist.stream;

  Stream<List<Loan>> get loanstream => _loanlist.stream;

  init() {
    _booklist.sink.add(books);
    _authorlist.sink.add(authors);
    _loanlist.sink.add(loans);
  }

  @override
  void dispose() {
    _booklist.close();
    _authorlist.close();
  }
}
