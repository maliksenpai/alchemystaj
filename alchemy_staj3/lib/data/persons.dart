import 'package:alchemy_staj3/model/e_order.dart';
import 'package:alchemy_staj3/model/e_order_details.dart';
import 'package:alchemy_staj3/model/order.dart';
import 'package:alchemy_staj3/model/person.dart';
import 'package:alchemy_staj3/model/slot.dart';

class Persons{

  Persons._privateConstructor();

  int orderid=0;
  int e_order_id=0;
  int e_order_detail_id=0;
  int slot_id=0;

  static final Persons _persons = Persons._privateConstructor();

  factory Persons(){
    return _persons;
  }

  List<e_Order> reservationInfo = new List<e_Order>();
  Order order = new Order();
  List<e_Order_Details> e_order_details = new List<e_Order_Details>();
  List<Slot> slots = new List<Slot>();

}