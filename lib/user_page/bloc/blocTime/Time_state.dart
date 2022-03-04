part of 'Time_bloc.dart';



abstract class TimeState{}

class TimeInitial extends TimeState{

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