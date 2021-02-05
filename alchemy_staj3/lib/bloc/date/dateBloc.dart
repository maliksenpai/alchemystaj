import 'package:alchemy_staj3/bloc/date/dateEvent.dart';
import 'package:alchemy_staj3/bloc/date/dateState.dart';
import 'package:alchemy_staj3/data/api/dates.dart';
import 'package:alchemy_staj3/model/date.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateBloc extends Bloc<DateEvent,DateState>{

  DateBloc() : super(InitState());

  @override
  Stream<DateState> mapEventToState(DateEvent event) async*{
    if(event is NewDateA){
      var currentdate = event.time;
      var dates = Dates().dates;
      bool check = true;
      dates.forEach((element) {
        if(element.time.year==currentdate.year && element.time.month==currentdate.month && element.time.day==currentdate.day && element.time.hour==currentdate.hour && element.time.minute==currentdate.minute){
          check=false;
        }
      });
      if(check){
        yield CompletedState(time: event.time,name: event.name,surname: event.surname,mail: event.surname,number: event.number);
      }else{
        yield FailedState(error: "Randevu saati uygun değil");
      }

    }else if(event is NewDateB){
      var currentdate = event.time;
      var dates = Dates().dates;
      bool check = true;
      dates.forEach((element) {
        if(element.time.year==currentdate.year && element.time.month==currentdate.month && element.time.day==currentdate.day && element.time.hour==currentdate.hour && element.time.minute==currentdate.minute){
          check=false;
        }
      });
      if(check){
        yield CompletedState(time: event.time,name: event.name,surname: event.surname,mail: event.surname,number: event.number);
      }else{
        yield FailedState(error: "Randevu saati uygun değil");
      }

    }else if(event is Finish){
      yield InitState();
    }
  }

}