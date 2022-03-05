
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:io';

import 'package:practica1/user_page/api/getImages.dart';

part 'Images_event.dart';
part 'Images_state.dart';

final continent = ["Europe", "America", "America", "America", "America"];
final country = ["Andorra", "Mexico_City", "Lima", "Vancouver", "Argentina"];

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc() : super(ImagesInitial()) {
    on<ImagesEvent>(loadImages);
  }
  final _dataServie = DataService();


  void loadImages(ImagesEvent event, Emitter emit) async{
    var image = await _dataServie.getImages();
    if (image == null) {
      emit(ImagesErrorState(errorMsg: 'Error message'));
    } else {
      emit(ImagesLoadedState(bytes: image));
    }
  }

}