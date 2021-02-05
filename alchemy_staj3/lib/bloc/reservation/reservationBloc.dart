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
    log(event.toString());
    if(event is BackToInit){
      yield InitState();
    }else if(event is AddPerson){
      var list = Persons().reservationInfo.persons;
      list.add(event.person);
      Persons().reservationInfo.persons = list;
      yield InitState();
    }else if(event is AddProduct){
      Person person = event.person;
      person.products.add(event.l_product);
      Persons().reservationInfo.persons[event.index]=person;
      yield InitState();
    }else if(event is SelectSlot){
      //randevu tarihini ekleyecek
      Person person = event.person;
      person.products[event.index2].slot=event.slot;
      Persons().reservationInfo.persons[event.index]=person;
      yield InitState();
    }else if(event is SendOrder){
      //işlemi gönderecek
      yield FinishedState();
    }else if(event is ToAddPerson){
      yield AddPersonState();
    }
  }

}