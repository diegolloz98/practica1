part of 'Time_bloc.dart';



abstract class TimeState{}

class TimeInitial extends TimeState{

}
class TimeErrorState extends TimeState {
  final String errorMsg;

  TimeErrorState({required this.errorMsg});
  @override
  List<String?> get props => [errorMsg];
}

class TimeLoadingState extends TimeState{}

class TimeLoadedState extends TimeState{
  String time;
  TimeLoadedState({required this.time});
}
 
class TimeFailedToLoadState extends TimeState{
  String error;
  TimeFailedToLoadState({required this.error});
}