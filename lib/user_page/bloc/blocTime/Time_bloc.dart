
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
  TimeBloc() : super(TimeInitial()) {
    on<TimeEvent>(loadTime);
  }

  int index = 0;
  final _dataServie = DataService();


  void loadTime(TimeEvent event, Emitter emit) async{
    var time = await _dataServie.getTime(continent[index], country[index]);
    if (time == null) {
      emit(TimeErrorState(errorMsg: 'Error message'));
    } else {
      emit(TimeLoadedState(time: time));
    }
  }

}