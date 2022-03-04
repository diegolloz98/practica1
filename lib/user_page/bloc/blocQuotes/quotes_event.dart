part of 'quotes_bloc.dart';



abstract class QuotesEvent{}

class LoadEvent extends QuotesEvent{

}

class PullToRefreshEvent extends QuotesEvent{}
