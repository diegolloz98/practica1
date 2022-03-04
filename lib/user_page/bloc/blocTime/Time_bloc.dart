
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:io';

import 'package:practica1/user_page/api/getTime.dart';

part 'Time_event.dart';
part 'Time_state.dart';

class TimeBloc extends Bloc <TimeEvent, TimeState>{
  final _dataServie = DataService();
  String continent = "";
  String country = "";
  TimeBloc() : super(TimeLoadingState()){
    on<TimeEvent>((event, emit) async{
      if(event is TimeLoadEvent){
        emit(TimeLoadingState());
        try{
          String time = await _dataServie.getTime(continent, country);
          emit(TimeLoadedState(time: time));
        }catch(e){
          emit(TimeFailedToLoadState(error: e.toString()));
        }
      }
    });
  }
}
