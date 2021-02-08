import 'package:alchemy_staj3/model/e_order.dart';
import 'package:alchemy_staj3/model/e_order_details.dart';
import 'package:alchemy_staj3/model/l_product.dart';
import 'package:alchemy_staj3/model/person.dart';
import 'package:alchemy_staj3/model/slot.dart';
import 'package:flutter/cupertino.dart';

class ReservationEvent{

}

class AddPerson extends ReservationEvent{
  e_Order person;

  AddPerson({this.person});
}

class AddProduct extends ReservationEvent{
  /*L_Product l_product;
  Person person;
  int index;*/
  e_Order_Details order_detail;

  AddProduct({this.order_detail});
}

class SelectSlot extends ReservationEvent{
  Slot slot;
  e_Order_Details order_detail;
  int index;

  SelectSlot({this.slot,this.order_detail,this.index});
}

class SendOrder extends ReservationEvent{
  e_Order e_order;
  SendOrder({this.e_order});
}

class BackToInit extends ReservationEvent{

}

class ToAddPerson extends ReservationEvent{

}

class ToSelectSlot extends ReservationEvent{

}

class ToSelectProduct extends ReservationEvent{

}

class ChangeContactPerson extends ReservationEvent{
  int id;

  ChangeContactPerson({@required this.id});
}