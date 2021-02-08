import 'package:alchemy_staj3/bloc/reservation/reservationBloc.dart';
import 'package:alchemy_staj3/bloc/reservation/reservationEvent.dart';
import 'package:alchemy_staj3/data/persons.dart';
import 'package:alchemy_staj3/model/e_order_details.dart';
import 'package:alchemy_staj3/model/person.dart';
import 'package:alchemy_staj3/model/slot.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class SelectSlotPage extends StatefulWidget {

  e_Order_Details order_detail;
  int index;

  SelectSlotPage({@required this.order_detail,@required this.index});

  @override
  State<StatefulWidget> createState() => _SelectSlot(order_detail: order_detail,index: index);

}

class _SelectSlot extends State<SelectSlotPage> {

  e_Order_Details order_detail;
  int index;

  _SelectSlot({@required this.order_detail,@required this.index});

  DateTime date = DateTime.now();
  List<String> times =
  [
    "08:00", "08:10", "08:20", "08:30", "08:40", "08:50",
    "09:00", "09:10", "09:20", "09:30", "09:40", "09:50",
    "10:00", "10:10", "10:20", "10:30", "10:40", "10:50",
    "11:00", "11:10", "11:20", "11:30", "11:40", "11:50",
    "12:00", "12:10", "12:20", "12:30", "12:40", "12:50",
    "13:00", "13:10", "13:20", "13:30", "13:40", "13:50",
    "14:00", "14:10", "14:20", "14:30", "14:40", "14:50",
    "15:00", "15:10", "15:20", "15:30", "15:40", "15:50",
    "16:00", "16:10", "16:20", "16:30", "16:40", "16:50",
    "17:00", "17:10", "17:20", "17:30", "17:40", "17:50",
  ];

  @override
  Widget build(BuildContext context) {
    times.forEach((element) {
      //print(element);
    });
    return Scaffold(
      appBar: AppBar(title: Text("Tarih seç"),),
      body: SafeArea(
        child: Column(
            children: [
              Container(height: 10,),
              GestureDetector(
                child: Text(
                      date.day.toString() + "/" + date.month.toString() + "/" +
                      date.year.toString(), style: TextStyle(fontSize: 30),),
                onTap: () => selectDate(),
              ),
              Container(height: 10,),
              Flexible(
                child: AlphabetListScrollView(
                  strList: times,
                  showPreview: true,
                  indexedHeight: (i) {
                    times.sort();
                    return 60;
                  },
                  itemBuilder: (context, selectedindex) {
                    return DecoratedBox(
                      child: ListTile(
                        title: Center(
                            child: GestureDetector(
                              child: Text(times[selectedindex], style: TextStyle(fontSize: 20),),
                              onTap: () => selectTime(times[selectedindex]),
                            )
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: selectedindex % 2 == 0 ? Colors.grey : Colors.white),
                    );
                  },
                ),
              )
            ]
        ),
      ),
    );
  }

  selectDate() {
    DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2030, 11, 11),
        locale: LocaleType.tr,
        //burası değişcek
        currentTime: DateTime.now(),
        onConfirm: (selectedDate) {
          setState(() {
            date = selectedDate;
          });
        }
    );
  }

  selectTime(String selectedtime) {
    DateFormat dateFormat = DateFormat("HH:mm");
    DateTime time = dateFormat.parse(selectedtime);
    DateTime startDate = new DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
    DateTime endDate = new DateTime(
        date.year, date.month, date.day, time.hour, time.minute + 10);
    int id;
    if(order_detail.slot_id==null){
      id = Persons().slot_id;
      id++;
      Persons().slot_id=id;
      order_detail.slot_id=id;
    }else{
      id =order_detail.slot_id;
    }

    Slot slot = Slot(
        id: id,
        slot_date: startDate.millisecondsSinceEpoch.toString(),
        slot_start: startDate.millisecondsSinceEpoch.toString(),
        slot_time_end: endDate.millisecondsSinceEpoch.toString(),
        slot_time_period: 10,
        active: false
    );

    ReservationBloc bloc = BlocProvider.of<ReservationBloc>(context);
    bloc.add(SelectSlot(slot: slot,order_detail: order_detail,index: index));
    Navigator.of(context).pop(true);
    //bloc.add(SelectSlot(slot: slot,person: person,index: index,index2: index2));
    //person.products[index2].slot = slot;

  }

/*selectTime(){
    showCustomTimePicker(
      onFailValidation: (context) => print("hata"),
      context: context,
      initialTime: TimeOfDay(hour: 10,minute: 0),
      selectableTimePredicate: (time)=>
          time.hour>=9&&
          time.hour<=17&&
          time.minute%10==0).then((value) => setState(() => {time=value}),
    );
  }*/


/*
AlphabetListScrollView(
                strList: times,
                showPreview: true,
                indexedHeight: (i){ return 60;},
                itemBuilder: (context,index){
                  return DecoratedBox(
                    child: ListTile(
                      title: Center(
                        child: Text(times[index],style: TextStyle(fontSize: 20),),
                      ),
                    ),
                    decoration: BoxDecoration(color: index%2==0 ? Colors.grey:Colors.white),
                  );
                },
              ),
 */

/*
AlphabetScrollView(
                list: times.map((e) => AlphaModel(e)).toList(),
                itemBuilder: (context,index,item){
                  return DecoratedBox(
                    child: ListTile(
                      title: Center(
                        child: GestureDetector(
                          child: Text(item,style: TextStyle(fontSize: 20),),
                          onTap: () => print(item),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(color: index%2==0 ? Colors.grey:Colors.white),
                  );
                },
              )
 */
}