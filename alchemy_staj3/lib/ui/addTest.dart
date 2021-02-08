import 'dart:developer';

import 'package:alchemy_staj3/bloc/reservation/reservationBloc.dart';
import 'package:alchemy_staj3/bloc/reservation/reservationEvent.dart';
import 'package:alchemy_staj3/data/persons.dart';
import 'package:alchemy_staj3/model/e_order.dart';
import 'package:alchemy_staj3/model/e_order_details.dart';
import 'package:alchemy_staj3/model/l_product.dart';
import 'package:alchemy_staj3/model/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTest extends StatefulWidget{

  e_Order person;

  AddTest({@required this.person});
  @override
  State<StatefulWidget> createState() => _AddTest(person: person);

}

class _AddTest extends State<AddTest>{

  e_Order person;

  _AddTest({@required this.person});

  List<L_Product> tests = [
   L_Product(id: 1,unit_price: 20),
   L_Product(id: 2,unit_price: 40),
   L_Product(id: 3,unit_price: 30),
   L_Product(id: 4,unit_price: 50),
  ];
  L_Product test = L_Product(id: 1,unit_price: 20);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("deneme"),),
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 20,),
            Text("Marka 1",style: TextStyle(fontSize: 20),),
            Container(height: 5,color: Colors.blueAccent,),
            RadioListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Text("Test 1"),Text(tests[0].unit_price.toString())],),
              value: tests[0],
              groupValue: test,
              onChanged: (value){
                setState(() {
                  test=tests[0];
                });
              },
            ),
            RadioListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Text("Test 2"),Text(tests[1].unit_price.toString())],),
              value: tests[1],
              groupValue: test,
              onChanged: (value){
                setState(() {
                  test=tests[1];
                });
              },
            ),
            Text("Marka 2",style: TextStyle(fontSize: 20),),
            Container(height: 5,color: Colors.blueAccent,),
            RadioListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Text("Test 3"),Text(tests[2].unit_price.toString())],),
              value: tests[2],
              groupValue: test,
              onChanged: (value){
                setState(() {
                  test=tests[2];
                });
              },
            ),
            Text("Marka 3",style: TextStyle(fontSize: 20),),
            Container(height: 5,color: Colors.blueAccent,),
            RadioListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Text("Test 4"),Text(tests[3].unit_price.toString())],),
              value: tests[3],
              groupValue: test,
              onChanged: (value){
                setState(() {
                  test=tests[3];
                });
              },
            ),
            RaisedButton(
              child: Text("Testi Seç"),
              onPressed: (){
                var id = Persons().orderid;
                e_Order_Details order_detail = new e_Order_Details(id: id,l_product_id: test.id,e_order_person_id: person.id,amount: test.unit_price);
                id++;
                Persons().orderid=id;
                /*if(person==null){
                  person.products=List<L_Product>();
                }*/
                //person.products.add(test);
                //Persons().reservationInfo.persons[index]=person;
                ReservationBloc bloc = BlocProvider.of(context);
                bloc.add(AddProduct(order_detail: order_detail));
                Navigator.of(context).pop(true);
              },
            )
          ],
        ),
      ),
    );
  }

}