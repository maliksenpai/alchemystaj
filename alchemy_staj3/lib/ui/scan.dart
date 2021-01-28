import 'dart:developer';

import 'package:alchemy_staj3/bloc/scan/scanBloc.dart';
import 'package:alchemy_staj3/bloc/scan/scanEvent.dart';
import 'package:alchemy_staj3/bloc/scan/scanState.dart';
import 'package:alchemy_staj3/ui/generate.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ScanPage();

}

class _ScanPage extends State<ScanPage>{
  ScanBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ScanBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("QR kod okuma"),),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Result(),
              RaisedButton(onPressed: () async{
                ScanResult codeScanner = await BarcodeScanner.scan();
                bloc.add(TakeQR(result: codeScanner.rawContent,code: codeScanner.type.value));
              },
                child: Text("QR kod okut"),
              ),
              RaisedButton(child: Text("QR kod oluştur"),onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider.value(value: bloc,child: GeneratePage(),))))
            ],
          ),
        )
      ),
    );
  }

  Widget Result(){
    return BlocConsumer<ScanBloc,ScanState>(
      cubit: bloc,
      listener: (context,state){
        state = bloc.state;
        if(state is CompleteState){
          return Center(child: Text("İşlem başarılı:"+state.result),);
        }else if(state is FailedState){
          return Center(child: Text(state.error),);
        }else if(state is InitState){
          return Center(child: Text("İşleme hazır!"),);
        }
      },
      builder: (context,state){
        state = bloc.state;
        if(state is CompleteState){
          return Center(child: Text("İşlem başarılı:"+state.result),);
        }else if(state is FailedState){
          return Center(child: Text(state.error),);
        }else if(state is InitState){
          return Center(child: Text("İşleme hazır!"),);
        }else{
          return Container();
        }
      },
    );
  }


}