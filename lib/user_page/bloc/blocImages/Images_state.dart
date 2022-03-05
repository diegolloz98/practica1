part of 'Images_bloc.dart';

abstract class ImagesState{}

class ImagesInitial extends ImagesState{

}
class ImagesErrorState extends ImagesState {
  final String errorMsg;

  ImagesErrorState({required this.errorMsg});
  @override
  List<String?> get props => [errorMsg];
}

class ImagesLoadingState extends ImagesState{}

class ImagesLoadedState extends ImagesState{
  final Uint8List bytes;

  ImagesLoadedState({required this.bytes});
  @override
  List<Object?> get props => [bytes];
}
 
class ImagesFailedToLoadState extends ImagesState{
  String error;
  ImagesFailedToLoadState({required this.error});
}