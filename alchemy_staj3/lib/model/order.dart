import 'package:equatable/equatable.dart';

class Order extends Equatable {
  int id;
  int order_no;
  DateTime order_time;
  int country_id;
  int integration_id;
  double booking_fee_percent;
  double boking_fee_amount;
  double total_amount;

  Order(
      {this.id,
      this.order_no,
      this.order_time,
      this.country_id,
      this.integration_id,
      this.boking_fee_amount,
      this.booking_fee_percent,
      this.total_amount});

  @override
  List<Object> get props => [
        id,
        order_no,
        order_time,
        country_id,
        integration_id,
        booking_fee_percent,
        boking_fee_amount,
        total_amount
      ];
}
