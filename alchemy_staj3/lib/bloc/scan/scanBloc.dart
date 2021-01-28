import 'dart:developer';

import 'package:alchemy_staj3/bloc/scan/scanEvent.dart';
import 'package:alchemy_staj3/bloc/scan/scanState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanBloc extends Bloc<ScanEvent,ScanState>{


  ScanBloc() : super(InitState());

  @override
  Stream<ScanState> mapEventToState(ScanEvent event) async*{
    if(event is TakeQR){
      if(event.code==0){
        yield CompleteState(result: event.result);
      }else if(event.code==1){
        yield InitState();
      }else if(event.code==2){
        yield FailedState(error: "Hata oluştu");
      }
    }
  }

}