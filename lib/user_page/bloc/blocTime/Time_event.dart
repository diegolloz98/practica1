part of 'Time_bloc.dart';



abstract class TimeEvent{}

class TimeLoadEvent extends TimeEvent{

}

class TimePullToRefreshEvent extends TimeEvent{}
