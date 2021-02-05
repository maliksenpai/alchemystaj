import 'package:equatable/equatable.dart';

class Person2 extends Equatable{

  int id;
  String name;
  String surname;
  String email;
  int number;

  Person2({this.id,this.name,this.surname,this.email,this.number});

  @override
  List<Object> get props => [id,name,surname,email,number];

}