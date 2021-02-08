import 'package:alchemy_staj3/model/person.dart';
import 'package:equatable/equatable.dart';

class e_Order extends Equatable {
  int id;
  int order_id;
  int person_id;
  bool is_contact_person;
  bool is_accepted_privary_policy;
  bool is_accepted_service_policy;
  int company_id;
  Person person;

  e_Order(
      {this.id,
      this.order_id,
      this.person_id,
      this.is_contact_person,
      this.is_accepted_privary_policy,
      this.is_accepted_service_policy,
      this.company_id,
      this.person});

  @override
  List<Object> get props => [
        id,
        order_id,
        person_id,
        is_contact_person,
        is_accepted_privary_policy,
        is_contact_person,
        company_id,
        person
      ];
}
