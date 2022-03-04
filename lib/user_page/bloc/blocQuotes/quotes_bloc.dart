
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:io';

import 'package:practica1/user_page/api/getQuotes.dart';

part 'quotes_event.dart';
part 'quotes_state.dart';

class QuotesBloc extends Bloc <QuotesEvent, QuotesState>{
  final _dataServie = DataService();
  QuotesBloc() : super(LoadingState()){
    on<QuotesEvent>((event, emit) async{
      if(event is LoadEvent){
        emit(LoadingState());
        try{
          final quotes = await _dataServie.getQuotes();
          emit(LoadedState(quotes: quotes));
        }catch(e){
          emit(FailedToLoadState(error: e.toString()));
        }
      }
    });
  }
}
