import 'package:alchemy_staj3/model/slot.dart';

class L_Product{
  int id;
  int company_id;
  String product_name;
  double unit_price;
  Slot slot;

  L_Product({this.id,this.company_id,this.product_name,this.unit_price});
}