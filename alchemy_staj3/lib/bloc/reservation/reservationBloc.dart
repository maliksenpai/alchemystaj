import 'dart:developer';

import 'package:alchemy_staj3/bloc/reservation/reservationEvent.dart';
import 'package:alchemy_staj3/bloc/reservation/reservationState.dart';
import 'package:alchemy_staj3/data/persons.dart';
import 'package:alchemy_staj3/model/person.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationBloc extends Bloc<ReservationEvent,ReservationState>{

  ReservationBloc() : super(InitState());



  @override
  Stream<ReservationState> mapEventToState(ReservationEvent event) async*{
    print(event.toString()+"x");
    if(event is BackToInit){
      yield InitState();
    }else if(event is AddPerson){
      var list = Persons().reservationInfo;
      list.add(event.person);
      Persons().reservationInfo = list;
      yield InitState();
    }else if(event is AddProduct){
      //Person person = event.person;
      //person.products.add(event.l_product);
      Persons().e_order_details.add(event.order_detail);
      //Persons().reservationInfo.persons[event.index]=person;
      yield InitState();
    }else if(event is SelectSlot){
      //randevu tarihini ekleyecek
      var list = Persons().e_order_details;
      print("xxxx"+event.order_detail.id.toString()+"-"+event.order_detail.slot_id.toString());
      //Persons().e_order_details[event.index]=event.order_detail;
      list[list.indexWhere((element) => element.id==event.order_detail.id)].slot_id=event.slot.id;
      Persons().e_order_details=list;
      Persons().slots.add(event.slot);
      //person.products[event.index2].slot=event.slot;
      //Persons().reservationInfo.persons[event.index]=person;
      yield InitState();
    }else if(event is SendOrder){
      //işlemi gönderecek
      yield FinishedState();
    }else if(event is ToAddPerson){
      yield AddPersonState();
    }else if(event is ChangeContactPerson){
      var list = Persons().reservationInfo;
      list.forEach((element) {
        if(element.person_id==event.id){
          element.is_contact_person=true;
        }else{
          element.is_contact_person=false;
        }
      });
      Persons().reservationInfo=list;
      yield InitState();
    }
  }

}