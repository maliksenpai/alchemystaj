import 'package:alchemy_staj3/model/e_order.dart';
import 'package:alchemy_staj3/model/person.dart';

class Persons{

  Persons._privateConstructor();

  static final Persons _persons = Persons._privateConstructor();

  factory Persons(){
    return _persons;
  }

  e_Order reservationInfo = new e_Order();

}