import 'package:alchemy_staj3/bloc/generate/generateEvent.dart';
import 'package:alchemy_staj3/bloc/generate/generateState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateBloc extends Bloc<GenerateEvent,GenerateState>{

  GenerateBloc() : super(InitState());

  @override
  Stream<GenerateState> mapEventToState(GenerateEvent event) {

  }

}