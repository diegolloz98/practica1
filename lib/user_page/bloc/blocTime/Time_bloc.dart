
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:io';

import 'package:practica1/user_page/api/getTime.dart';

part 'Time_event.dart';
part 'Time_state.dart';

final continent = ["Europe", "America", "America", "America", "America"];
final country = ["Andorra", "Mexico_City", "Lima", "Vancouver", "Argentina"];

class TimeBloc extends Bloc <TimeEvent, TimeState>{
  int index = 0;
  final _dataServie = DataService();
  
  TimeBloc() : super(TimeLoadingState()){
    on<TimeEvent>((event, emit) async{
      if(event is TimeLoadEvent){
        emit(TimeLoadingState());
        try{
          String time = await _dataServie.getTime(continent[index], country[index]);
          emit(TimeLoadedState(time: time));
        }catch(e){
          emit(TimeFailedToLoadState(error: e.toString()));
        }
      }
    });
  }
}
