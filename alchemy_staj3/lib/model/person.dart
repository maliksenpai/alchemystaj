import 'package:alchemy_staj3/model/l_product.dart';
import 'package:equatable/equatable.dart';

enum Salutation{
  man,woman
}

class Person extends Equatable{


  int id;
  String first_name;
  String surname;
  String address;
  int country_id;
  int city_id;
  int county_id;
  String zipcode;
  String email;
  String phone_gsm;
  String date_of_birth;
  Salutation salutation;
  String tc_kimlik;
  String passaport_no;
  String other_no;
  List<L_Product> products;

  Person({this.id,
    this.first_name,
    this.surname,
    this.address,
    this.country_id,
    this.city_id,
    this.county_id,
    this.zipcode,
    this.email,
    this.phone_gsm,
    this.date_of_birth,
    this.salutation,
    this.tc_kimlik,
    this.passaport_no,
    this.other_no,
    this.products});

  @override
  List<Object> get props => throw UnimplementedError();

}