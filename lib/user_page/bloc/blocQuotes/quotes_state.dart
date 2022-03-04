part of 'quotes_bloc.dart';



abstract class QuotesState{}

class QuotesInitial extends QuotesState{

}

class LoadingState extends QuotesState{}

class LoadedState extends QuotesState{
  List<dynamic> quotes;
  LoadedState({required this.quotes});
}
 
class FailedToLoadState extends QuotesState{
  String error;
  FailedToLoadState({required this.error});
}