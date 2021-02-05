import 'package:alchemy_staj3/model/e_order.dart';
import 'package:alchemy_staj3/model/l_product.dart';
import 'package:alchemy_staj3/model/person.dart';
import 'package:alchemy_staj3/model/slot.dart';

class ReservationEvent{

}

class AddPerson extends ReservationEvent{
  Person person;

  AddPerson({this.person});
}

class AddProduct extends ReservationEvent{
  L_Product l_product;
  Person person;
  int index;

  AddProduct({this.l_product,this.person,this.index});
}

class SelectSlot extends ReservationEvent{
  Slot slot;
  Person person;
  int index;
  int index2;

  SelectSlot({this.slot,this.person,this.index,this.index2});
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