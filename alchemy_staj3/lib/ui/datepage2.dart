import 'dart:developer';

import 'package:alchemy_staj3/bloc/reservation/reservationBloc.dart';
import 'package:alchemy_staj3/bloc/reservation/reservationEvent.dart';
import 'package:alchemy_staj3/bloc/reservation/reservationState.dart';
import 'package:alchemy_staj3/data/persons.dart';
import 'package:alchemy_staj3/model/person.dart';
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
              var persons = Persons().reservationInfo.persons;
              if(persons==null){
                persons = List<Person>();
                Persons().reservationInfo.persons=persons;//null hatasını engellemek için
              }
              log(persons.length.toString());
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