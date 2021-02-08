import 'dart:developer';

import 'package:alchemy_staj3/bloc/reservation/reservationBloc.dart';
import 'package:alchemy_staj3/bloc/reservation/reservationEvent.dart';
import 'package:alchemy_staj3/bloc/reservation/reservationState.dart';
import 'package:alchemy_staj3/data/persons.dart';
import 'package:alchemy_staj3/model/e_order.dart';
import 'package:alchemy_staj3/model/e_order_details.dart';
import 'package:alchemy_staj3/model/person.dart';
import 'package:alchemy_staj3/model/slot.dart';
import 'package:alchemy_staj3/ui/addDate.dart';
import 'package:alchemy_staj3/ui/selectSlot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'addTest.dart';

class ReservationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ReservationPage();

}

class _ReservationPage extends State<ReservationPage>{
  ReservationBloc bloc;
  List<e_Order_Details> order_details = Persons().e_order_details;
  List<int> persons = new List<int>();
  int selectedPerson;
  List<int> orderPersons = List<int>();
  int contactPerson = Persons().reservationInfo.length==0 ? null : Persons().reservationInfo[0].id;

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.of<ReservationBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Randevu al"),),
      body: SafeArea(
          child: BlocConsumer<ReservationBloc,ReservationState>(
            cubit: bloc,
            builder: (context,state){
              state = bloc.state;
              log("build"+state.toString());
              var persons = Persons().reservationInfo;
              if(persons.length==0){
                Persons().reservationInfo=persons;//null hatasını engellemek için
              }
              if(state is InitState){
                if(persons.length==0){
                  bloc.add(ToAddPerson());
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(value: bloc,child: AddDate(),)));
                }
                return ListPersons();
              }else if(state is FinishedState){
                return Finished();
              }else if(state is AddPersonState){
                return ListPersons();
              }else{
                return Container();
              }
            },
            listener: (context,state){
              state = bloc.state;
              if(state is AddPersonState){
                Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(value: bloc,child: AddDate(),)));
              }
            },
          ),
        ),
    );
  }

  backtoInit(){
    bloc.add(BackToInit());
  }




  Widget AddProduct(){

  }

  Widget SelectSlot(){

  }

  Widget ListPersons(){
    var list = Persons().reservationInfo;
    var orders = Persons().e_order_details;
    return Column(
      children: [
        SizedBox(height: 10,),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context,index){
              var personOrder = new List<e_Order_Details>();
              orders.forEach((element) {
                if(element.e_order_person_id==list[index].id){
                  personOrder.add(element);
                }
              });
              if(orderPersons.length<list.length){
                orderPersons.add(list[orderPersons.length].id);
              }
              return RadioListTile(
                  value: list[index].id,
                  groupValue: contactPerson,
                  title: GestureDetector(
                      child: Text(list[index].person.first_name+" "+list[index].person.surname,style: TextStyle(fontSize: 20),),
                      onTap: () {
                        var result = Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(value: bloc,child: AddTest(person: list[index]),)));
                        result.then((value)  {
                          if(value){
                            setState(() {});
                          }
                        });
                      }
                  ),
                  subtitle: personOrder.length==0 ?
                  Text("Test eklemek için kişiye dokun") :
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: personOrder.length,
                    itemBuilder: (context,orderindex){
                      Slot slot;
                      Persons().slots.forEach((element) {
                        if(element.id==personOrder[orderindex ].slot_id){
                          slot = element;
                        }
                      });

                      DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(slot.slot_date));
                      String dateString = DateFormat("dd/MM/yyyy  -  kk:mm").format(date);
                      return ListTile(
                        title: GestureDetector(
                          child: Text(personOrder[orderindex].l_product_id.toString()),
                          onTap: () {
                            var result = Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(value: bloc,child: SelectSlotPage(order_detail: personOrder[orderindex],index: orderindex,),),));
                            result.then((value)  {
                              if(value==true){
                                setState(() { });
                              }
                            });
                          },
                        ),
                        trailing: slot==null ?
                        Text("Randevu tarihi ekleyin"):
                        Text(dateString,),
                      );
                    },
                  ),
                  onChanged: (value){
                    setState(() {
                      contactPerson = orderPersons[index];
                      bloc.add(ChangeContactPerson(id: contactPerson));
                    });
                  });

            },
          ),
        ),
        Container(height: 10,),
        //RaisedButton(onPressed: () => bloc.add(ToAddPerson()),child: Text("Yeni kişi ekle"),)
        Flexible(
          child: GestureDetector(
            child: Row(
              children: [
                Padding(
                  child: Icon(Icons.add_circle),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
                Text("Yeni kişi ekle",style: TextStyle(fontSize: 20),)
              ],
            ),
            onTap: () => bloc.add(ToAddPerson()),
          )
        )
      ],
    );
  }

  Widget Finished(){

  }
}

/*
Widget ListPersons(){
    var list = Persons().reservationInfo.persons;


    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context,index){
              log("sad"+list[index].products.length.toString());
              return ListTile(
                title: GestureDetector(
                  child: Text(list[index].first_name+" "+list[index].surname,style: TextStyle(fontSize: 20),),
                  onTap: () {
                    var result = Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(value: bloc,child: AddTest(person: list[index],index: index,),)));
                    result.then((value)  {
                      if(value){
                        setState(() {});
                      }
                    });
                  }
                ),
                subtitle: list[index].products.length==0 ? Text("Test eklemek için kişiye dokunun") : ListView.builder(
                    shrinkWrap: true,
                    itemCount: list[index].products.length,
                    itemBuilder: (context,index2){
                      var products = list[index2].products;
                      return ListTile(
                        title: GestureDetector(
                            child: Text(products[index2].product_name,style: TextStyle(fontSize: 20)),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(value: bloc,child: SelectSlotPage(person: list[index],index: index,index2: index2,),),))
                        ),
                        trailing: products[index2].slot==null ? Text("Randevu tarihi ekleyin",style: TextStyle(fontSize: 20)) : Text(DateTime.fromMillisecondsSinceEpoch(int.parse(products[index2].slot.slot_start)).toString(),style: TextStyle(fontSize: 20)),
                      );
                    },
                  ),
                );
            },
          ),
        ),
        RaisedButton(onPressed: () => bloc.add(ToAddPerson()),child: Text("Yeni kişi ekle"),)
      ],
    );
  }
 */